import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _signInValdiationStatus = 'idle';

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: SvgPicture.asset("assets/images/logo.svg"),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.username),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emptyField;
                        } else if (_signInValdiationStatus == 'invalid') {
                          return AppLocalizations.of(context)!.sign_in_failed;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.password),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emptyField;
                        } else if (_signInValdiationStatus == 'invalid') {
                          return AppLocalizations.of(context)!.sign_in_failed;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          _updateSignInStatus(status: 'validating');
                          if (_formKey.currentState!.validate()) {
                            signIn(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) => {
                                      if (value == null)
                                        {
                                          _updateSignInStatus(
                                              status: 'invalid'),
                                          _formKey.currentState!.validate()
                                        }
                                      else
                                        {
                                          Navigator.popAndPushNamed(
                                              context, '/home')
                                        }
                                    })
                                .whenComplete(() => {});
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.login)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                child: Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: AppLocalizations.of(context)!.sign_progress,
                  ),
                ),
                visible: _signInValdiationStatus == 'validating',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateSignInStatus({status: String}) {
    setState(() => {_signInValdiationStatus = status});
  }

  Future<UserCredential?> signIn({email: String, password: String}) async {
    UserCredential? userCredential;

    await Future.delayed(const Duration(seconds: 1), () => "1");

    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }

    return userCredential;
  }
}
