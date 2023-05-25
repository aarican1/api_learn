import 'package:equatable/equatable.dart';

import '../model/single_user_model.dart';

class SingleUserState extends Equatable {
  final Data? data;

  SingleUserState({this.data});



  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
