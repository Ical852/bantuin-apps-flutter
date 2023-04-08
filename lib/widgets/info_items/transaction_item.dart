import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/models/transaction_model.dart';
import 'package:bantuin/shared/constants.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/info_items/status_tag.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {

  TransactionModel transaction;

  TransactionItem({
    required this.transaction,
  });

  String trxType() {
    return transaction.transactionType == 'topup' ? 'Top Up Bantuin Money' : 'Create Bantuan';
  }

  String payMethod() {
    var payMethods = transaction.paymentMethod;

    return payMethods == 'midtrans' ? 'Midtrans' : payMethods == 'cash' ? 'Cash on Delivery' : 'Bantuin Money';
  }

  String generateTitle() {
    return trxType() + " - " + payMethod();
  }

  bool getStatus() {
    return transaction.status != 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16
      ),
      margin: EdgeInsets.only(
        bottom: 20
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    generateTitle(),
                    style: regularBlackSemibold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 11,),
                  Text(
                    formatter(transaction.grossAmount),
                    style: mediumBlackSemibold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 11,),
                  StatusTag(
                    failed: getStatus(),
                  )
                ],
              ),
            ),
            SizedBox(width: 16,),
            Text(
              getDayMonth(getDate(transaction)['year'], getDate(transaction)['month'], getDate(transaction)['day']),
              style: xSmallGrayLight,
            )
          ],
        ),
    );
  }
}