import 'package:bloc_patterns/bloc/login/login_bloc.dart';
import 'package:bloc_patterns/components/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    final controller15 = ValueNotifier<bool>(false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Login page",
            ),
            AdvancedSwitch(
              width: 60,
              height: 28,
              activeChild: const Icon(
                Icons.light_mode,
                color: Colors.black,
              ),
              inactiveChild: const Icon(
                Icons.dark_mode,
                color: Colors.white,
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              onChanged: (val) {
                Logger().w(val);

                Provider.of<ThemeProvider>(context, listen: false).toggleTap();
              },
              controller: controller15,
            ),
          ],
        ),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        bloc: userBloc,
        listener: (context, state) {
          if (state is LoginLoadingState) {
            ShowAllDialog.showLoadiingDialog(size.width);
            print("LoginLoadingState");
          }

          if (state is LoginSuccessState) {
            print("LoginSuccessState");
            Get.to(const HomePage());
          }

          if (state is LoginFailedState) {
            ShowAllDialog.hideDialog();
            print(state.message);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                userBloc.add(
                  UserLogin(
                    'emilys',
                    'emilyspass',
                  ),
                );
                // UserModel userModel =
                //     await UserController.userlogin("emilys", "emilyspass");
              },
              child: const Text("Login"),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
