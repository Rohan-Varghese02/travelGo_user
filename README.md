# 🎉 TravLGO

**TravLGO** is a powerful and user-friendly **event booking application** built with **Flutter**. It enables users to explore events, book tickets, receive reminders, interact in real-time with organizers or other attendees, and even join virtual sessions—all in one seamless app.

---

## 📖 Table of Contents
- [Description](#description)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

---

## 📝 Description

TravLGO simplifies how users discover and participate in events. From concerts and conferences to virtual meetups, TravLGO lets users book, chat, and attend—all from the comfort of their device.

Whether it's attending a live concert or joining a virtual workshop, TravLGO brings the entire event lifecycle to your fingertips.

---

## ✨ Features

- 🔍 **Browse Events** – Explore upcoming events by category or location  
- 🎫 **Ticket Booking** – Reserve spots and confirm your presence instantly  
- 🔔 **Reminders** – Never miss an event with timely push notifications  
- 💬 **Real-Time Chat** – Connect with organizers or other attendees using WebSockets  
- 💳 **Secure Payments** – Integrated Razorpay for smooth ticket transactions  
- 📅 **Event Calendar** – Track your bookings using an intuitive calendar UI  
- 🎥 **Virtual Sessions** – Join live online events using Agora video calls  
- 🔒 **Secure Storage** – Store sensitive data securely using Flutter Secure Storage  

---

## 🛠️ Technologies Used

- **Flutter** – Cross-platform UI toolkit  
- **Dart** – Language for building apps with Flutter  
- **BLoC** – Predictable state management with `flutter_bloc`  
- **Flutter Secure Storage** – For handling sensitive data locally  
- **HTTP** – For RESTful API interactions  
- **Socket.IO** – For real-time communication  
- **Agora RTC/RTM** – For video and real-time messaging  
- **Razorpay Flutter** – Seamless payment gateway integration  
- **TableCalendar** – Beautiful calendar UI  
- **Lottie Animations** – For delightful UI/UX  
- **Firebase Core** – Backend services integration (if used)

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.6
  http: ^1.2.2
  flutter_secure_storage: ^9.2.2
  dart_jsonwebtoken: ^2.14.1
  table_calendar: ^3.1.3
  intl: ^0.19.0
  razorpay_flutter: ^1.3.7
  permission_handler: ^11.3.1
  agora_rtc_engine: ^6.5.0
  socket_io_client: ^3.0.2
  flutter_markdown: ^0.7.4+3
  image_picker: ^1.1.2
  http_parser: ^4.0.2
  lottie: ^3.1.3
  agora_rtm: ^1.5.9
  flutter_launcher_icons: ^0.14.3
  firebase_core: ^3.4.0
