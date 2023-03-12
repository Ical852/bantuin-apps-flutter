import 'package:bantuin/pages/bantuan_search/modes/searched_mode.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class BantuanSerachPage extends StatefulWidget {
  @override
  State<BantuanSerachPage> createState() => _BantuanSerachPageState();
}

class _BantuanSerachPageState extends State<BantuanSerachPage> {
  var submitted = false;
  TextEditingController searchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget HeaderContent() {
      return Container(
        padding: EdgeInsets.only(
          bottom: 16,
          left: 24,
          right: 24,
          top: 66
        ),
        height: 122,
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
              child: Container(
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
                        onFieldSubmitted: ((value) => {
                          print(value)
                        }),
                        autofocus: true,
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
              ),
            )
          ],
        ),
      );
    }

    Widget RenderContent() {
      return submitted ? SearchedMode() : SearchedMode();
    }

    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          HeaderContent(),
          Expanded(
            child: RenderContent(),
          )
        ],
      ),
    );
  }
}