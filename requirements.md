# WhatsApp Clone - Flutter & SQL Specification

## Project Overview
A full-featured WhatsApp clone built with Flutter for cross-platform mobile development and SQL for data persistence. The application will replicate core WhatsApp functionality including messaging, user authentication, media sharing, and real-time communication.

## Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Node.js with Express.js
- **Database**: SQLite (local) + PostgreSQL (server)
- **Real-time Communication**: WebSocket/Socket.io
- **Authentication**: JWT tokens
- **Media Storage**: Local storage + cloud storage (AWS S3/Firebase)
- **Push Notifications**: Firebase Cloud Messaging (FCM)

## Core Features

### 1. User Authentication & Profile Management
- **User Registration/Login**
  - Phone number verification via SMS
  - Email registration option
  - Password-based authentication
  - Biometric authentication (fingerprint/face ID)
  - JWT token management

- **Profile Management**
  - Profile picture upload/editing
  - Display name customization
  - Status/bio updates
  - Privacy settings
  - Account deletion

### 2. Contact Management
- **Contact Sync**
  - Import contacts from device
  - Search and add new contacts
  - Contact verification
  - Block/unblock users
  - Contact favorites

- **Contact List**
  - Alphabetical sorting
  - Search functionality
  - Online/offline status
  - Last seen timestamps
  - Profile picture display

### 3. Messaging System
- **Text Messages**
  - Real-time message delivery
  - Message status (sent, delivered, read)
  - Typing indicators
  - Message timestamps
  - Message search

- **Message Features**
  - Reply to specific messages
  - Forward messages
  - Copy message text
  - Delete messages (for self/for everyone)
  - Star important messages
  - Message reactions (emoji)

### 4. Media Sharing
- **Image Sharing**
  - Camera integration
  - Gallery selection
  - Image compression
  - Multiple image selection
  - Image preview

- **Video Sharing**
  - Video recording
  - Video selection from gallery
  - Video compression
  - Video preview
  - Video duration limits

- **Document Sharing**
  - PDF, DOC, XLS support
  - File size limits
  - File preview
  - Download functionality

- **Audio Messages**
  - Voice recording
  - Audio playback
  - Audio duration display
  - Background audio support

### 5. Group Chats
- **Group Management**
  - Create new groups
  - Add/remove members
  - Group admin controls
  - Group settings
  - Group description

- **Group Features**
  - Group profile picture
  - Group member list
  - Admin privileges
  - Group invite links
  - Group privacy settings

### 6. Calls
- **Voice Calls**
  - One-on-one voice calls
  - Group voice calls
  - Call quality indicators
  - Call duration
  - Call history

- **Video Calls**
  - One-on-one video calls
  - Group video calls
  - Camera switching
  - Video quality settings
  - Screen sharing

### 7. Status/Stories
- **Status Creation**
  - Text status
  - Image status
  - Video status
  - Status privacy settings
  - Status duration (24 hours)

- **Status Viewing**
  - Status list
  - Status replies
  - Status reactions
  - Status privacy controls

## Database Schema

### Users Table
```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    display_name VARCHAR(100),
    profile_picture_url TEXT,
    status_text VARCHAR(500),
    last_seen TIMESTAMP,
    is_online BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Contacts Table
```sql
CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    contact_user_id INTEGER,
    is_blocked BOOLEAN DEFAULT FALSE,
    is_favorite BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (contact_user_id) REFERENCES users(id)
);
```

### Chats Table
```sql
CREATE TABLE chats (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chat_type ENUM('individual', 'group') DEFAULT 'individual',
    name VARCHAR(100),
    profile_picture_url TEXT,
    last_message_id INTEGER,
    last_message_timestamp TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Chat_Participants Table
```sql
CREATE TABLE chat_participants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chat_id INTEGER,
    user_id INTEGER,
    role ENUM('member', 'admin') DEFAULT 'member',
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_id) REFERENCES chats(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Messages Table
```sql
CREATE TABLE messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chat_id INTEGER,
    sender_id INTEGER,
    message_type ENUM('text', 'image', 'video', 'audio', 'document') DEFAULT 'text',
    content TEXT,
    media_url TEXT,
    file_size INTEGER,
    duration INTEGER,
    reply_to_message_id INTEGER,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_id) REFERENCES chats(id),
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (reply_to_message_id) REFERENCES messages(id)
);
```

### Message_Status Table
```sql
CREATE TABLE message_status (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    message_id INTEGER,
    user_id INTEGER,
    status ENUM('sent', 'delivered', 'read') DEFAULT 'sent',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (message_id) REFERENCES messages(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Status_Updates Table
```sql
CREATE TABLE status_updates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    content TEXT,
    media_url TEXT,
    status_type ENUM('text', 'image', 'video') DEFAULT 'text',
    privacy ENUM('public', 'contacts', 'custom') DEFAULT 'public',
    expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

## Flutter App Architecture

### Project Structure
```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── routes.dart
├── core/
│   ├── constants/
│   ├── utils/
│   ├── services/
│   └── database/
├── features/
│   ├── auth/
│   ├── chat/
│   ├── contacts/
│   ├── calls/
│   └── status/
├── shared/
│   ├── widgets/
│   ├── models/
│   └── providers/
└── assets/
    ├── images/
    ├── icons/
    └── fonts/
```

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  # State Management
  provider: ^6.0.5
  # Database
  sqflite: ^2.3.0
  path: ^1.8.3
  # Network
  http: ^1.1.0
  dio: ^5.3.2
  # Real-time
  socket_io_client: ^2.0.3+1
  # UI Components
  cached_network_image: ^3.3.0
  image_picker: ^1.0.4
  video_player: ^2.7.2
  # Authentication
  local_auth: ^2.1.6
  # Notifications
  firebase_messaging: ^14.7.10
  # Media
  permission_handler: ^11.0.1
  file_picker: ^6.1.1
  # Utils
  intl: ^0.18.1
  uuid: ^4.0.0
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `POST /api/auth/verify-phone` - Phone verification
- `POST /api/auth/refresh-token` - Token refresh
- `PUT /api/auth/profile` - Update profile

### Contacts
- `GET /api/contacts` - Get user contacts
- `POST /api/contacts/sync` - Sync device contacts
- `POST /api/contacts/block` - Block user
- `DELETE /api/contacts/block` - Unblock user

### Chats
- `GET /api/chats` - Get user chats
- `POST /api/chats` - Create new chat
- `GET /api/chats/:id/messages` - Get chat messages
- `POST /api/chats/:id/messages` - Send message
- `PUT /api/chats/:id/messages/:messageId` - Update message
- `DELETE /api/chats/:id/messages/:messageId` - Delete message

### Groups
- `POST /api/groups` - Create group
- `PUT /api/groups/:id` - Update group
- `POST /api/groups/:id/members` - Add members
- `DELETE /api/groups/:id/members/:userId` - Remove member

### Status
- `GET /api/status` - Get status updates
- `POST /api/status` - Create status
- `DELETE /api/status/:id` - Delete status

## Security Features

### Data Protection
- End-to-end encryption for messages
- Secure file storage
- JWT token authentication
- Biometric authentication
- Data backup and recovery

### Privacy Controls
- Last seen privacy
- Profile picture privacy
- Status privacy settings
- Read receipts control
- Block/unblock functionality

## Performance Requirements

### App Performance
- App launch time: < 3 seconds
- Message delivery: < 1 second
- Image loading: < 2 seconds
- Smooth scrolling: 60 FPS
- Background sync: Every 15 minutes

### Database Performance
- Message queries: < 100ms
- Contact search: < 200ms
- Media upload: < 5 seconds for 10MB
- Offline functionality: Full support

## Testing Strategy

### Unit Testing
- Widget testing for UI components
- Service layer testing
- Database operation testing
- API integration testing

### Integration Testing
- End-to-end user flows
- Cross-platform compatibility
- Performance testing
- Security testing

### Manual Testing
- User acceptance testing
- Usability testing
- Device compatibility testing
- Network condition testing

## Deployment & Distribution

### Development Phases
1. **Phase 1**: Core messaging functionality
2. **Phase 2**: Media sharing and calls
3. **Phase 3**: Groups and status features
4. **Phase 4**: Advanced features and optimization

### Release Strategy
- Alpha testing with internal team
- Beta testing with selected users
- Staged rollout to production
- Continuous monitoring and updates

### App Store Deployment
- iOS App Store submission
- Google Play Store submission
- App store optimization (ASO)
- User feedback management

## Monitoring & Analytics

### Performance Monitoring
- Crash reporting (Firebase Crashlytics)
- Performance metrics
- User engagement analytics
- Error tracking

### User Analytics
- Daily/Monthly active users
- Message volume statistics
- Feature usage metrics
- User retention rates

## Future Enhancements

### Advanced Features
- Message encryption
- Voice messages transcription
- AI-powered smart replies
- Custom themes and stickers
- Business account features
- Payment integration
- Multi-device sync

### Platform Expansion
- Web application
- Desktop application
- Smartwatch integration
- Car integration
- IoT device support

## Success Metrics

### User Engagement
- Daily active users (DAU)
- Monthly active users (MAU)
- Average session duration
- Messages per user per day
- Media sharing frequency

### Technical Metrics
- App crash rate: < 1%
- API response time: < 500ms
- Message delivery success: > 99%
- App store rating: > 4.5 stars
- User retention: > 70% after 30 days

This specification provides a comprehensive roadmap for building a full-featured WhatsApp clone using Flutter and SQL, covering all essential features, technical requirements, and implementation details. 