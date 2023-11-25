import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/manager/firebase_manager.dart';
import 'package:weather_app/screen/home_screen.dart';
import 'package:weather_app/screen/login_screen.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/screen/signup_scree';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                controller: _emailController, hintText: 'Enter your Email'),
            const SizedBox(height: 20),
            CustomTextField(
                controller: _passwordController,
                hintText: 'Enter your password'),
            const SizedBox(height: 20),
            CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Re-enter password'),
            const SizedBox(height: 30),
            TextButton(
              onPressed: _onSignUp,
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
                const Text("Already have an account "),
                InkWell(
                  onTap: _loginButtonClick,
                  child: const Text(
                    'Login',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showSnackBar() {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()));
  }

//todo use validator here
  void _onSignUp() {
    _showSnackBar();
    FirebaseManager.signupWithEmail(
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

  void _loginButtonClick() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void _disposeAllController() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}
