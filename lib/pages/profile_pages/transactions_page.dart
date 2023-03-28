import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/view_models/transaction_view_model.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/info_items/transaction_item.dart';
import 'package:bantuin/widgets/loading_custom.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late var trxVm = TransactionViewModel(context);

  var trxData = [];
  var loading = false;
  void toggleLoading(value) {
    this.setState(() {
      loading = value;
    });
  }

  void getTrxData() async {
    toggleLoading(true);
    var result = await trxVm.getTransactions();
    toggleLoading(false);

    this.setState(() {
      trxData = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getTrxData();
  }

  @override
  Widget build(BuildContext context) {
    Widget EmptyContent() {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: ImgTextDescMiniButton(
            image: 'assets/illustrations/il_emptytrx.png',
            title: 'Transaksi Kosong',
            desc: 'Sepertinya kamu belum memiliki transaksi sama sekali, silakan lakukan transaksi di aplikasi ini',
            width: 270,
            btnTitle: 'Ke Home',
            onPressed: (){
              Navigator.pushNamed(context, '/main');
            },
          ),
        ),
      );
    }

    Widget ExistContent() {
      return Container(
        child: ListView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24
          ),
          children: [
            Text(
              'All Transactions',
              style: mediumBlackSemibold,
            ),
            SizedBox(height: 16,),
            Column(
              children: trxData.map((trx) {
                return TransactionItem(transaction: trx);
              }).toList(),
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget LoadingContent() {
      return Container(
        child: LoadingCustom(title: 'Getting Transaction Data . . .'),
      );
    }

    Widget RenderContent() {
      return loading ? LoadingContent() : trxData.length > 0 ? ExistContent() : EmptyContent();
    }

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              title: 'Transactions',
              onBack: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: RenderContent(),
            )
          ],
        ),
      ),
    );
  }
}