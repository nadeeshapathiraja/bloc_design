import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_patterns/controller/user_controller.dart';
import 'package:bloc_patterns/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLogin extends LoginEvent {
  final String username;
  final String password;

  UserLogin(this.username, this.password);
  @override
  List<Object?> get props => [];
}

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

//Initial State
class InitialLoginState extends LoginState {
  @override
  List<Object?> get props => [];
}

//Login Loading
class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

Future<void> saveLoginData(UserModel model) async {
  // Create storage
  const storage = FlutterSecureStorage();
  Logger().wtf(jsonEncode(model));
  await storage.write(
    key: "LoginData",
    value: jsonEncode(model),
  );
  Logger().d("go to Home page");
  // Get.to(const HomePage());
}

//Login success state
class LoginSuccessState extends LoginState {
  final UserModel modelData;

  LoginSuccessState(this.modelData);
  @override
  List<Object?> get props => [];
}

//Login Failed state
class LoginFailedState extends LoginState {
  final String message;

  LoginFailedState({required this.message});
  @override
  List<Object?> get props => [];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is UserLogin) {
        try {
          emit(LoginLoadingState());
          UserModel userModel = await UserController.userlogin(
            event.username,
            event.password,
          );
          emit(LoginSuccessState(userModel));
          saveLoginData(userModel);
        } on SocketException {
          emit(LoginFailedState(message: "Socket Exception"));
        } on HttpException {
          emit(LoginFailedState(message: "Http Exception"));
        } on FormatException {
          emit(LoginFailedState(message: "Format Exception"));
        } catch (e) {
          emit(LoginFailedState(message: e.toString()));
        }
      }
    });
  }
}
