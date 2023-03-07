import 'package:bantuin/shared/constatns.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class MenuItemCustom extends StatelessWidget {
  String icon;
  bool active;
  Function() onPress;

  MenuItemCustom({
    required this.icon,
    this.active = false,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {

    String getIcon() {
      if (icon == 'home') {
        return active ? 'ic_home_active.png' : 'ic_home.png';
      } else if (icon == 'explore') {
        return active ? 'ic_explore_active.png' : 'ic_explore.png';
      } else if (icon == 'chat') {
        return active ? 'ic_chat_active.png' : 'ic_chat.png';
      } else if (icon == 'profile') {
        return active ? 'ic_profile_active.png' : 'ic_profile.png';
      } else {
        return active ? 'ic_home_active.png' : 'ic_home.png';
      }
    }

    ImageProvider GeneratedIcon() {
      return AssetImage('assets/icons/' + getIcon());
    }

    String getMenuTitle() {
      if (icon == 'home') {
        return 'Home';
      } else if (icon == 'explore') {
        return 'Explore';
      } else if (icon == 'chat') {
        return 'Chats';
      } else if (icon == 'profile') {
        return 'Profile';
      } else {
        return 'Home';
      }
    }

    Text GeneratedText() {
      return Text(
        getMenuTitle(),
        style: poppinsText.copyWith(
          fontSize: 14,
          fontWeight: active ? semiBold : regular,
          color: active ? green1 : green3
        ),
      );
    }

    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageCustom(
              width: 24,
              height: 24,
              image: GeneratedIcon(),
            ),
            GeneratedText()
          ],
        ),
      ),
    );
  }
}