import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:flutter/material.dart';

class TransactionCardComponent extends StatelessWidget {
  const TransactionCardComponent({
    Key? key,
    required this.id,
    required this.type,
    required this.date,
    required this.price,
    required this.status,
    this.onTap,
  }) : super(key: key);

  final String id, type, date;
  final double price;
  final TRANSACTIONSTATUS status;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 24, right: 24),
      width: double.infinity,
      height: 95,
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Upper Part
                _upperPart(
                  id: id,
                  transactionStatus: status,
                ),

                // Devide
                Divider(
                  color: greyColor,
                  height: 0,
                  thickness: 0.3,
                ),

                // Bottom Part
                _bottomPart(type: type, date: date, price: price)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Upper part of the card
  /// it consist of id and status box
  Widget _upperPart(
      {required String id, required TRANSACTIONSTATUS transactionStatus}) {
    String _status = '';
    Color _boxColor = primaryColor;
    Color _textColor = primaryColor;

    switch (transactionStatus) {
      case TRANSACTIONSTATUS.newTransaction:
        _status = 'New';
        break;
      case TRANSACTIONSTATUS.inProgress:
        _status = 'In Progress';
        break;
      case TRANSACTIONSTATUS.readyToLab:
        _status = 'Ready to Lab';
        break;
      case TRANSACTIONSTATUS.resultVerification:
        _status = 'Result verification';
        break;
      case TRANSACTIONSTATUS.canceled:
        _status = 'Canceled';
        _boxColor = redAlertColor;
        _textColor = redAlertColor;
        break;
      case TRANSACTIONSTATUS.done:
        _status = 'Done';
        _boxColor = greenSuccessColor;
        _textColor = greenSuccessColor;
        break;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 9, 18, 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            id,
            style: BoldTextStyle(primaryColor, fontSize: 12),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 3),
            decoration: BoxDecoration(
              border: Border.all(color: _boxColor, width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              _status,
              style: smallTextStyle(_textColor, fontSize: 9),
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomPart(
      {required String type, required String date, required double price}) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: regularTextStyle(blackColor, fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: regularTextStyle(greyColor, fontSize: 10),
              )
            ],
          ),
          Text(
            'Rp $price,-',
            style: BoldTextStyle(blackColor, fontSize: 12),
          )
        ],
      ),
    );
  }
}
