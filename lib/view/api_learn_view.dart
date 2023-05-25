import 'package:flutter/material.dart';
import 'package:flutter_api_learn/cubit_view_model/login_cubit.dart';
import 'package:flutter_api_learn/cubit_view_model/login_state.dart';
import 'package:flutter_api_learn/service/dio_manager.dart';
import 'package:flutter_api_learn/service/reqres_service.dart';
import 'package:flutter_api_learn/view/empty_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class ApiLearnView extends StatefulWidget {
  ApiLearnView({Key? key}) : super(key: key);

  @override
  State<ApiLearnView> createState() => _ApiLearnViewState();
}

class _ApiLearnViewState extends State<ApiLearnView> {
  final String _loginString = 'Login';
  final String _labelEmailString = 'Email';
  final String _labelpswordString = 'Password';
  TextEditingController _textEmailController = TextEditingController();
  TextEditingController _textPasswordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(ReqresService(DioManager.instance)),
        child: Scaffold(
            appBar: AppBar(
              title: Text(_loginString),
              centerTitle: true,
            ),
            body: Form(
              key: _loginFormKey,
              child: Padding(
                padding: PagePadding.all(),
                child: Column(children: [
                  LoginTextFormField(
                    labelEmailString: _labelEmailString,
                    labelpswordString: _labelpswordString,
                    textEmailController: _textEmailController,
                    textPasswordController: _textPasswordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: PagePadding.all(),
                        child: BlocButton(
                            loginFormKey: _loginFormKey,
                            textEmailController: _textEmailController,
                            textPasswordController: _textPasswordController,
                            loginString: _loginString),
                      ),
                    ],
                  ),
                ]),
              ),
            )));
  }
}

class BlocButton extends StatelessWidget {
  const BlocButton({
    super.key,
    required GlobalKey<FormState> loginFormKey,
    required TextEditingController textEmailController,
    required TextEditingController textPasswordController,
    required String loginString,
  })  : _loginFormKey = loginFormKey,
        _textEmailController = textEmailController,
        _textPasswordController = textPasswordController,
        _loginString = loginString;

  final GlobalKey<FormState> _loginFormKey;
  final TextEditingController _textEmailController;
  final TextEditingController _textPasswordController;
  final String _loginString;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isCompleted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => EmptyPage()));
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_loginFormKey.currentState?.validate() ?? false) {
              context.read<LoginCubit>().checkUser(
                  _textEmailController.text, _textPasswordController.text);
            }
          },
          child: state.isLoading
              ? CircularProgressIndicator()
              : Text(_loginString),
        );
      },
    );
  }
}

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    super.key,
    required TextEditingController textEmailController,
    required String labelEmailString,
    required TextEditingController textPasswordController,
    required String labelpswordString,
  })  : _textEmailController = textEmailController,
        _labelEmailString = labelEmailString,
        _textPasswordController = textPasswordController,
        _labelpswordString = labelpswordString;

  final TextEditingController _textEmailController;
  final String _labelEmailString;
  final TextEditingController _textPasswordController;
  final String _labelpswordString;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) {
        return state.isLoading;
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state,
          child: AnimatedOpacity(
            duration: context.durationLow,
            opacity: state ? 0.4 : 1,
            child: Column(children: [
              TextFormField(
                controller: _textEmailController,
                decoration: InputDecoration(labelText: _labelEmailString),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) => (value?.isValidEmail ?? false)
                    ? null
                    : 'Please enter email',
              ),
              Padding(
                padding: PagePadding.height(),
                child: TextFormField(
                  controller: _textPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: _labelpswordString),
                  keyboardType: TextInputType.multiline,
                  validator: (String? value) => ((value?.length ?? 0) > 5)
                      ? null
                      : 'Please enter password',
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class PagePadding extends EdgeInsets {
  PagePadding.all() : super.all(20);
  PagePadding.button() : super.all(9);
  PagePadding.height() : super.only(top: 20, bottom: 20);
}
