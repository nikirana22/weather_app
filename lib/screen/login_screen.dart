import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screen/signup_screen.dart';
import '/utils/text_utils.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

import '../manager/firebase_manager.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/screen/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('on pressed');
          final position = await Geolocator.getCurrentPosition();
          print('lat : ${position.latitude} lon : ${position.longitude}');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  validator: TextUtils.validateEmail,
                  controller: _emailController,
                  hintText: 'Enter your Email'),
              const SizedBox(height: 20),
              CustomTextField(
                  validator: TextUtils.validatePassword,
                  controller: _passwordController,
                  hintText: 'Enter your password'),
              const SizedBox(height: 40),
              TextButton(
                onPressed: _onLogin,
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text('Submit'),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('if you don\'t have an account '),
                  InkWell(
                    onTap: _onSignUpButtonClick,
                    child: const Text(
                      'SignUp',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar() {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      _showSnackBar();
      FirebaseManager.loginWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }).onError<FirebaseException>((error, stackTrace) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Something went Wrong : ${error.message}')));
      });
    }
  }

  void _onSignUpButtonClick() {
    Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
  }

  void _disposeAllController() {
    _emailController.dispose();
    _passwordController.dispose();
  }
}
/*

6RKBBZSZFZ6JZUWFAYC3CS592
 */
