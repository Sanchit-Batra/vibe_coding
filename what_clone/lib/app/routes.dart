import 'package:flutter/material.dart';

// Example screens (to be implemented in their respective files)
import '../features/auth/auth_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/contacts/contacts_screen.dart';
import '../features/calls/calls_screen.dart';
import '../features/status/status_screen.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String chat = '/chat';
  static const String contacts = '/contacts';
  static const String calls = '/calls';
  static const String status = '/status';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case contacts:
        return MaterialPageRoute(builder: (_) => const ContactsScreen());
      case calls:
        return MaterialPageRoute(builder: (_) => const CallsScreen());
      case status:
        return MaterialPageRoute(builder: (_) => const StatusScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for \\${settings.name}')),
          ),
        );
    }
  }
} 