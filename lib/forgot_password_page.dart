import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page_hillfare/sign_in.dart';
import 'utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assests/bgN 1.jpg"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 164,
              ),
              const SizedBox(
                width: 173,
                height: 25,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Enter your email id',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 223,
                height: 37,
                child: TextFormField(
                  controller: emailController,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      maximumSize: const Size(119, 31),
                      backgroundColor: const Color.fromARGB(255, 184, 151, 213),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: resetPassword,
                  child: const Center(
                    child: SizedBox(
                      width: 43,
                      height: 19,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Password Reset Email Sent');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MessagePage()));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assests/bgN 1.jpg"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
          children: [
            Container(
                width: 291,
                height: 172,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 56,
                      width: 272,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                              'An email to reset your password has\n been sent to the entered email\n    address.'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignIn(onClickedSignUp: () {})));
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              size: 22,
                              color: Colors.black,
                            ),
                            Text(
                              'Back to sign in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
