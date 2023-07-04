import 'package:flutter/material.dart';
import 'package:kickweight/my_button.dart';
import 'package:kickweight/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void signUserIn(BuildContext context) {
    Navigator.pushNamed(context, '/second');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            // Wrap the Column with SingleChildScrollView
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Welcome Back!, Login to continue',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: widget.usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: widget.passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () => signUserIn(context),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SquareTile(imagePath: 'images/google.png'),
                        const SizedBox(width: 10),
                        SquareTile(imagePath: 'images/apple-logo.png'),
                      ],
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/register'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Register now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
