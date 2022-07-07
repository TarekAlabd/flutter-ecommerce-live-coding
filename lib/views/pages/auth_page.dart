import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
 
import '../../controllers/auth_controller.dart';
import '../../services/auth.dart';
import '../../utilities/assets.dart';
import '../../utilities/colors.dart';
import '../../utilities/enums.dart';
import '../../utilities/form_validator.dart';
import '../../utilities/routes.dart';
import '../../utilities/strings.dart';
import '../widgets/custom_buttons/primary_icon_button.dart';
import '../widgets/custom_buttons/white_image_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formkey_ = GlobalKey<FormState>();
  final emailController_ = TextEditingController();
  final emailFocusNode_ = FocusNode();
  final passwordController_ = TextEditingController();
  final passwordFocusNode_ = FocusNode();

  //var authType = AuthTypes.login;

  @override
  void dispose() {
    emailController_.dispose();
    passwordController_.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if(!mounted) return;
      //Navigator.of(context).pushNamed(AppRoute.landingPageRoute);
    } catch (ex) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'Error !',
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Text(
            ex.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(auth: auth),
      child: Consumer<AuthController>(
        builder: (_, model, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 32.0,
                ),
                child: Form(
                  key: formkey_,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //Horizntal Aligment
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          model.authFormType == AuthTypes.login
                              ? Strings.login
                              : Strings.register,
                          style: Theme.of(context).textTheme.headline4),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Please Enter Your Access Info',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                          controller: emailController_,
                          focusNode: emailFocusNode_,
                          onChanged: model.updateEmail,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(passwordFocusNode_),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return Strings.formHint + Strings.email;
                            } else {
                              if (!FormValidator.isValidEmail(val)) {
                                return "${Strings.formHint} a valid ${Strings.email}";
                              }
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: Strings.email,
                              hintText: Strings.formHint + Strings.email)),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty
                            ? Strings.formHint + Strings.password
                            : null,
                        obscureText: true,
                        controller: passwordController_,
                        focusNode: passwordFocusNode_,
                        onChanged: model.updatePassword,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: Strings.password,
                            hintText: Strings.formHint + Strings.password),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (model.authFormType == AuthTypes.login)
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.forgetPasswordPageRoute);
                            },
                            child: const Text(
                              Strings.forgetPassword + '? ',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: PrimaryIconButton(
                          label_: model.authFormType == AuthTypes.login
                              ? Strings.login
                              : Strings.register,
                          icon_: const Icon(Icons.login),
                          onTapAction: () {
                            bool res = formkey_.currentState!.validate();
                            if (res) {
                              _submit(model);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        //alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.authFormType == AuthTypes.login
                                  ? Strings.dontHaveAcc
                                  : Strings.alreadyHaveAcc,
                            ),
                            InkWell(
                              child: Text(
                                model.authFormType == AuthTypes.login
                                    ? Strings.register
                                    : Strings.login,
                                style: const TextStyle(color: primaryColor),
                              ),
                              onTap: () {
                                formkey_.currentState!.reset();
                                debugPrint(model.authFormType.toString());

                                model.toggleFormType();
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Or ${model.authFormType == AuthTypes.login ? Strings.login : Strings.register} with social",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WhiteImagButton(
                                imageUrl_: AppAssets.googleAuthAsset,
                                onTapAction: () {}),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: WhiteImagButton(
                                imageUrl_: AppAssets.facebookAuthAsset,
                                onTapAction: () {},
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
