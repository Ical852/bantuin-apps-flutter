import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/search_item/most_searched_item.dart';
import 'package:bantuin/widgets/search_item/search_history_item.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';

class SearchMode extends StatelessWidget {

  List<String> mostSearched, histories;
  Function(String) onChoose, onLongPress;
  Function() onDelete; 
  SearchMode(this.mostSearched, this.histories, this.onChoose, this.onDelete, this.onLongPress);
  @override
  Widget build(BuildContext context) {
    Widget MostSearchedContent() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Searched',
              style: baseBlackSemibold,
            ),
            SizedBox(height: 12,),
            ExtendedWrap(
              maxLines: 2,
              spacing: 6,
              children: this.mostSearched.map((value) {
                return MostSearchedItem(
                  title: value,
                  onPress: () {
                    onChoose(value);
                  },
                );
              }).toList(),
            )
          ],
        ),
      );
    }

    Widget HistoriesContent() {
      return Container(
        child: Column(
          children: histories.map((value) {
            return SearchHistoryItem(
              title: value,
              onPress: (){
                onChoose(value);
              },
              onLongPress: (){
                onLongPress(value);
              },
            );
          }).toList(),
        ),
      );
    }

    Widget DeleteHistoryButton() {
      return histories.length > 0 ?
      GestureDetector(
        onTap: onDelete,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: grey2
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hapus riwayat pencarian',
                style: regularBlackRegular,
              ),
              SizedBox(width: 6,),
              ImageCustom(
                height: 16,
                width: 16,
                image: AssetImage('assets/icons/ic_delete.png'),
              )
            ],
          ),
        ),
      )
      :
      SizedBox();
    }

    return Container(
      child: ListView(
        padding: EdgeInsets.only(
          top: 24
        ),
        children: [
          MostSearchedContent(),
          SizedBox(height: 8,),
          HistoriesContent(),
          DeleteHistoryButton()
        ],
      ),
    );
  }
}