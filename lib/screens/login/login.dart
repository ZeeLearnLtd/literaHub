import 'package:flutter/material.dart';

import '../../core/responsive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: Responsive.isDesktop(context)
                ? const EdgeInsets.symmetric(horizontal: 250)
                : Responsive.isTablet(context)
                    ? const EdgeInsets.symmetric(horizontal: 80)
                    : const EdgeInsets.symmetric(horizontal: 00),
            height: 150,
            child: Stack(
              children: [
                Container(
                  height: 150,
                  margin: const EdgeInsets.only(
                    right: 70,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: 32),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 20),
                            border: InputBorder.none,
                            icon: Icon(Icons.account_circle_rounded),
                            hintText: "Username",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: 32),
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 22),
                            border: InputBorder.none,
                            icon: Icon(Icons.account_circle_rounded),
                            hintText: "********",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    // onTap: () => Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       settings:
                    //           const RouteSettings(name: RouteName.mainScreen),
                    //       builder: (context) => const MainScreen(),
                    //     ),
                    //     (route) => false),
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green[200]!.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff1bccba),
                            Color(0xff22e2ab),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
