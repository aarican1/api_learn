import 'package:equatable/equatable.dart';

import '../model/resource_model.dart';

class ResourceState extends Equatable {
  final List<Data?>? data;

  ResourceState({this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
