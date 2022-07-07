 import 'package:flutter/material.dart';

class CustomAppBar {
  final  String title;
  final bool hasIcon;
  final Icon? icon;
  final VoidCallback? iconEvent;
  final bool hasBackNav;
  final VoidCallback? backNavEvent;
  final bool hasBottomContent;
  final PreferredSizeWidget? bottomContent;
  
  CustomAppBar({

    required this.title,
    required this.hasIcon,
    this.icon, 
    this.iconEvent,
    required this.hasBackNav,
    this.backNavEvent,
    required this.hasBottomContent,
    this.bottomContent,
  });
  AppBar build(BuildContext context){
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: null,
        foregroundColor: Colors.black,
        bottom:bottomContent,//_buildAppBarBottom(context, subCategoriesList),
        title: Row(
          children: [
            if(hasBackNav)  InkWell(
                onTap: backNavEvent,
                child: const Icon(Icons.arrow_back_ios)),
            const Spacer(),
            Text(title),
            const Spacer(),
            if(hasIcon)  InkWell(
                onTap: iconEvent,
                child: icon!)
          ],
        ),
      );
  }
} 
