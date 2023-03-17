import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/helper_items/customer_review.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/main_items/new_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/toggler/double_btn_toggler.dart';
import 'package:flutter/material.dart';

class HelperProfilePage extends StatefulWidget {
  @override
  State<HelperProfilePage> createState() => _HelperProfilePageState();
}

class _HelperProfilePageState extends State<HelperProfilePage> {
  var currentToggle = 'left';
  void toggleToggler(toggle) {
    this.setState(() {
      currentToggle = toggle;
    });
  }

  var emptyRecords = false;
  var emptyReviews = false;

  @override
  Widget build(BuildContext context) {

    Widget ProfileImg() {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 2)
            )
          ]
        ),
        child: ImageCustom(
          height: double.infinity,
          width: double.infinity,
          image: AssetImage('assets/dummies/user1.png'),
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(14)
        ),
      );
    }

    Widget ProfileDetail() {
      return Container(
        child: Column(
          children: [
            Text(
              'James Curt',
              style: baseBlackSemibold,
            ),
            Text(
              'Helper',
              style: regularGrayRegular,
            )
          ],
        ),
      );
    }

    Widget ContainerTag(List<Widget> children) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 2)
            )
          ]
        ),
        child: Row(
          children: children,
        ),
      );
    }

    Widget ProfileTag() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerTag([
              Text(
                "312",
                style: smallGrayRegular,
              ),
              ImageCustom(
                margin: EdgeInsets.only(left: 4),
                height: 16,
                width: 16,
                image: AssetImage('assets/icons/ic_hand_shake.png'),
              )
            ]),
            SizedBox(width: 16,),
            ContainerTag([
              Text(
                "Active",
                style: smallGrayRegular,
              ),
            ]),
            SizedBox(width: 16,),
            ContainerTag([
              Text(
                "4.8",
                style: smallGrayRegular,
              ),
              ImageCustom(
                margin: EdgeInsets.only(left: 4),
                height: 16,
                width: 16,
                image: AssetImage('assets/icons/ic_star_mini.png'),
              )
            ]),
          ],
        ),
      );
    }

    Widget ProfileContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 52
        ),
        child: Column(
          children: [
            ProfileImg(),
            SizedBox(height: 16,),
            ProfileDetail(),
            SizedBox(height: 13,),
            ProfileTag(),
            SizedBox(height: 56,),
          ],
        ),
      );
    }

    Widget EmptyRecord() {
      return Container(
        margin: EdgeInsets.only(
          top: 100
        ),
        child: Center(
          child: Text(
            'No Records Yet',
            style: mediumBlackSemibold,
          ),
        ),
      );
    }

    Widget ExistRecord() {
      return Container(
        margin: EdgeInsets.only(
          top: 16
        ),
        child: Column(
          children: [
            NewItem(
              image: 'assets/dummies/dummy4.png',
              title: 'Bantu Push Rank',
              desc: 'Bantu gua push rank sampe mytical glory',
              location: 'Bekasi, Indonesia',
              price: 370000,
              onPress: () {},
              noButton: true,
            ),
            NewItem(
              image: 'assets/dummies/dummy5.png',
              title: 'Bantu Steam Mobil',
              desc: 'Bantu cuci mobil di steam gua, 20k / mobil',
              location: 'Bekasi, Indonesia',
              price: 580000,
              onPress: () {},
              noButton: true,
            ),
            NewItem(
              image: 'assets/dummies/dummy6.png',
              title: 'Bantu Cor Atap',
              desc: 'bantu cor atap rumah gua, beres 300k sung gas',
              location: 'Bekasi, Indonesia',
              price: 300000,
              onPress: () {},
              noButton: true,
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget RenderInnerRecordContent() {
      return emptyRecords ? EmptyRecord() : ExistRecord();
    }

    Widget RecordContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Helper’s Bantuan Records',
              style: mediumBlackSemibold,
            ),
            RenderInnerRecordContent()
          ],
        ),
      );
    }

    Widget EmptyReview() {
      return Container(
        margin: EdgeInsets.only(
          top: 100
        ),
        child: Center(
          child: Text(
            'No Reviews Yet',
            style: mediumBlackSemibold,
          ),
        ),
      );
    }

    Widget ExistReview() {
      return Container(
        margin: EdgeInsets.only(
          top: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerReview(
              image: 'assets/dummies/user2.png',
              name: 'Rosalie Emily',
              desc: 'One of the best courses that i have ever finished, this course is very recommended for who like to learn how to convert wireframe to real visual design. Amazing !!!',
              rate: 5,
            ),
            CustomerReview(
              image: 'assets/dummies/user3.png',
              name: 'Anna Joeson',
              desc: 'One of the best courses that i have ever finished, this course is very recommended for who like to learn how to convert wireframe to real visual design. Amazing !!!',
              rate: 4,
            ),
            CustomerReview(
              image: 'assets/dummies/user4.png',
              name: 'Rosalie Emily',
              desc: 'One of the best courses that i have ever finished, this course is very recommended for who like to learn how to convert wireframe to real visual design. Amazing !!!',
              rate: 3,
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget RenderInnerReviewContent() {
      return emptyReviews ? EmptyReview() : ExistReview();
    }

    Widget ReviewsContent() {
      return Container(
        margin: EdgeInsets.only(
          top: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer’s Reviews',
              style: mediumBlackSemibold,
            ),
            RenderInnerReviewContent()
          ],
        ),
      );
    }

    Widget RenderInnerContent() {
      return currentToggle == 'left' ? RecordContent() : ReviewsContent();
    }

    Widget MainContent() {
      return Container(
        padding: EdgeInsets.only(
          top: 36,
          left: 24,
          right: 24
        ),
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: screenHeightPercentage(context, 0.6)
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          ),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.9),
              blurRadius: 9,
              offset: Offset(0, 9)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoubleBtnToggler(
              current: currentToggle,
              left: 'Helpers Record',
              right: 'Reviews',
              leftPress: () => toggleToggler('left'),
              rightPress: () => toggleToggler('right'),
            ),
            RenderInnerContent()
          ],
        ),
      );
    }

    Widget AcceptDrawerContent() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(
              height: 24,
            ),
            ImgDescBtn(
              image: 'assets/illustrations/il_accept.png',
              title: 'Terima Request',
              desc: 'Kamu yakin untuk menerima request dari Helper James Curt ?',
              onPress: () {
                Navigator.pushNamed(context, '/my-bantuan-accept-success');
              },
            )
          ],
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: grey7,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MainHeader(
                  title: 'Helper Profile',
                  onBack: (){
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ProfileContent(),
                      MainContent()
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Marginner(
                margin: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 32
                ),
                child: MainButtonCustom(
                  title: 'Terima Helper',
                  onPressed: (){
                    showDrawer(context, 398, AcceptDrawerContent());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}