import 'package:flutter/material.dart';
import 'package:flutter_api_learn/cubit_view_model/creater_cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/creater_state.dart';
import 'package:flutter_api_learn/cubit_view_model/delete.cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/delete_state.dart';

import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_api_learn/view/api_learn_view.dart';
import 'package:flutter_api_learn/view/update_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class AddDeleteEtc extends StatefulWidget {
  AddDeleteEtc({Key? key}) : super(key: key);

  @override
  State<AddDeleteEtc> createState() => _AddDeleteEtcState();
}

class _AddDeleteEtcState extends State<AddDeleteEtc> {
  final String create = 'Create';
  final String delete = 'Delete';
  final String update = 'Update';
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _textJobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreaterCubit>(
      create: (context) => CreaterCubit(ReqresService(DioManager.instance)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(create),
          actions: [
            TextButton(
                onPressed: () {
                  context.navigateToPage(UpdateView());
                },
                child: Text(update))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: PagePadding.all(),
                    child: MyTitle(create),
                  ),
                  Padding(
                    padding: PagePadding.all(),
                    child: CreatesColumn(
                        namEController: _textNameController,
                        joBController: _textJobController,
                        title: create,
                        formKey: _formKey),
                  ),
                  MyTitle(delete),
                  DeleteButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteCubit(ReqresService(DioManager.instance)),
      child: Padding(
        padding: PagePadding.all(),
        child: BlocConsumer<DeleteCubit, DeleteState>(
          listener: (context, state) => DeleteState(),
          builder: (context, state) {
            return IgnorePointer(
              ignoring: (state.isDelete ?? false),
              child: ElevatedButton(
                onPressed: () {
                  context.read<DeleteCubit>().deleteControl();
                },
                child: (state.isDelete ?? false)
                    ? Text('User Deleted')
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Please press delete user 2'),
                          Icon(Icons.delete_forever)
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyTitle extends StatelessWidget {
  final String title;

  const MyTitle(
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: context.textTheme.headlineLarge,
      ),
    );
  }
}

class CreatesColumn extends StatelessWidget {
  CreatesColumn({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController namEController,
    required TextEditingController joBController,
    required String title,
  })  : eTitle = title,
        _formKey = formKey,
        nameController = namEController,
        jobController = joBController;

  final TextEditingController nameController;
  final TextEditingController jobController;
  final GlobalKey<FormState> _formKey;
  final String eTitle;

  @override
  Widget build(BuildContext context) {
    String name = 'Name';
    String job = 'Job';

    bool okey = false;
    return Column(
      children: [
        BlocSelector<CreaterCubit, CreaterState, bool>(selector: (state) {
          okey = state.isCompleted;
          return state.isLoading;
        }, builder: (context, state) {
          return Column(
            children: [
              TextFormField(
                validator: (String? value) =>
                    ((value?.length ?? 0) > 1 ? null : 'Plaese enter data'),
                controller: nameController,
                decoration: InputDecoration(labelText: name),
              ),
              TextFormField(
                validator: (String? value) =>
                    ((value?.length ?? 0) > 1 ? null : 'Plaese enter data'),
                controller: jobController,
                decoration: InputDecoration(labelText: job),
              ),
            ],
          );
        }),
        BlocConsumer<CreaterCubit, CreaterState>(
          listener: (context, state) {
            if (state.isCompleted) {
              okey = true;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                IgnorePointer(
                  ignoring: okey,
                  child: AnimatedOpacity(
                    duration: context.durationLow,
                    opacity: okey ? 0.6 : 1,
                    child: Padding(
                      padding: PagePadding.all(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<CreaterCubit>().createrUserControl(
                                  nameController.text, jobController.text);
                            }
                          },
                          child: state.isLoading
                              ? CircularProgressIndicator()
                              : Text('$eTitle' + (okey ? 'd Success' : ''))),
                    ),
                  ),
                ),
                Text('Created at: ${state.feedBackModel?.createdAt}'),
              ],
            );
          },
        )
      ],
    );
  }
}
