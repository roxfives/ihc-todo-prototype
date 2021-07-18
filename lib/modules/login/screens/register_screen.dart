import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formEmailKey = GlobalKey<FormFieldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String _regitrationStatus = 'idle';

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
                      controller: _nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              AppLocalizations.of(context)!.display_name),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emptyField;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      key: _formEmailKey,
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              AppLocalizations.of(context)!.email_register),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emptyField;
                        } else if (_regitrationStatus == 'account-taken') {
                          return AppLocalizations.of(context)!
                              .account_already_exists;
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
                        } else if (_passwordConfirmController.text !=
                            _passwordController.text) {
                          return AppLocalizations.of(context)!
                              .password_must_be_equal;
                        } else if (_regitrationStatus == 'password-too-weak') {
                          return AppLocalizations.of(context)!
                              .password_too_weak;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordConfirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              AppLocalizations.of(context)!.password_confirm),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emptyField;
                        } else if (_passwordConfirmController.text !=
                            _passwordController.text) {
                          return AppLocalizations.of(context)!
                              .password_must_be_equal;
                        } else if (_regitrationStatus == 'password-too-weak') {
                          return AppLocalizations.of(context)!
                              .password_too_weak;
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          _updateRegistrationStatus(status: 'registering');
                          if (_formKey.currentState!.validate()) {
                            createAccount(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) => {
                                      if (value == null)
                                        {_formKey.currentState!.validate()}
                                      else
                                        {
                                          value.user?.updateDisplayName(_nameController.text),
                                          Navigator.of(context).popUntil((route) => route.isFirst),
                                          Navigator.popAndPushNamed(
                                              context, '/home'),
                                        }
                                    });
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.register)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                  child: Center(
                    child: Text(
                        AppLocalizations.of(context)!.unkown_error,
                        style: const TextStyle(color: Colors.red)),
                  ),
                  visible: _regitrationStatus == 'unknown-error'),
              SizedBox(height: 8),
              Visibility(
                  child: Center(
                    child: CircularProgressIndicator(
                      semanticsLabel:
                          AppLocalizations.of(context)!.sign_progress,
                    ),
                  ),
                  visible: _regitrationStatus == 'registering'),
            ],
          ),
        ),
      ),
    );
  }

  _updateRegistrationStatus({status: String}) {
    setState(() => {_regitrationStatus = status});
  }

  Future<UserCredential?> createAccount(
      {email: String, password: String}) async {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Account already existing');
        this._updateRegistrationStatus(status: 'account-taken');
      } else if (e.code == 'weak-password') {
        print('Senha muito fraca');
        this._updateRegistrationStatus(status: 'password-too-weak');
      }
       else {
        this._updateRegistrationStatus(status: 'unknown-error');
      }
    } catch (e) {
      print(e);
      this._updateRegistrationStatus(status: 'unknown-error');
    }

    return userCredential;
  }
}
