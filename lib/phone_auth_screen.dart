import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? _verificationId;
  bool _codeSent = false;
  bool _loading = false;
  String? _statusMessage;

  Future<void> _sendCode() async {
    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    final phone = phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() {
        _loading = false;
        _statusMessage = "Enter phone number";
      });
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _loading = false;
          _statusMessage = "Verification failed: ${e.message}";
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
          _loading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _verifyCode() async {
    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    final code = otpController.text.trim();
    if (_verificationId == null || code.isEmpty) {
      setState(() {
        _loading = false;
        _statusMessage = "Enter OTP";
      });
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );
      await _signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loading = false;
        _statusMessage = "OTP failed: ${e.message}";
      });
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userDoc.set({
        'uid': user.uid,
        'phone': user.phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }

    setState(() {
      _loading = false;
      _statusMessage = "✅ Signed in successfully";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            if (_codeSent)
              TextField(
                controller: otpController,
                decoration: const InputDecoration(labelText: 'OTP'),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _codeSent ? _verifyCode : _sendCode,
                    child: Text(_codeSent ? 'Verify OTP' : 'Send OTP'),
                  ),
            if (_statusMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _statusMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}



