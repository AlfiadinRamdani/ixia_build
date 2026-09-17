import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 500,
            height: 397,
            decoration: BoxDecoration(color: Color(0xFF2567E8)),
          ),
          ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: Container(
                        width: 28,
                        height: 28,
                        child: Image.asset('assets/icons/Vector.png'),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign in to your\nAccount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFEEEEEE),
                        fontSize: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Enter your email and password to log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFEEEEEE),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: 327,
                    height: 418,
                    decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(12.0)),
                        Container(
                          decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0XFF1D61E7),
                              foregroundColor: Color(0XFFEDF1F3),
                            ),

                            onPressed: () {},

                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset('assets/icons/pusing.png'),
                                ),
                                SizedBox(width: 190),
                                Text('Continue with Google'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFEDF1F3),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Text(
                                'Or login with',
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFF6C7278),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0XFFEDF1F3),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.visibility_off),
                            labelText: 'password',
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6C7278),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4D81E7),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          color: Color(0xFF1D61E7),

                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF1D61E7),
                                foregroundColor: Color(0XFFEDF1F3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'log in',
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(children: [Center()]),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
