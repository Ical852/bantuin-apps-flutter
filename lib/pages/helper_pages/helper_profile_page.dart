import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/helper_model.dart';
import 'package:bantuin/models/helper_rate_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/bantuan_order_view_model.dart';
import 'package:bantuin/view_models/helper_view_model.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/helper_items/customer_review.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/img_text_btn/img_desc_btn.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:bantuin/widgets/main_items/new_item.dart';
import 'package:bantuin/widgets/marginner.dart';
import 'package:bantuin/widgets/toggler/double_btn_toggler.dart';
import 'package:flutter/material.dart';

class HelperProfilePage extends StatefulWidget {
  @override
  State<HelperProfilePage> createState() => _HelperProfilePageState();

  int orderId;
  HelperModel helper;
  HelperProfilePage(this.helper, this.orderId);
}

class _HelperProfilePageState extends State<HelperProfilePage> {
  late var helperVm = HelperViewModel(context);
  late var orderVm = BantuanOrderViewModel(context);

  var currentToggle = 'left';
  void toggleToggler(toggle) {
    this.setState(() {
      currentToggle = toggle;
    });
  }

  List<HelperRateModel> data = [];
  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  var accepting = false;
  void toggleAccepting(value) {
    this.setState(() {
      accepting = value;
    });
  }

  var totalRecords = 0;
  var totalRate = 0.0;
  var status = 'Active';

  void getAllRecords() async {
    toggleLoading(true);
    var result = await helperVm.getAllRecords(helperId: this.widget.helper.id);
    toggleLoading(false);

    this.setState(() {
      data = result;
      totalRecords = result.length;
      totalRate = double.parse(result.map((m) => m.rating).reduce((a, b) => a + b).toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getAllRecords();
  }

  void acceptHelper() async {
    Navigator.pop(context);
    toggleAccepting(true);
    var result = await orderVm.acceptOrder(orderId: this.widget.orderId);
    toggleAccepting(false);

    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/my-bantuan-accept-success', (route) => false);
    }
  }

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
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(14),
          network: true,
          nwUrl: this.widget.helper.user!.image,
        ),
      );
    }

    Widget ProfileDetail() {
      return Container(
        child: Column(
          children: [
            Text(
              this.widget.helper.user!.fullName,
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
                totalRecords.toString(),
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
                status,
                style: smallGrayRegular,
              ),
            ]),
            SizedBox(width: 16,),
            ContainerTag([
              Text(
                totalRate.toString(),
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
            Column(
              children: data.map((record) {
                return NewItem(
                  bantuan: record.bantuan!,
                  onPress: () {},
                  noButton: true,
                );
              }).toList(),
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget LoadingRecord() {
      return Container(
        margin: EdgeInsets.only(
          top: 64
        ),
        child: LoadingCustom(
          title: 'Getting Records Data',
        ),
      );
    }

    Widget RenderInnerRecordContent() {
      return loading ? LoadingRecord() : data.length > 0 ? ExistRecord() : EmptyRecord();
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
            Column(
              children: data.map((review) {
                return CustomerReview(
                  image: review.user!.image,
                  name: review.user!.fullName,
                  desc: review.message,
                  rate: review.rating,
                );
              }).toList(),
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget LoadingReview() {
      return Container(
        margin: EdgeInsets.only(
          top: 64
        ),
        child: LoadingCustom(
          title: 'Getting Reviews Data',
        ),
      );
    }

    Widget RenderInnerReviewContent() {
      return loading ? LoadingReview() : data.length > 0 ? ExistReview() : EmptyReview();
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
                acceptHelper();
              },
            )
          ],
        ),
      );
    }
    
    Widget LoadingContent() {
      return Container(
        color: black.withOpacity(0.5),
        child: LoadingCustom(
          title: 'Accepting . . .',
          isWhite: true,
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
            ),
            accepting ? LoadingContent() : SizedBox()
          ],
        ),
      ),
    );
  }
}