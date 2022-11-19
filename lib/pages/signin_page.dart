import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:validators/validators.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../cubits/cubits.dart';
import '../pages/signup_page.dart';
import '../utils/utils.dart';

class SigninPage extends StatelessWidget {
  static const id = '/signin';

  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: _FormBody(),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormBody extends StatefulWidget {
  const _FormBody({Key? key}) : super(key: key);

  @override
  State<_FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<_FormBody> {
  final _formKey = GlobalKey<FormState>();
  var _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email required';
    }

    if (!isEmail(value)) return 'Enter a valid email';

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password required';
    }

    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    if (kDebugMode) {
      print('email $_email');
      print('password $_password');
    }

    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  void _signinListener(BuildContext ctx, SigninState state) {
    if (state.status == SigninStatus.error) {
      showErrorDialog(ctx, state.error);
    }
  }

  void _gotoSignupPage() => Navigator.pushNamed(
        context,
        SignupPage.id,
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: _signinListener,
      builder: (ctx, state) => Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset(
              'assets/images/flutter_logo.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              enabled: state.status != SigninStatus.submitting,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: _emailValidator,
              onSaved: (value) => _email = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              enabled: state.status != SigninStatus.submitting,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              validator: _passwordValidator,
              onSaved: (value) => _password = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  state.status == SigninStatus.submitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(state.status == SigninStatus.submitting
                  ? 'Loading...'
                  : 'Sign In'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: state.status == SigninStatus.submitting
                  ? null
                  : _gotoSignupPage,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
              child: const Text('Not a member? Sign Up!'),
            ),
          ],
        ),
      ),
    );
  }
}
