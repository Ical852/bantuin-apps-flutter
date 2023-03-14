import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/img_text_btn/img_text_desc_minibtn.dart';
import 'package:bantuin/widgets/info_items/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  var empty = false;

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
            TransactionItem(
              title: 'Top Up Bantuin Money - Midtrans',
              price: 275000,
              date: [2023, 05, 20],
              failed: true,
            ),
            TransactionItem(
              title: 'Bayar Helper - Midtrans',
              price: 575000,
              date: [2023, 05, 22],
            ),
            TransactionItem(
              title: 'Bayar Helper - Bantuin Money',
              price: 375000,
              date: [2023, 05, 25],
            ),
            TransactionItem(
              title: 'Bayar Helper - Cash on Delivery',
              price: 10375000,
              date: [2023, 05, 28],
            ),
            SizedBox(height: 120,)
          ],
        ),
      );
    }

    Widget RenderContent() {
      return empty ? EmptyContent() : ExistContent();
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