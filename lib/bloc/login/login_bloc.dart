import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_patterns/controller/user_controller.dart';
import 'package:bloc_patterns/model/user_model.dart';
import 'package:bloc_patterns/views/home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

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

//Login success state
class LoginSuccessState extends LoginState {
  final UserModel modelData;

  Future<void> saveLoginData() async {
    // Create storage
    final storage = const FlutterSecureStorage();
    await storage.write(
      key: "LoginData",
      value: jsonEncode(modelData),
    );
    print("go to page");
    // Get.to(const HomePage());
  }

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
