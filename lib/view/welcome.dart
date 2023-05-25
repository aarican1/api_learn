import 'package:flutter/material.dart';
import 'package:flutter_api_learn/view/api_learn_view.dart';
import 'package:flutter_api_learn/view/register_view.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  final String welcome = 'Welcome Guys';
  final String lottiePath = 'lib/assets/lottie/welcome.json';
  final String reg = 'Register';
  final String log = 'Login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(welcome),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              lottiePath,
            ),
          ),
          MyTextButtonRow(reg: reg, log: log)
        ],
      ),
    );
  }
}

class MyTextButtonRow extends StatelessWidget {
  const MyTextButtonRow({
    super.key,
    required this.reg,
    required this.log,
  });

  final String reg;
  final String log;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.height(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: PagePadding.all(),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return RegisterView();
                      },
                    ),
                  );
                },
                child: Text(reg)),
          ),
          Padding(
            padding: PagePadding.all(),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ApiLearnView();
                      },
                    ),
                  );
                },
                child: Text(log)),
          )
        ],
      ),
    );
  }
}
