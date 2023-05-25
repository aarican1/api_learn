import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_api_learn/model/creater_model.dart';
import 'package:flutter_api_learn/model/register_model.dart';
import 'package:flutter_api_learn/model/register_token_model.dart';
import 'package:flutter_api_learn/model/reqres_user_model.dart';
import 'package:flutter_api_learn/model/resource_model.dart';
import 'package:flutter_api_learn/model/single_user_model.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';

import '../model/login_model.dart';
import '../model/token_model.dart';

abstract class IReqresService {
  IReqresService(this.dioManager);
  final DioManager dioManager;
  Future<TokenModel?> login(LoginModel loginModel);
  Future<RegisterTokenModel?> register(RegisterModel registerModel);
  Future<ReqresUserModel?> userlist();
  Future<SingleUserModel?> user();
  Future<ResourceModel?> resource();
  Future<CreaterFeedBackModel?> creater(CreaterModel createrModel);
  Future<bool> delete();
  Future<UpdateFeedBackModel?> updatePut(CreaterModel createrModel);
  Future<UpdateFeedBackModel?> updatePatch(CreaterModel createrModel);
  String? errorMessage;
}

class ReqresService extends IReqresService {
  ReqresService(super.dioManager);

  @override
  Future<TokenModel?> login(LoginModel loginModel) async {
    final StringPath = 'api/login';
   try{   final response = await dioManager.service.post(StringPath,
        data: {"email": loginModel.email, "password": loginModel.password});
    if (response.statusCode == HttpStatus.ok) {
      final tokenModel = TokenModel.fromJson(response.data);

      return tokenModel;
    }}
    on DioError catch(e) {
       errorMessage = DioExceptions.fromDioError(e).toString();
    }
    return null;
  }

  Future<RegisterTokenModel?> register(RegisterModel registerModel) async {
    final StringReg = 'api/register';

   try{ final response = await dioManager.service.post(StringReg, data: {
      "email": registerModel.email,
      "password": registerModel.password
    });
    if (response.statusCode == HttpStatus.ok) {
      final reqTokenModel = RegisterTokenModel.fromJson(response.data);
      return reqTokenModel;
    }}
    on DioError catch(e) {
       errorMessage = DioExceptions.fromDioError(e).toString();
    }

    return null;
  }

  @override
  Future<ReqresUserModel?> userlist() async {
    final StringUserPath = '/api/users?page=2';
   try{ final response = await dioManager.service.get(StringUserPath);
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return ReqresUserModel.fromJson(jsonBody);
      }
    }}
    on DioError catch(e) {
       errorMessage = DioExceptions.fromDioError(e).toString();
    }
    return null;
  }

  @override
  Future<SingleUserModel?> user() async {
    final stringPath = '/api/users/2';
   try{ final response = await dioManager.service.get(stringPath);
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return SingleUserModel.fromJson(jsonBody);
      }
    }}
    on DioError catch(e){
       errorMessage = DioExceptions.fromDioError(e).toString();
    }
    return null;
  }

  @override
  Future<ResourceModel?> resource() async {
    final stringPath = '/api/unknown';
   try{ final response = await dioManager.service.get(stringPath);
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return ResourceModel.fromJson(jsonBody);
      }
    }}
    on DioError catch(e){
       errorMessage = DioExceptions.fromDioError(e).toString();
    }
    return null;
  }

  @override
  Future<CreaterFeedBackModel?> creater(CreaterModel createrModel) async {
    final String stringPath = '/api/users';
   try{ final response = await dioManager.service.post(stringPath,
        data: {"name": createrModel.name, "job": createrModel.job});

    if (response.statusCode == HttpStatus.created) {
      final feedbackResult = CreaterFeedBackModel.fromJson(response.data);
      return feedbackResult;
    }}
    on DioError catch(e){
       errorMessage = DioExceptions.fromDioError(e).toString();
    }
    return null;
  }

  @override
  Future<bool> delete() async {
    final String stringPath = '/api/users/2';
   try{ final response = await dioManager.service.delete(stringPath);
    if (response.statusCode == HttpStatus.noContent) {
      print(response.statusMessage);
      return true;
    }} on DioError catch(e){
       errorMessage = DioExceptions.fromDioError(e).toString();
    }

    return false;
  }

  @override
  Future<UpdateFeedBackModel?> updatePut(CreaterModel createrModel) async {
    final stringPath = '/api/users/2';
    try {
      final response = await dioManager.service.put(stringPath,
          data: {"name": createrModel.name, "job": createrModel.job});
      if (response.statusCode == HttpStatus.ok) {
        final jsonBody = UpdateFeedBackModel.fromJson(response.data);

        return jsonBody;
      }
    } on DioError catch (e) {
      errorMessage = DioExceptions.fromDioError(e).toString();
     
    }
    return null;
  }

  @override
  Future<UpdateFeedBackModel?> updatePatch(CreaterModel createrModel) async {
    final stringPath = '/api/users/2';
   try{ final response = await dioManager.service.patch(stringPath,
        data: {"name": createrModel.name, "job": createrModel.job});
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = UpdateFeedBackModel.fromJson(response.data);
      return jsonBody;
    }}
    on DioError catch(e){
       errorMessage = DioExceptions.fromDioError(e).toString();
    }
    return null;
  }
}

