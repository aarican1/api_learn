import 'package:flutter/material.dart';
import 'package:flutter_api_learn/cubit_view_model/register_cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/register_state.dart';

import 'package:flutter_api_learn/view/api_learn_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../service/dio_manager.dart';
import '../service/reqres_service.dart';
import 'empty_page.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final String _registerString = 'Register';

  final String _labelEmailString = 'Email';
  final String _labelpswordString = 'Password';
  TextEditingController _textEmailController = TextEditingController();
  TextEditingController _textPasswordController = TextEditingController();
  final GlobalKey<FormState> _registerFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(ReqresService(DioManager.instance)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_registerString),
          centerTitle: true,
        ),
        body: Form(
            key: _registerFormKey,
            child: Padding(
              padding: PagePadding.all(),
              child: Column(
                children: [
                  MyTextFormFieldColumn(
                      labelEmailString: _labelEmailString,
                      textEmailController: _textEmailController,
                      labelpswordString: _labelpswordString,
                      textPasswordController: _textPasswordController),
                  BlocButtonRegister(
                      registerFormKey: _registerFormKey,
                      textEmailController: _textEmailController,
                      textPasswordController: _textPasswordController,
                      registerString: _registerString)
                ],
              ),
            )),
      ),
    );
  }
}

class BlocButtonRegister extends StatelessWidget {
  const BlocButtonRegister({
    super.key,
    required GlobalKey<FormState> registerFormKey,
    required TextEditingController textEmailController,
    required TextEditingController textPasswordController,
    required String registerString,
  })  : _registerFormKey = registerFormKey,
        _textEmailController = textEmailController,
        _textPasswordController = textPasswordController,
        _registerString = registerString;

  final GlobalKey<FormState> _registerFormKey;
  final TextEditingController _textEmailController;
  final TextEditingController _textPasswordController;
  final String _registerString;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state.isCompleted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => EmptyPage()));
      }
    }, builder: (context, state) {
      return ElevatedButton(
          onPressed: () {
            if (_registerFormKey.currentState?.validate() ?? false) {
              context.read<RegisterCubit>().RegisterUser(
                  _textEmailController.text, _textPasswordController.text);
            }
          },
          child: state.isLoading
              ? CircularProgressIndicator()
              : Text(_registerString));
    });
  }
}

class MyTextFormFieldColumn extends StatelessWidget {
  const MyTextFormFieldColumn({
    super.key,
    required String labelEmailString,
    required TextEditingController textEmailController,
    required String labelpswordString,
    required TextEditingController textPasswordController,
  })  : _labelEmailString = labelEmailString,
        _textEmailController = textEmailController,
        _labelpswordString = labelpswordString,
        _textPasswordController = textPasswordController;

  final String _labelEmailString;
  final TextEditingController _textEmailController;
  final String _labelpswordString;
  final TextEditingController _textPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) {
        return state.isLoading;
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state,
          child: AnimatedOpacity(
            opacity: state ? 0.4 : 1,
            duration: context.durationLow,
            child: Column(
              children: [
                Padding(
                  padding: PagePadding.height(),
                  child: TextFormField(
                    controller: _textEmailController,
                    decoration: InputDecoration(labelText: _labelEmailString),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) => (value?.isValidEmail ?? false)
                        ? null
                        : 'Please enter email',
                  ),
                ),
                Padding(
                  padding: PagePadding.height(),
                  child: TextFormField(
                    obscureText: true,
                    controller: _textPasswordController,
                    decoration: InputDecoration(labelText: _labelpswordString),
                    keyboardType: TextInputType.multiline,
                    validator: (String? value) => ((value?.length?? 0)>5) ? null : 'Please enter password',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
