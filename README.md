# 💬 Flutter Firebase Chat App

A real-time chat application built with Flutter and Firebase. This project is based on a [YouTube tutorial](https://www.youtube.com/watch?v=5xU5WH2kEc0), but significantly extended with **Clean Architecture**, **BLoC/Cubit** state management, and **Dependency Injection** — patterns that were not present in the original tutorial.

---

## ✨ Features

- 🔐 **Authentication** — Register and log in with email & password via Firebase Auth
- 💬 **Real-time Messaging** — Send and receive messages instantly using Firestore streams
- ✍️ **Typing Indicator** — Live "typing..." indicator shown when the other user is actively typing
- 🕐 **Formatted Timestamps** — Message timestamps displayed in a clean `h:mm a` format (e.g. `2:30 PM`) using the `intl` package
- 👥 **User List** — Browse all registered users (excluding the currently logged-in user)
- 🚪 **Auth Gate** — Automatically routes users to login or home based on their authentication state

---

## 🏗️ Architecture

This project follows a **layered clean architecture** approach, which was added on top of the original tutorial's structure:

```
UI Layer (Pages)
      ↓
Logic Layer (Cubit / BLoC)
      ↓
Repository Layer (abstracts data sources)
      ↓
Service Layer (Firebase communication)
```

Each feature is self-contained under `lib/features/`, with its own `cubit/` and `repository/` directories.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| [Flutter](https://flutter.dev) | UI framework |
| [Firebase Auth](https://firebase.google.com/products/auth) | User authentication |
| [Cloud Firestore](https://firebase.google.com/products/firestore) | Real-time database |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management (Cubit) |
| [get_it](https://pub.dev/packages/get_it) | Dependency injection |
| [intl](https://pub.dev/packages/intl) | Date/time formatting |
| [equatable](https://pub.dev/packages/equatable) | Value equality for states |

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── di/               # Dependency injection setup (GetIt)
│   ├── models/           # Shared data models (UserModel, Message)
│   ├── services/
│   │   ├── auth/         # Firebase Auth service
│   │   └── chat/         # Firestore chat & typing service
│   ├── theme/            # App theme (light mode)
│   ├── utils/            # Validators, shared utilities
│   └── widgets/          # Reusable widgets (e.g. AppTextField)
│
├── features/
│   ├── auth/             # Auth gate, cubit, repository
│   ├── login/            # Login page & cubit
│   ├── register/         # Register page & cubit
│   ├── home/             # User list page, cubit, repository
│   ├── chat/             # Chat page, cubit, repository
│   └── settings/         # Settings page
│
├── firebase_options.dart
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.12.2`
- A Firebase project with **Authentication** (email/password) and **Firestore** enabled

### Setup

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd chat_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable **Email/Password** sign-in under Authentication
   - Create a **Firestore** database
   - Run the FlutterFire CLI to generate `firebase_options.dart`:
     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🔥 Firestore Data Structure

```
Users/
  {uid}/
    uid: string
    email: string
    userName: string

chat_rooms/
  {uid1_uid2}/           # Sorted & joined user UIDs
    typing_{uid}: bool   # Per-user typing status
    messages/
      {messageId}/
        senderID: string
        senderEmail: string
        receiverID: string
        message: string
        createdAt: timestamp
```

---

## 🎓 Original Tutorial

This app was inspired by the following tutorial:

> **Flutter Chat App Tutorial** — [Watch on YouTube](https://www.youtube.com/watch?v=5xU5WH2kEc0)

### What was added beyond the tutorial

| Feature | Tutorial | This Project |
|---|---|---|
| State Management | ❌ (setState / streams) | ✅ BLoC / Cubit |
| Clean Architecture | ❌ | ✅ Service → Repository → Cubit → UI |
| Dependency Injection | ❌ | ✅ GetIt |
| Typing Indicator | ❌ | ✅ Real-time Firestore streams |
| Formatted Timestamps | ❌ | ✅ `intl` package (`h:mm a`) |
| Password Validation Cubit | ❌ | ✅ |

---

## 📄 License

This project is for educational purposes. Feel free to use and extend it.
