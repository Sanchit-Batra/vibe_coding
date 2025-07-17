import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Example provider (to be implemented in shared/providers)
import '../shared/providers/auth_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers here
      ],
      child: MaterialApp(
        title: 'WhatsApp Clone',
        // Add your theme and routes here
        // onGenerateRoute: AppRoutes.generateRoute,
        home: const Placeholder(), // Replace with your initial screen
      ),
    );
  }
} 