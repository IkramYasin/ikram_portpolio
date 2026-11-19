import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../services/portfolio_store.dart';

const String kAdminEmail = 'ikramyaseenbaloch64@gmail.com';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _email = TextEditingController(text: kAdminEmail);
  final _password = TextEditingController();
  final _json = TextEditingController();
  bool _loading = false;
  bool _creatingAccount = false;
  String _message = '';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _json.dispose();
    super.dispose();
  }

  Map<String, dynamic> _exportData() {
    return {
      'name': kName,
      'email': kEmail,
      'github': kGithub,
      'linkedin': kLinkedin,
      'projects': [
        for (final item in kProjects)
          {
            'title': item.title,
            'category': item.category,
            'symbol': item.symbol,
            'description': item.description,
            'technologies': item.technologies,
            'status': item.status,
            'github': item.github,
            'demo': item.demo,
          },
      ],
      'skills': [
        for (final item in kSkills) {'title': item.title, 'tags': item.tags},
      ],
      'training': [
        for (final item in kTraining)
          {
            'provider': item.provider,
            'title': item.title,
            'courseUrl': item.courseUrl,
            'certificateUrl': item.certificateUrl,
          },
      ],
      'certificates': [
        for (final item in kCertificates)
          {
            'title': item.title,
            'provider': item.provider,
            'courseUrl': item.courseUrl,
            'verificationUrl': item.verificationUrl,
          },
      ],
    };
  }

  Future<void> _loadContent() async {
    setState(() => _loading = true);
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('portfolio')
          .doc('content')
          .get();
      final data = snapshot.exists ? snapshot.data() ?? {} : _exportData();
      _json.text = const JsonEncoder.withIndent('  ').convert(data);
    } on FirebaseException catch (error) {
      setState(() => _message = 'Could not load portfolio: ${error.message}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _authenticate() async {
    final email = _email.text.trim().toLowerCase();
    final password = _password.text;
    if (email != kAdminEmail) {
      setState(
        () => _message =
            'Only the configured admin account can access this page.',
      );
      return;
    }
    if (password.length < 6) {
      setState(() => _message = 'Password must be at least 6 characters.');
      return;
    }

    setState(() {
      _loading = true;
      _message = '';
    });
    try {
      if (_creatingAccount) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      await _loadContent();
    } on FirebaseAuthException catch (error) {
      setState(() => _message = error.message ?? 'Authentication failed.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    setState(() {
      _loading = true;
      _message = '';
    });
    try {
      final data = jsonDecode(_json.text);
      if (data is! Map) {
        throw const FormatException('Content must be a JSON object.');
      }
      final normalized = Map<String, dynamic>.from(data);
      await PortfolioStore.save(normalized);
      PortfolioStore.apply(normalized);
      setState(() => _message = 'Portfolio published successfully.');
    } on FormatException catch (error) {
      setState(() => _message = 'Invalid JSON: ${error.message}');
    } on FirebaseException catch (error) {
      setState(() => _message = 'Could not publish: ${error.message}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ikram Portfolio Admin'),
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox.shrink();
              return TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  _json.clear();
                  setState(() => _message = '');
                },
                child: const Text('Sign out'),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (user == null) return _login();
          if (user.email?.toLowerCase() != kAdminEmail) {
            FirebaseAuth.instance.signOut();
            return _login(message: 'This account is not authorized.');
          }
          if (_json.text.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _loadContent();
            });
          }
          return _editor();
        },
      ),
    );
  }

  Widget _login({String? message}) {
    if (message != null) _message = message;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: Panel(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Admin sign in', style: AppText.display(size: 24)),
              const SizedBox(height: 18),
              TextField(
                controller: _email,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Admin email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 18),
              AppButton(
                label: _creatingAccount ? 'Create admin account' : 'Sign in',
                primary: true,
                onTap: _loading ? () {} : _authenticate,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    setState(() => _creatingAccount = !_creatingAccount),
                child: Text(
                  _creatingAccount
                      ? 'Use existing account'
                      : 'Create account for the first time',
                ),
              ),
              if (_message.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  _message,
                  style: AppText.body(size: 12, color: AppColors.cyan),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _editor() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Portfolio content',
                  style: AppText.display(size: 22),
                ),
              ),
              AppButton(
                label: 'Save & publish',
                primary: true,
                onTap: _loading ? () {} : _save,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_message.isNotEmpty)
            Text(
              _message,
              style: AppText.body(size: 12, color: AppColors.cyan),
            ),
          const SizedBox(height: 12),
          Expanded(
            child: TextField(
              controller: _json,
              expands: true,
              maxLines: null,
              minLines: null,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'Portfolio JSON',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
