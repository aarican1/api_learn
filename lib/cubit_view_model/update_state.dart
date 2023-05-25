import 'package:equatable/equatable.dart';


class UpdateState extends Equatable {
  final bool? isLoadingPut;
  final bool? isLoadingPacth;
  final String? feedBackModel;
  final bool? isUpdatePut;
  final bool? isUpdatePatch;
  UpdateState(
      {this.isLoadingPut = false,
      this.isLoadingPacth = false,
      this.feedBackModel,
      this.isUpdatePut = false,
      this.isUpdatePatch = false});

  UpdateState copyWith(
    final bool? isLoadingPut,
    final bool? isLoadingPacth,
    final String? feedBackModel,
    final bool? isUpdatePut,
    final bool? isUpdatePatch,
  ) {
    return UpdateState(
        isLoadingPacth: this.isLoadingPacth,
        isLoadingPut: this.isLoadingPut,
        isUpdatePatch: this.isUpdatePatch,
        feedBackModel: this.feedBackModel,
        isUpdatePut: this.isUpdatePut);
  }

  @override
  List<Object?> get props =>
      [isLoadingPut, isLoadingPacth, isUpdatePut, isUpdatePatch];
}
