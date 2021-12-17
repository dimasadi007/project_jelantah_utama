import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget modalChangeDate(String orderid, String created_date, String alamat,
    String estimasi, String volume) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID ' + orderid,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 43, 80, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                created_date,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(155, 199, 237, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Alamat',
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(155, 199, 237, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          alamat,
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(77, 107, 132, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Estimasi Penjemputan',
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(155, 199, 237, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          estimasi,
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(77, 107, 132, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Volume',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(155, 199, 237, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  volume + ' Liter',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(77, 107, 132, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
