import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/domain/usecases/sign_out_usecase.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser?.email ?? 'NULL');
    return Scaffold(
      appBar: AppBar(
        title: Text('Naqaa\''),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                initSignOut();
                await instance<SignOutUsecase>().execute(null);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
