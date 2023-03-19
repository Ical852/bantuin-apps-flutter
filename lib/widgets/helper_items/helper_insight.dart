import 'package:bantuin/widgets/helper_items/insight_items/total_help_insight.dart';
import 'package:bantuin/widgets/helper_items/insight_items/total_money_insight.dart';
import 'package:bantuin/widgets/helper_items/insight_items/total_rate_insight.dart';
import 'package:flutter/material.dart';

class HelperInsight extends StatelessWidget {

  int money, totalHelp;
  double rate;
  Function() onMoney, onHelp, onRate;

  HelperInsight({
    required this.money,
    required this.totalHelp,
    required this.rate,
    required this.onMoney,
    required this.onHelp,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TotalMoneyInsight(
            price: money,
            onPressed: onMoney,
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: TotalHelpInsight(
                    totalHelp: totalHelp,
                    onPressed: onHelp,
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: TotalRateInsight(
                    totalRate: rate,
                    onPressed: onRate,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}