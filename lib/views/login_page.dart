import 'package:bloc_patterns/bloc/login/login_bloc.dart';
import 'package:bloc_patterns/components/show_dialog.dart';
import 'package:bloc_patterns/controller/user_controller.dart';
import 'package:bloc_patterns/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
              child: Text("Login"),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
