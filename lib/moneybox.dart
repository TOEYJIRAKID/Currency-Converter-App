import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//สร้าง container ต้นแบบ
class MoneyBox extends StatelessWidget {

  String title;
  double amount;
  Color color;
  double size;

  MoneyBox(this.title, this.amount, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10)),
      height: size,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            '${NumberFormat("#,###.##").format(amount)}',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        )
      ]),
    );
  }
}
