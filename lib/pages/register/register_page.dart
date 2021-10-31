import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/environment.dart';
import 'package:nexmat/data_models/rest_error.dart';
import 'package:nexmat/data_models/user.dart';
import 'package:nexmat/pages/dashboard/dashboard_page.dart';
import 'package:nexmat/pages/onboarding/select_location_page.dart';
import 'package:nexmat/pages/register/register_page.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/utils/snackbar_helper.dart';
import 'package:nexmat/widgets/app_buttons/app_primary_button.dart';
import 'package:nexmat/widgets/app_loader.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27-10-2021 03:41 PM
///
class RegisterPage extends StatefulWidget {
  static const routeName = '/register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> _btnKey = GlobalKey();
  bool _obscureText = false, _isVendor = false;
  String? _email, _password, _name, _confirmPassword;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              SizedBox(height: height / 10),
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _name = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _email = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  } else {
                    if (!GetUtils.isEmail(s.trim())) {
                      return 'Not a valid email Id.';
                    }
                  }
                },
                decoration: const InputDecoration(labelText: 'Email Id'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: _obscureText,
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  } else {
                    _password = s;
                  }
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                keyboardType: TextInputType.visiblePassword,
                onSaved: (s) {
                  _password = s?.trim();
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off))),
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: _obscureText,
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  } else if (_password != s) {
                    return "Passwords did not match";
                  }
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (s) => _login(),
                keyboardType: TextInputType.visiblePassword,
                onSaved: (s) {
                  _confirmPassword = s?.trim();
                },
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off))),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("User"),
                  Switch(
                      value: _isVendor,
                      onChanged: (b) {
                        setState(() {
                          _isVendor = b;
                        });
                      }),
                  const Text("Vendor"),
                ],
              ),
              const SizedBox(height: 32),
              AppPrimaryButton(
                child: const Text("Sign up"),
                onPressed: _login,
                key: _btnKey,
              ),
              const SizedBox(height: 38),
              const Center(
                  child: Text(
                "- Or Sign up with -",
                style: TextStyle(color: Colors.grey),
              )),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: signUpWithGoogle,
                      child: SvgPicture.asset(AppAssets.google)),
                  const SizedBox(width: 16),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(AppAssets.facebook)),
                ],
              ),
              const SizedBox(height: 22),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(style: theme.textTheme.bodyText1, children: [
                      const TextSpan(text: 'Already have an account?'),
                      TextSpan(
                          text: ' Sign in',
                          style: const TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            }),
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    final state = _formKey.currentState;
    if (state == null) return;
    if (state.validate()) {
      state.save();
      _btnKey.currentState?.showLoader();
      try {
        final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email!, password: _confirmPassword!);
        if (res.user != null) {
          final user = UserDatum(
              uid: res.user!.uid,
              email: _email!,
              name: _name!,
              type: _isVendor ? 1 : 2,
              createdAt: DateTime.now());
          await FirebaseFirestore.instance
              .collection("CustomerDetails")
              .doc(res.user!.email)
              .set({
            "customerName": user.name,
            "userUID": res.user!.uid,
            "userTypeID": user.type,
            "edited": user.createdAt,
            "email": user.email,
            "userType": user.type == 1 ? "Vendor" : "Customer",
          });
          SharedPreferenceHelper.storeUser(user);
          Get.offAllNamed(SelectLocationPage.routeName);
        } else {
          SnackBarHelper.show("Some error occurred");
        }
      } catch (e) {
        SnackBarHelper.show(parseFirebaseError(e));
      } finally {
        _btnKey.currentState?.hideLoader();
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> signUpWithGoogle() async {
    GoogleSignIn _googleSignIn =
        GoogleSignIn(scopes: ['email'], clientId: Environment.googleClientId);
    Get.key.currentState?.push(LoaderOverlay());
    try {
      GoogleSignInAccount? result = await _googleSignIn.signIn();
      if (result == null) {
        return null;
      }
      GoogleSignInAuthentication googleAuth = await result.authentication;
      log('TOKEN ${googleAuth.accessToken}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (res.user != null) {
        final user = UserDatum(
            uid: res.user!.uid,
            email: res.user!.email ?? "",
            name: res.user!.displayName ?? "",
            type: 2,
            createdAt: DateTime.now());
        await FirebaseFirestore.instance
            .collection("CustomerDetails")
            .doc(res.user!.email)
            .set({
          "customerName": user.name,
          "userUID": res.user!.uid,
          "userTypeID": user.type,
          "edited": user.createdAt,
          "email": user.email,
          "userType": user.type == 1 ? "Vendor" : "Customer",
        });
        SharedPreferenceHelper.storeUser(user);
        Get.offAllNamed(SelectLocationPage.routeName);
      } else {
        Get.key.currentState?.maybePop();
        SnackBarHelper.show("Some error occurred");
      }
    } catch (e, s) {
      Get.key.currentState?.maybePop();
      SnackBarHelper.show(parseFirebaseError(e));
      log("message", error: e, stackTrace: s);
    } finally {
      _googleSignIn.signOut();
    }
  }
}
