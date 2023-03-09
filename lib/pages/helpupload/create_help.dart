import 'dart:io';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/text_inputs/input_with_button_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/title_descs/drawer_title_desc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/constatns.dart';

class CreateHelpPage extends StatefulWidget {
  @override
  State<CreateHelpPage> createState() => _CreateHelpPageState();
}

class _CreateHelpPageState extends State<CreateHelpPage> {
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController hargaController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  var category = 'Lainnya';
  var categories = [
    'Game', 'Pembangunan', 'Kebersihan', 'Lainnya'
  ];
  var openMap = false;
  var location = null;
  LatLng? latLng = null;

  Widget PriceDrawerContent() {
    return Container(
      margin: EdgeInsets.only(
        top: 32,
        left: 24,
        right: 24
      ),
      child: ListView(
        children: [
          DrawerTitleDesc(
            title: 'Pilih Harga Cepat',
            desc: 'Pilih harga dengan cepat untuk mempermudah penginputan harga',
          )
        ],
      ),
    );
  }

  Widget CategoryDrawerContent() {
    return Container(
      child: Text('Category Drawer'),
    );
  }

  Widget ImageInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gambar Bantuan',
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: regular,
              color: black1
            ),
          ),
          SizedBox(height: 6,),
          Container(
            height: 132,
            decoration: BoxDecoration(
              border: Border.all(
                color: green3
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: green1
                ),
                width: 40,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent.withOpacity(0.1),
                    padding: EdgeInsets.all(0)
                  ),
                  onPressed: (){},
                  child: ImageCustom(
                    height: 18,
                    width: 18,
                    image: AssetImage('assets/icons/ic_plus_big.png'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget CategoryInput(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategori Bantuan',
            style: poppinsText.copyWith(
              fontSize: 14,
              fontWeight: regular,
              color: black1
            ),
          ),
          GestureDetector(
            onTap: (){
              showDrawer(context, Platform.isIOS ? 361 : 341, CategoryDrawerContent());
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.only(
                top: 6
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: green3
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: poppinsText.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                      color: black1
                    ),
                  ),
                  ImageCustom(
                    height: 8,
                    width: 16,
                    image: AssetImage('assets/icons/ic_down.png'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget LocationInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lokasi Bantuan',
            style: poppinsText.copyWith(
                fontSize: 14, fontWeight: regular, color: black1),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20
            ),
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.only(
              top: 6
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: green3
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                Text(
                  location ?? 'Pilih Lokasi',
                  style: poppinsText.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                    color: black1
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              MainHeader(
                title: 'Cari Bantuan',
                onBack: (){
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 24,
                    right: 24
                  ),
                  child: ListView(
                    children: [
                      ImageInput(),
                      SizedBox(height: 20,),
                      MainInputCustom(
                        title: "Judul Bantuan",
                        hint: "Masukkan Judul Bantuan",
                        controller: titleController,
                      ),
                      SizedBox(height: 20,),
                      InputWithButtonCustom(
                        inputType: TextInputType.number,
                        title: "Harga Bantuan",
                        hint: "Masukkan Judul Bantuan",
                        controller: hargaController,
                        onPress: (){
                          showDrawer(context, Platform.isIOS ? 361 : 341, PriceDrawerContent());
                        },
                        iconContent: ImageCustom(
                          height: 21,
                          width: 21,
                          image: AssetImage('assets/icons/ic_money.png'),
                        ),
                      ),
                      SizedBox(height: 20,),
                      CategoryInput(context),
                      SizedBox(height: 20,),
                      MainInputCustom(
                        title: "Deskripsi Bantuan",
                        hint: "Masukkan Deskripsi Bantuan",
                        controller: descController,
                      ),
                      SizedBox(height: 20,),
                      LocationInput(),
                      SizedBox(height: 32,),
                      MainButtonCustom(
                        title: 'Cari Bantuan',
                        onPressed: (){},
                      ),
                      SizedBox(height: 120,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}