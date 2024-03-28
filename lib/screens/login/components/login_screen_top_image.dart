import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/LocalConstant.dart';


class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: LocalConstant.defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Lottie.asset('assets/json/loginfail.json',height: MediaQuery.of(context).size.width * 0.4),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: LocalConstant.defaultPadding * 2),
      ],
    );
  }
}