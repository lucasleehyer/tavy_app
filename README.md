
# TAVY – AI-Powered Productivity App

TAVY is an AI-enhanced productivity chat app inspired by the simplicity and privacy of Signal, built to help users manage tasks and reminders through natural conversations. Users can create, assign, and sync tasks with calendars — all inside a familiar messaging interface.

---

## 🚀 Key Features

- **Signal-style Messaging UI**: Clean, fast chat interface with reactions, replies, message edits.
- **Chat-Based Task Input**: Users can type “@Tavy remind @Alex to send report by Friday 3PM”.
- **AI Task Parsing**: Detects `/task`, "remind", @mentions, dates/times — and extracts structured tasks.
- **Google Calendar Sync**: Tasks with due dates become calendar events, with attendees.
- **Nudging & Escalation**: AI follows up on late tasks, escalates to team or admin if needed.
- **Push Notifications**: For reminders, task assignments, follow-ups.
- **Role-Based Views**: Admin, Contributor, Observer roles control access and view.
- **Dev Login Mode**: Bypass OTP in development mode for rapid testing.

---

## 🔐 Authentication Flow

### ✅ Phase 1 (Live):
- **Mobile OTP Login via Firebase**:
  - Enter mobile number
  - Receive and verify OTP
  - If new, go through `ProfileSetupScreen`

### 🔄 Phase 2 (Later):
- **Optional Google Login (backup/fallback)**

### 🧪 Dev Mode:
- When `devMode = true`, show “Dev Login” button
- Log in a mock user `userId: dev123`, skip Firebase
- Toggle via `--dart-define=devMode=true`

---

## 📱 Screens

| Screen | Description |
|--------|-------------|
| `LoginScreen` | OTP login with Dev Login button (if enabled) |
| `ChatListScreen` | List of chats with unread badges |
| `ChatScreen` | Signal-style messaging, task creation inline |
| `TaskBoardScreen` | Sort and filter all assigned/created tasks |
| `ReminderCenterScreen` | Upcoming due tasks, overdue nudges |
| `ProfileSetupScreen` | First-time setup after login |
| `SettingsScreen` | User profile, calendar link, notifications |

---

## 💬 Chat + Task Architecture

### Firestore Structure

```
users/{userId}
  displayName, phone, role, googleLinked

chats/{chatId}
  title, participants, type (group|direct)

chats/{chatId}/messages/{messageId}
  senderId, text, timestamp, replyTo, reactions, isTask, taskMeta

tasks/{taskId}
  chatId, createdBy, assignedTo, dueDate, priority, linkedMessageId
```

---

## 🔁 Calendar Sync Flow

- AI identifies tasks with dates → creates GCal event via Firebase Function
- Event owner = creator, attendees = @mentions
- Event link is stored in Firestore task document

---

## ⚙️ Tech Stack

- **Flutter** for cross-platform UI
- **Firebase** (Auth, Firestore, Notifications, Functions)
- **OpenAI / Gemini** for task parsing and nudge logic
- **Google Calendar API** for syncing events

---

## 📁 Suggested Repo Structure

```
lib/
├── models/
│   ├── user_model.dart
│   ├── message_model.dart
│   └── task_model.dart
├── screens/
│   ├── chat_screen.dart
│   ├── chat_list_screen.dart
│   ├── task_board_screen.dart
│   ├── login_screen.dart
│   ├── otp_verification_screen.dart
│   ├── profile_setup_screen.dart
├── services/
│   ├── ai_parser_service.dart
│   ├── firestore_service.dart
│   ├── calendar_service.dart
│   └── notification_service.dart

firebase/
├── functions/
│   └── onTaskCreatedToCalendar.js
└── firestore.rules
```

---

## ✅ Next Steps for Jules

1. Scaffold Flutter project structure
2. Implement OTP login + dev login toggle
3. Build chat + message model
4. Create AI task parser and link to calendar
5. Add push notifications + reminder logic
6. Build role-based views and settings screen
