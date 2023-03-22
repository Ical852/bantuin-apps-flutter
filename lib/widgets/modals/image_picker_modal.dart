import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/mini_button_icon_custom.dart';
import 'package:flutter/material.dart';

class ImagePickerModal extends StatelessWidget {
  Function() bgPress, onCamera, onLibrary;
  ImagePickerModal({
    required this.bgPress,
    required this.onCamera,
    required this.onLibrary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: bgPress,
      child: Container(
        color: black.withOpacity(0.5),
        width: double.infinity,
        height: double.infinity,
        child: SimpleDialog(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Pilih Pengambilan Gambar',
                    style: mediumBlackSemibold
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'Pilih Dari Mana Kamu Ingin Mengambil Gambar Kamu',
                    style: poppinsText.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                      color: black1
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MiniButtonIconCustom(
                        icon: Icons.folder,
                        title: 'Library',
                        onPress: onLibrary,
                      ),
                      SizedBox(width: 8,),
                      MiniButtonIconCustom(
                        icon: Icons.camera_alt,
                        title: 'Camera',
                        onPress: onCamera,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}