import 'package:equatable/equatable.dart';

import '../model/reqres_user_model.dart';

// ignore: must_be_immutable
class ReqresUserListState extends Equatable {
  final List<Data?>? data;
   bool isLoading;
  ReqresUserListState({this.data, this.isLoading = false});
  @override
  List<Object?> get props => [data, isLoading];
}
