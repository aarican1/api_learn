import 'package:equatable/equatable.dart';
import 'package:flutter_api_learn/model/register_token_model.dart';

import '../model/register_model.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final RegisterModel? model;
  final RegisterTokenModel? tokenModel;
  final bool isCompleted;
  RegisterState(
      {this.isLoading = false,
      this.model,
      this.tokenModel,
      this.isCompleted = false});

  @override
  List<Object?> get props => [isLoading, model];
  RegisterState copyWith(
      {bool? isLoading,
      RegisterModel? model,
      RegisterTokenModel? tokenModel,
      bool? isCompleted}) {
    return RegisterState(
        isLoading: isLoading ?? this.isLoading,
        model: model ?? this.model,
        tokenModel: tokenModel ?? this.tokenModel,
        isCompleted: isCompleted ?? false);
  }
}
