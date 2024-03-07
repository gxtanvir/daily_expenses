import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthSrceenState();
  }
}

class _AuthSrceenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  bool _isLogin = true;
  var _userName = '';
  var _enteredEmail = '';
  var _enterdPassword = '';
  var _isAuthenticating = false;

  // Submit Method
  void _submit() async {
    var isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLogin) {
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enterdPassword);
      } else {
        final userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enterdPassword);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _userName,
          'email': _enteredEmail,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.code)));

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 174, 211, 144),
            Color.fromARGB(255, 121, 168, 82),
            Color.fromARGB(255, 140, 197, 96),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 20),
                  width: 300,
                  height: 250,
                  child: Image.asset(
                    'assets/images/expenses.png',
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
                            validator: (text) {
                              if (text != null &&
                                  text.trim().isNotEmpty &&
                                  text.contains('@')) {
                                return null;
                              }
                              return 'Enter a Valid Email';
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value != null &&
                                    value.trim().isNotEmpty &&
                                    value.trim().length >= 4) {
                                  return null;
                                }
                                return 'Username must be 4 character long';
                              },
                              onSaved: (newValue) {
                                _userName = newValue!;
                              },
                            ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (text) {
                              if (text != null &&
                                  text.trim().isNotEmpty &&
                                  text.length >= 6) {
                                return null;
                              }
                              return 'Password must be 6 character long';
                            },
                            onSaved: (newValue) {
                              _enterdPassword = newValue!;
                            },
                          ),
                          const SizedBox(height: 20),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                                onPressed: _submit,
                                child: Text(_isLogin ? 'Login' : 'Sign Up')),
                          const SizedBox(height: 10),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'Already have an account? Login.'))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
