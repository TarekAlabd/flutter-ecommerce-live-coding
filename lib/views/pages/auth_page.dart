import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _authType = AuthFormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 60.0,
            horizontal: 32.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _authType == AuthFormType.login ? 'Login' : 'Register',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 80.0),
                TextFormField(
                  controller: _emailController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your email!' : null,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email!',
                  ),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: _passwordController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your password!' : null,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your pasword!',
                  ),
                ),
                const SizedBox(height: 16.0),
                if (_authType == AuthFormType.login)
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Text('Forgot your password?'),
                      onTap: () {},
                    ),
                  ),
                const SizedBox(height: 24.0),
                MainButton(
                  text: _authType == AuthFormType.login ? 'Login' : 'Register',
                  onTap: () {},
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text(_authType == AuthFormType.login ? 'Don\'t have an account? Register' : 'Have an account? Login',),
                    onTap: () {
                      setState(() {
                        if (_authType == AuthFormType.login) {
                          _authType = AuthFormType.register;
                        } else {
                          _authType = AuthFormType.login;
                        }
                      });
                    },
                  ),
                ),
                const Spacer(),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      _authType == AuthFormType.login ? 'Or Login with' : 'Or Register with',
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 16.0),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
