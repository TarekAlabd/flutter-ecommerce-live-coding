import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';
import '../widgets/default_toast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if (!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
    } catch (e) {
      // TODO: We will refactor this code into another widget in the next session
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Error!',
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Text(
            e.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _submit2(AuthController model) async {
    try {
      await model.submit();
      const DefaultToast(message: 'successfully logged in', state: ToastStates.success)
          .showToast();
      if (!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
    } catch (e) {
      const DefaultToast(message: 'incorrect email or password', state: ToastStates.error)
          .showToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthController>(
      builder: (_, model, __) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 32.0,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 80.0),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        textInputAction: TextInputAction.next,
                        onChanged: model.updateEmail,
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
                        focusNode: _passwordFocusNode,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your password!' : null,
                        onChanged: model.updatePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your pasword!',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      if (model.authFormType == AuthFormType.login)
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: const Text('Forgot your password?'),
                            onTap: () {},
                          ),
                        ),
                      const SizedBox(height: 24.0),
                      MainButton(
                        text: model.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _submit2(model);
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Text(
                            model.authFormType == AuthFormType.login
                                ? 'Don\'t have an account? Register'
                                : 'Have an account? Login',
                          ),
                          onTap: () {
                            _formKey.currentState!.reset();
                            model.toggleFormType();
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.09),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            model.authFormType == AuthFormType.login
                                ? 'Or Login with'
                                : 'Or Register with',
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
          ),
        );
      },
    );
  }
}
