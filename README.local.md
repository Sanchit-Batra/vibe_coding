# WhatsApp Clone

A full-featured WhatsApp clone built with Flutter, Node.js/Express, and PostgreSQL. This project demonstrates real-time messaging, group chats, media sharing, calls, status updates, and secure authentication.

## Features
- User authentication (phone/email, JWT, biometrics)
- Real-time 1:1 and group messaging
- Media sharing (images, videos, documents, audio)
- Voice and video calls
- Status/stories (text, image, video)
- Contact sync and management
- Push notifications (FCM)
- End-to-end encryption (planned)

## Tech Stack
- **Frontend:** Flutter (Dart)
- **Backend:** Node.js, Express.js
- **Database:** PostgreSQL, SQLite (local)
- **Real-time:** Socket.io
- **Notifications:** Firebase Cloud Messaging

## Project Structure
```
/what_clone         # Flutter app
/backend            # Node.js/Express backend
/backend/postgres_db # Postgres DB scripts/config
```

## Getting Started

### Prerequisites
- Flutter SDK
- Node.js & npm
- PostgreSQL

### Setup
1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd testing DELETE
   ```
2. **Flutter app:**
   ```sh
   cd what_clone
   flutter pub get
   flutter run
   ```
3. **Backend:**
   ```sh
   cd ../backend
   npm install
   npm start
   ```
4. **Database:**
   - Configure PostgreSQL connection in backend/.env
   - Run migration scripts in backend/postgres_db as needed

## Usage
- Register/login with phone or email
- Chat in real-time, create groups, share media
- Make voice/video calls
- Post and view status updates

## Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](LICENSE)

---

> This project is for educational purposes and rapid prototyping. Not affiliated with WhatsApp or Meta. 