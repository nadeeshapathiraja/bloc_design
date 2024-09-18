import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_patterns/controller/user_controller.dart';
import 'package:bloc_patterns/model/user_model.dart';
import 'package:equatable/equatable.dart';

import '../model/user_data_model.dart';

class UserDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserData extends UserDataEvent {
  final String token;

  GetUserData(this.token);
  @override
  List<Object?> get props => [];
}

class DataState extends Equatable {
  @override
  List<Object?> get props => [];
}

//Initial State
class InitialDataState extends DataState {
  @override
  List<Object?> get props => [];
}

//Data Loading
class DataLoadingState extends DataState {
  @override
  List<Object?> get props => [];
}

//Data success state
class DataSuccessState extends DataState {
  @override
  List<Object?> get props => [];
}

//Data Failed state
class DataFailedState extends DataState {
  final String message;

  DataFailedState({required this.message});
  @override
  List<Object?> get props => [];
}

class DataBloc extends Bloc<UserDataEvent, DataState> {
  DataBloc() : super(InitialDataState()) {
    on<UserDataEvent>((event, emit) async {
      if (event is GetUserData) {
        try {
          emit(DataLoadingState());
          UserDataModel userDataModel = await UserController.getUserDetails(
         
          );
          emit(DataSuccessState());
        } on SocketException {
          emit(DataFailedState(message: "Socket Exception"));
        } on HttpException {
          emit(DataFailedState(message: "Http Exception"));
        } on FormatException {
          emit(DataFailedState(message: "Format Exception"));
        } catch (e) {
          emit(DataFailedState(message: e.toString()));
        }
      }
    });
  }
}
