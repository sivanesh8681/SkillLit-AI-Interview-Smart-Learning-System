// lib/screens/email_verification_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});
  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Timer? _pollTimer;
  bool _checking = false;
  bool _resending = false;
  String _uid = '';

  @override
  void initState() {
    super.initState();
    // uid is passed as route arg
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is String) {
        _uid = arg;
      }
      _startPolling();
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await _checkVerified();
    });
  }

  Future<void> _checkVerified() async {
    setState(() => _checking = true);
    try {
      final user = _auth.currentUser;
      if (user == null) return;
      await user.reload(); // refresh state
      if (user.emailVerified) {
        // mark emailVerified true in Firestore
        if (_uid.isNotEmpty) {
          await _db.collection('users').doc(_uid).set({'emailVerified': true}, SetOptions(merge: true));
        }
        _pollTimer?.cancel();
        Fluttertoast.showToast(msg: 'Email verified — Welcome!');
        // navigate to onboarding or home
        Navigator.pushReplacementNamed(context, '/home');
      }
    } finally {
      setState(() => _checking = false);
    }
  }

  Future<void> _resendEmail() async {
    setState(() => _resending = true);
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Fluttertoast.showToast(msg: 'Verification email resent');
      } else {
        Fluttertoast.showToast(msg: 'No user or already verified');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Send failed: $e');
    } finally {
      setState(() => _resending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Almost there')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          const Text('We sent a verification link to your email.'),
          const SizedBox(height: 12),
          const Text('Please open your email and click the verification link. Once done, this page will detect it automatically.'),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _resending ? null : _resendEmail, child: _resending ? const CircularProgressIndicator() : const Text('Resend verification email')),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _checkVerified, child: _checking ? const CircularProgressIndicator() : const Text('I have verified, continue')),
          const SizedBox(height: 20),
          TextButton(onPressed: () async {
            // allow user to sign out if something wrong
            await _auth.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          }, child: const Text('Cancel & go back')),
        ]),
      ),
    );
  }
}
