import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/views/pages/auth_page.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import '../../utilities/enums.dart';
import '../../utilities/routes.dart';
import '../widgets/default_toast.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);


  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
      const DefaultToast(message: 'successfully logged out', state: ToastStates.success)
          .showToast();
      Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
          builder: (context) =>
           const AuthPage()), (route) => false);
    } catch (e) {
      debugPrint('logout error: $e');
      const DefaultToast(message: 'something went wrong!', state: ToastStates.error)
          .showToast();
    }
  }

  @override
  Widget build(BuildContext context) {

    return
       Consumer<AuthController>(
        builder: (_, model, __) =>
         Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: MainButton(text: 'Log Out', onTap: (){
                _logout(model, context);
              }),
            )
          ],
        ),
      );

  }

}
