import 'package:equatable/equatable.dart';
import 'package:flutter_api_learn/model/creater_model.dart';

class CreaterState extends Equatable {
  final bool isLoading;
  final CreaterModel? createrModel;
  final CreaterFeedBackModel? feedBackModel;
  final bool isCompleted;

  CreaterState(
      {this.isLoading = false,
      this.createrModel,
      this.feedBackModel,
      this.isCompleted = false});

  CreaterState copyWith({
    bool? isLoading,
    CreaterModel? createrModel,
    CreaterFeedBackModel? feedBackModel,
    bool? isCompleted,
  }) {
    return CreaterState(
        isLoading:isLoading?? this.isLoading,
        createrModel: createrModel?? this.createrModel,
        feedBackModel: feedBackModel?? this.feedBackModel,
        isCompleted:  isCompleted?? this.isCompleted);

  }

  @override
  List<Object?> get props => [isLoading, createrModel, feedBackModel];
}
