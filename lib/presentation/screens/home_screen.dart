import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naqaa\''),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.go(Routes.loginRoute);
          },
          child: Text('Login Screen'),
        ),
      ),
    );
  }
}
