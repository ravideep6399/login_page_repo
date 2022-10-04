import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page_hillfare/utils.dart';
import 'main.dart';
//import 'package:firebase_auth_email/main.dart';
//import 'package:firebase_auth_email/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const SizedBox(height: 40),
        TextField(
          controller: emailController,
          cursorColor: const Color.fromARGB(255, 255, 255, 255),
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: signIn,
            icon: const Icon(
              Icons.lock_open,
              size: 32,
            ),
            label: const Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            )),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          child: Text(
            'Forgot Password?',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20),
          ),
          onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgotPasswordPage(),
              ))),
        ),
        RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 20),
                text: 'No account? ',
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Sign Up',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary))
            ]))
      ]),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
