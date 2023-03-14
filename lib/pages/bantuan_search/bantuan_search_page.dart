import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/pages/bantuan_search/modes/search_mode.dart';
import 'package:bantuin/pages/bantuan_search/modes/searched_mode.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/mini_button_icon_custom.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/modals/dialog_modal.dart';
import 'package:flutter/material.dart';

class BantuanSerachPage extends StatefulWidget {
  @override
  State<BantuanSerachPage> createState() => _BantuanSerachPageState();
}

class _BantuanSerachPageState extends State<BantuanSerachPage> {
  var submitted = false;
  var choosedText = "";
  TextEditingController searchController = TextEditingController(text: "");
  void toggleSubmitted(value) {
    this.setState(() {
      submitted = value;
    });
  }
  void onSubmitted(submittedText) {
    if (submittedText != "") {
      toggleSubmitted(true);
    } else {
      toggleSubmitted(false);
    }
  }
  
  var mostSearched = [
    'Cleaning', 'Push Rank', 'Desain', 'Sapu Halaman', 'Ngeronda'
  ];
  var histories = [
    'Bantu Buat Website', 'Bantu Buat Mobile', 'Bantu Bersihin Kolam'
  ];
  void onChoose(choosed) {
    searchController.text = choosed;
    toggleSubmitted(true);
  }

  var showLongPressedDialog = false;
  void toggleShowLongPressDialog(value) {
    this.setState(() {
      showLongPressedDialog = value;
    });
  }
  void onLongPress(choosed) {
    this.setState(() {
      choosedText = choosed;
    });
    toggleShowLongPressDialog(true);
  }
  void onLongPressDelete() {
    this.setState(() {
      histories = histories.where((val) => val != choosedText).toList();
      showLongPressedDialog = false;
    });
  }

  var showDeleteConfirm = false;
  void toggleDeleteConfirm(value) {
    this.setState(() {
      showDeleteConfirm = value;
    });
  }
  void onDeleteHistory() {
    toggleDeleteConfirm(true);
  }
  void onDeleteConfirmed() {
    this.setState(() {
      histories = [];
      showDeleteConfirm = false;
    });
    showGLobalAlert('success', 'Berhasil Menghapus Riwayat Pencarian', context);
  }

  @override
  Widget build(BuildContext context) {
    Widget SearchBar() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8)
        ),
        height: 40,
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Explore Campaign',
                  hintStyle: regularGrayRegular
                ),
                onFieldSubmitted: onSubmitted,
                autofocus: true,
                controller: searchController,
                style: regularBlackRegular,
              ),
            ),
            ImageCustom(
              width: 20,
              height: 20,
              image: AssetImage('assets/icons/ic_search_green.png'),
              margin: EdgeInsets.only(
                left: 16
              ),
            )
          ],
        ),
      );
    }

    Widget HeaderContent() {
      return Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 16,
          top: 16 + safeAreaPadding(context),
        ),
        height: 72 + safeAreaPadding(context),
        color: green1,
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: ImageCustom(
                    width: 24,
                    height: 24,
                    image: AssetImage('assets/icons/ic_back.png'),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16,),
            Expanded(
              child: SearchBar()
            )
          ],
        ),
      );
    }

    Widget RenderContent() {
      return submitted ? 
      SearchedMode()
      : 
      SearchMode(mostSearched, histories, onChoose, onDeleteHistory, onLongPress);
    }

    Widget DeleteConfirmDialog() {
      return showDeleteConfirm ?
      GestureDetector(
        onTap: () => toggleDeleteConfirm(false),
        child: DialogModal(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Perhatian',
                    style: mediumBlackSemibold
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'Hapus Semua Riwayat Pencarian Kamu?',
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
                      RawButtonCustom(
                        height: 40,
                        onPress: () => toggleDeleteConfirm(false),
                        title: 'Batal',
                        color: red1,
                      ),
                      SizedBox(width: 8,),
                      RawButtonCustom(
                        height: 40,
                        onPress: onDeleteConfirmed,
                        title: 'Hapus',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
      :
      SizedBox();
    }

    Widget LongPressDialog() {
      return showLongPressedDialog ?
      GestureDetector(
        onTap: () => toggleShowLongPressDialog(false),
        child: DialogModal(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Info',
                    style: mediumBlackSemibold
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Hapus Riwayat " + choosedText + " ?",
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
                      RawButtonCustom(
                        height: 40,
                        onPress: onLongPressDelete,
                        title: 'Hapus',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
      :
      SizedBox();
    }

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Column(
            children: [
              HeaderContent(),
              Expanded(
                child: RenderContent(),
              )
            ],
          ),
          DeleteConfirmDialog(),
          LongPressDialog()
        ],
      ),
    );
  }
}