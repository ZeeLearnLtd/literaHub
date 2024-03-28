import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:literahub/main.dart';
import 'package:literahub/model/user.dart';
import 'package:literahub/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constant/LocalConstant.dart';
import '../../../core/theme/light_colors.dart';
import '../../../core/utility.dart';

class LoginForm extends StatefulWidget {
  Map<String, String> params;
  LoginForm({required this.params, super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;
  bool _obscureText = true;
  bool acceptPrivacyPolicy = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<UserInfo> userList = [];
  @override
  void initState() {
    super.initState();

    userList.add(new UserInfo(1, 'S1', 'Ankush Shinde', ['2'], 'S-1-12'));
    userList.add(new UserInfo(1, 'T1', 'Sanavi Patil', ['2'], 'TEACH-1-12'));
    userList.add(
        new UserInfo(1, 'SP1', 'Tanvi Patil', ['Nursery'], 'S-Pre-primary'));
    userList.add(
        new UserInfo(1, 'TP1', 'Anvi Patil', ['Nursery'], 'TEACH-Pre-primary'));
  }

  @override
  Widget build(BuildContext context) {
    int enterCall = 0;
    // FocusScope.of(context).requestFocus(focusNode);
    return /* KeyboardListener(
      autofocus: true,
      focusNode: focusNode, // <-- more magic
      onKeyEvent: (event) {
        enterCall++;
        if (event.logicalKey == LogicalKeyboardKey.enter && enterCall == 2) {
          enterCall = 0;
          
          if (ModalRoute.of(context) != null &&  ModalRoute.of(context)!.isCurrent) {          
            validate();
          }
        }
      },
      child: */
        Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            controller: userNameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(1.0),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:
                    BorderSide(color: LightColors.kLightGray1, width: 0.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: "User Name ",
              prefixIcon: Padding(
                padding: EdgeInsets.all(LocalConstant.defaultPadding),
                child: const Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: LocalConstant.defaultPadding),
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              textInputAction: TextInputAction.done,
              obscureText: _obscureText,
              onFieldSubmitted: (value) {
                validate();
              },
              cursorColor: kPrimaryColor,
              controller: userPasswordController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(1.0),
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide:
                      BorderSide(color: LightColors.kLightGray1, width: 0.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(LocalConstant.defaultPadding),
                  child: const Icon(Icons.lock),
                ),
              ),
            ),
          ),
          SizedBox(height: LocalConstant.defaultPadding),
          Row(
            children: [
              Checkbox(
                checkColor: Colors.greenAccent,
                activeColor: kPrimaryColor,
                value: acceptPrivacyPolicy,
                onChanged: (value) {
                  setState(() {
                    acceptPrivacyPolicy = value ?? false;
                  });
                },
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'I agree to the ',
                      style: LightColors.headerStyle,
                    ),
                    TextSpan(
                        text: 'Privacy Policy',
                        style: LightColors.headerStyle
                            .copyWith(color: kPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse(
                                'https://www.kidzee.com/PrivacyPolicy'));
                          }),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: LocalConstant.defaultPadding),
          ElevatedButton(
            onPressed: () {
              validate();
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          SizedBox(height: LocalConstant.defaultPadding),
        ],
      ),
      // ),
    );
  }

  isValid() {
    if (userNameController.text.toString().trim().isEmpty) {
      Utility.showAlert(context, 'Please Enter the UserName ');
      return false;
    } else if (userPasswordController.text.toString().trim().isEmpty) {
      Utility.showAlert(context, 'Please Enter the Password ');
      return false;
    } else if (!acceptPrivacyPolicy) {
      Utility.showAlert(context, 'Please accept Privacy Policy');
      return false;
    } else {
      return true;
    }
  }

  checkUserLogin(userName, password) async {
    UserInfo? userInfo = null;
    for (int index = 0; index < userList.length; index++) {
      if (userName == userList[index].userName) {
        userInfo = userList[index];
        break;
      }
    }
    if (userInfo != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userInfo: userInfo!,
            ),
          ));
    } else {
      Utility.showAlert(context, 'Invalid User Name and Password');
    }
  }

  validate() async {
    if (isValid()) {
      //Utility.showLoaderDialog(context);
      checkUserLogin(userNameController.text.toString(),
          userPasswordController.text.toString());
    }
  }
}
