import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:validators/validators.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../cubits/cubits.dart';
import '../pages/pages.dart';
import '../utils/functions.dart';

class SignupPage extends StatelessWidget {
  static const id = '/signup';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const KeyboardDismisser(
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
    );
  }
}

class _FormBody extends StatefulWidget {
  const _FormBody({Key? key}) : super(key: key);

  @override
  State<_FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<_FormBody> {
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  var _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _email, _password;

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name required';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

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

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value != _passwordController.text) {
      return 'Passwords not match';
    }

    return null;
  }

  void _submit() {
    setState(() => _autovalidateMode = AutovalidateMode.always);

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    if (kDebugMode) {
      print('name $_name');
      print('email $_email');
      print('password $_password');
    }

    context.read<SignupCubit>().signup(
          name: _name!,
          email: _email!,
          password: _password!,
        );
  }

  void _signupListener(BuildContext ctx, SignupState state) {
    if (state.status == SignupStatus.error) {
      showErrorDialog(ctx, state.error);
    }
  }

  void _gotoSigninPage() {
    Navigator.pushReplacementNamed(context, SigninPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: _signupListener,
      builder: (ctx, state) => Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          reverse: true,
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
              enabled: state.status != SignupStatus.submitting,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Name',
                prefixIcon: Icon(Icons.account_box),
                border: OutlineInputBorder(),
              ),
              validator: _nameValidator,
              onSaved: (value) => _name = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              enabled: state.status != SignupStatus.submitting,
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
              controller: _passwordController,
              obscureText: true,
              enabled: state.status != SignupStatus.submitting,
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
            TextFormField(
              obscureText: true,
              enabled: state.status != SignupStatus.submitting,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Confirm password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              validator: _confirmPasswordValidator,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  state.status == SignupStatus.submitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(state.status == SignupStatus.submitting
                  ? 'Loading...'
                  : 'Sign Up'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: state.status == SignupStatus.submitting
                  ? null
                  : _gotoSigninPage,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
              ),
              child: const Text('Already a member? Sign In!'),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
