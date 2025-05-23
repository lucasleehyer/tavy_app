
# TAVY – AI-Powered Productivity App

TAVY is an AI-enhanced productivity chat app designed to help users manage tasks and reminders through natural language interactions. The app allows users to create and assign tasks, receive AI-generated summaries, and sync with calendars — all within a familiar messaging interface.

---

## 🧩 Key Features

- **Chat-Based Task Input**: Users can type things like “@Tavy remind @Alex to send the report by Friday 3PM”.
- **AI Parsing**: Uses OpenAI/Gemini to turn freeform text into structured tasks.
- **Task & Reminder Management**: Create, assign, and track tasks using @mentions and deadlines.
- **Google Calendar Sync**: Automatically sync tasks with due dates to calendar events.
- **Nudging & Follow-Up**: If a task is overdue, TAVY will nudge the assignee or escalate to the team.
- **Push Notifications**: Real-time updates for task assignments and status.
- **Role-Based Views**: Personalized dashboards for admins, contributors, and observers.

---

## ⚙️ Tech Stack

- **Flutter** (cross-platform mobile/web app)
- **Firebase** (Auth, Firestore, Notifications)
- **OpenAI / Gemini API** (natural language understanding)
- **Google Calendar API**

---

## 📁 Suggested Repo Structure

```
lib/
├── screens/
├── widgets/
├── models/
├── services/
└── main.dart

firebase/
├── functions/
└── firestore.rules
```

---

## 🚀 Next Steps for Jules

1. Scaffold Flutter project structure
2. Set up Firebase integration
3. Generate modules: chat_ui, ai_task_parser, calendar_sync, notifications
4. Start with chat input UI + Firestore write
5. Add AI task parsing + OpenAI API
6. Add Calendar sync + reminder nudge logic
