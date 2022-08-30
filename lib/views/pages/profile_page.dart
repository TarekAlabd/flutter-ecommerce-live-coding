import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../services/auth.dart';
import '../widgets/custom_buttons/primary_button.dart';
import '../widgets/custom_buttons/primary_icon_button.dart';
import 'my_orders_pagr.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _logout(AuthController model, context) async {
    await model.logout();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(auth: auth),
      child: Consumer<AuthController>(
        builder: (_, model, __) {
          return Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          //  bottom: 20,
                        ),
                        child: InkWell(
                          child: Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'My Profile',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: DecoratedBox(
                            child: const Icon(
                              Icons.person_outline_sharp,
                              size: 45,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(45),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('username',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text(
                                'test@tes.com',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 420,
                    width: double.infinity,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: [
                        ListViewItem.build(
                          'My Orders',
                          'Already have 12 orders',
                          () => Navigator.of(context).push(
                            CupertinoPageRoute(builder: (_)=>const MyOrdersPage() ),
                            //(e) => false
                          ),
                        ),
                        ListViewItem.build('Shipping Addresses',
                            'Already have 3 addresses', () {}),
                        ListViewItem.build(
                            'Payment Methods', 'Visa ***98', () {}),
                        ListViewItem.build(
                            'Promo Codes', 'You have Special Codes', () {}),
                        ListViewItem.build(
                            'My Reviews', 'Reviews fo 5 items', () {}),
                        ListViewItem.build(
                            'Settings', 'Notifications,Password', () {}),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(label_: 'Logout',onTapAction: ()=> _logout(model, context),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ListViewItem {
  static Widget build(String title, String subTitle, VoidCallback event) {
    return InkWell(
      onTap: event,
      child: DecoratedBox(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: ListTile(
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          title: Text(title),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
}
