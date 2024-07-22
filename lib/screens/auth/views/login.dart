import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/controller/logincontroller.dart';
import 'package:literahub/screens/auth/views/homepage.dart';
import 'package:literahub/screens/home/home_screen.dart';


class LiteriaHubLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LiteriaHubLoginPage> {
  final LoginController controller = Get.put(LoginController());

  var _emailTextController = TextEditingController(text: "");
  var _passwordTextController = TextEditingController(text: "");
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isChekced = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32,top: 100),
            child: Obx(() {
              return Form(
                  key: _formKey,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/literalogo.jpg',height: MediaQuery.of(context).size.width * 0.4),
                            // Text("LiteriaHub",
                            //     style: TextStyle(
                            //         color: Theme.of(context).primaryColor,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 32)),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
                              controller: _emailTextController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person), 
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                  labelText: "User Name"),
                              validator: (String? value) =>
                                  value!.isNotEmpty
                                      ? null
                                      : "Please enter a valid User Name",
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
                              controller: _passwordTextController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_passwordVisible,
                              validator: (String? value) => value!.trim().isEmpty
                                  ? "Password is require"
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Checkbox(value: isChekced, onChanged: (value){
                                    setState(() {
                                      isChekced  = value!;
                                    });
                                }),
                                Text('I accept the Terms and conditions')
                              ],
                            ),
                            const SizedBox(height: 12),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: controller.loginProcess.value
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var error = await controller.login(
                                        uid: _emailTextController.text,
                                        password: _passwordTextController.text);
                                    if(error is UserResponse){
                                           Get.to(HomePage(userInfo: error as UserResponse,)); 
                                    }else if (error != "") {
                                      Get.defaultDialog(
                                          title: "Oop!", middleText: error);
                                    } else {
                                      Get.to(const LiteriaHubHomePage());
                                    }
                                  }
                                },
                                child: const Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ));
            })),
      ),
    );
  }
}