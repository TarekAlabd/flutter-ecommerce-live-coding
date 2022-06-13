import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';
import 'package:flutter_ecommerce/utilities/constants/image_manager.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/input.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/social_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.registerPageRoute,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Input(
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        name: 'email',
                        placeholder: 'Please enter your email',
                        label: 'Email',
                        onChange: (value) {},
                        onValidate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Input(
                        onEditingComplete: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        focusNode: _passwordFocusNode,
                        name: 'password',
                        placeholder: 'Please enter your password',
                        label: 'Password',
                        onChange: (value) {},
                        onValidate: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        onPressed: () {
                          debugPrint('pressed');
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: ColorManager.kBlack,
                            ),
                          ),
                        ),
                      ),
                      MainButton(
                        text: 'LOGIN',
                        onTap: () {
                          _formKey.currentState?.save();
                          if (_formKey.currentState!.validate()) {
                            var user = _formKey.currentState!.value;
                            debugPrint("user $user");
                          } else {
                            debugPrint("validation failed");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Or login with social account',
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      iconName: ImageManager.googleLogo,
                      onPress: () {
                        debugPrint('pressed');
                      },
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    SocialButton(
                      iconName: ImageManager.facebookLogo,
                      onPress: () {
                        debugPrint('pressed');
                      },
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
