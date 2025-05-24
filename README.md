# TAVY App – Complete Feature Specification

TAVY is an AI-powered productivity assistant inspired by modern messaging apps like Signal. It integrates chat, reminders, AI task parsing, calendar sync, and intelligent nudging into a single interface.

---

## 📌 Overview

This document captures the full feature specification of the TAVY application, including authentication, AI functionality, task management, role-based access, notifications, and future SaaS adaptability.

---

## 🔑 Key Features

- OTP Login + Dev login bypass
- Signal-style chat interface
- Task creation via natural language
- AI parsing of tasks using OpenAI
- Calendar sync (Google Calendar API)
- Smart reminder + nudge + escalation logic
- Role-based dashboards
- Push notifications
- Candidate and CV tracking (optional HR extension)
- API-first structure, SaaS-ready

---

## 🔐 Auth Options

- Firebase OTP login
- Dev Login (`devMode = true`) for testing
- Optional Gmail backup (Phase 2)

---

## 📱 Modules

- `chat_ui/` – Flutter chat interface
- `ai_task_parser/` – NLP + OpenAI integration
- `calendar_sync/` – Firebase Function + GCal
- `notifications/` – FCM + reminder logic
- `auth/` – OTP + Dev login
- `settings/` – Notification toggle + calendar link

---

## ⚙️ Tech Stack

- Flutter + Dart
- Firebase (Auth, Firestore, Functions, FCM)
- OpenAI (GPT-4o)
- Google Calendar API
- Deepgram (for English test modules)

---

## 📁 Suggested Structure

```
lib/
├── screens/
├── models/
├── widgets/
├── services/
firebase/
├── functions/
assets/
README.md
```

---

## 🧠 AI Examples

- “Remind @Lucas to submit deck by Friday” →  
  `{{task: 'Submit deck', assignee: 'Lucas', due: 'Friday'}}`

- “/task Call client before 3PM tomorrow” →  
  Parsed and stored with escalation enabled

---

## 🔔 Notifications + Escalation

- Reminder: 15 min before task
- Day 1: nudge assignee
- Day 2: alert creator
- Day 3: escalate to admin

---

## 📅 Calendar Sync

- Auto-create events when due dates detected
- Owner: message sender
- Attendees: @mentioned users

---

## 💳 SaaS Subscription Model

- Free: Dev login mode
- Paid: AI credits (per applicant or team)
- Tiered billing (recruiters vs companies)

---

## ✅ Start Instructions

Once this file is pushed to your GitHub repo:
1. Ask Codex to read this `README.md`
2. Tell Codex to scaffold Flutter + Firebase
3. Begin implementation with `auth/` and `chat_ui/`

---
