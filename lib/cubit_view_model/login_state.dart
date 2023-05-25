import 'package:equatable/equatable.dart';
import 'package:flutter_api_learn/model/login_model.dart';

import '../model/token_model.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final LoginModel? model;
  final TokenModel? tokenModel;
  final bool isCompleted;
  LoginState({this.isLoading = false, this.model,this.tokenModel,this.isCompleted=false});

  @override
  List<Object?> get props => [isLoading, model];

  LoginState copyWith({
  bool? isLoading,
  LoginModel? model,
  TokenModel? tokenModel,
  bool? isCompleted
}
  )
  {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      model: model??this.model,
      tokenModel: tokenModel??this.tokenModel,
      isCompleted: isCompleted??false
    );
  }
}
