import 'package:flutter/material.dart';
import 'package:flutter_api_learn/cubit_view_model/update_cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/update_state.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_api_learn/view/api_learn_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateView extends StatefulWidget {
  UpdateView({Key? key}) : super(key: key);

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  final TextEditingController _nameController = TextEditingController();
  final String title = 'Update/Put-Patch';
   final String uptitle = 'Update';
  final TextEditingController _jobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateCubit>(
      create: (context) => UpdateCubit(ReqresService(DioManager.instance)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: UpdatesColumn(
                uptitle,
                nameController: _nameController,
                jobController: _jobController,
                formKey: _formKey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpdatesColumn extends StatelessWidget {
  const UpdatesColumn(
    this.eTitle, {
    super.key,
    required this.nameController,
    required this.jobController,
    required this.formKey,
  });
  final TextEditingController nameController;
  final TextEditingController jobController;
  final String eTitle;
  final String name = 'Name';
  final String job = ' Job';
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.all(),
      child: Column(
        children: [
          BlocSelector<UpdateCubit, UpdateState, bool>(selector: (state) {
            if ((state.isLoadingPacth ?? false) ||
                (state.isLoadingPut ?? false)) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            return Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: name),
                  validator: (String? value) =>
                      ((value?.length ?? 0) > 1 ? null : 'Plaese enter name'),
                  controller: nameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: job),
                  validator: (String? value) =>
                      ((value?.length ?? 0) > 1 ? null : 'Plaese enter job'),
                  controller: jobController,
                ),
              ],
            );
          }),
          BlocConsumer<UpdateCubit, UpdateState>(
              listener: (context, state) => UpdateState(),
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: PagePadding.button(),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await context
                                  .read<UpdateCubit>()
                                  .updateWPutContoller(
                                      nameController.text, jobController.text);
                            }
                          },
                          child: (state.isLoadingPut ?? false)
                              ? CircularProgressIndicator()
                              : Text(
                                  '$eTitle with Put ${(state.isUpdatePut ?? false) ? 'Succes' : ''}')),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            await context
                                .read<UpdateCubit>()
                                .updateWPatchContoller(
                                    nameController.text, jobController.text);
                            debugPrint(state.feedBackModel ?? '');
                          }
                        },
                        child: (state.isLoadingPacth ?? false)
                            ? CircularProgressIndicator()
                            : Text(
                                '$eTitle with Patch ${(state.isUpdatePatch ?? false) ? 'Succes' : ''}')),
                  
                  ],
                );
              })
        ],
      ),
    );
  }
}
