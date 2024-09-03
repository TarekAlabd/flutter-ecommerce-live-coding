import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/auth/auth_cubit.dart';
import 'package:flutter_ecommerce/utilities/assets.dart';
import 'package:flutter_ecommerce/utilities/enums.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/main_dialog.dart';
import 'package:flutter_ecommerce/views/widgets/social_media_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);

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
                    authCubit.authFormType == AuthFormType.login
                        ? 'Login'
                        : 'Register',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 80.0),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    textInputAction: TextInputAction.next,
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
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your pasword!',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (authCubit.authFormType == AuthFormType.login)
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Text('Forgot your password?'),
                        onTap: () {},
                      ),
                    ),
                  const SizedBox(height: 24.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) =>
                        current is AuthFailed || current is AuthSuccess,
                    listener: (context, state) {
                      if (state is AuthFailed) {
                        MainDialog(
                          title: state.error,
                          content: state.error,
                          context: context,
                        ).showAlertDialog();
                      } else if (state is AuthSuccess) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.bottomNavBarRoute);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthSuccess ||
                        current is AuthFailed ||
                        current is AuthInitial,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      }
                      return MainButton(
                        text: authCubit.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            authCubit.authFormType == AuthFormType.login
                                ? await authCubit.login(_emailController.text,
                                    _passwordController.text)
                                : await authCubit.signUp(_emailController.text,
                                    _passwordController.text);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        authCubit.authFormType == AuthFormType.login
                            ? 'Don\'t have an account? Register'
                            : 'Have an account? Login',
                      ),
                      onTap: () {
                        _formKey.currentState!.reset();
                        authCubit.toggleFormType();
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.09),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        authCubit.authFormType == AuthFormType.login
                            ? 'Or Login with'
                            : 'Or Register with',
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        iconName: AppAssets.facebookIcon,
                        onPress: () {},
                      ),
                      const SizedBox(width: 16.0),
                      SocialMediaButton(
                        iconName: AppAssets.googleIcon,
                        onPress: () {},
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
  }
}
