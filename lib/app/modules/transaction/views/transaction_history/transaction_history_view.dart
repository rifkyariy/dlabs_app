import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:dlabs_apps/app/modules/transaction/local_widgets/transaction_card_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';

class TransactionHistoryView extends GetView<TransactionViewController> {
  const TransactionHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: const [],
          elevation: 2.0,
          backgroundColor: Colors.white,
          shadowColor: lightGreyColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            color: const Color(0xFF1176BC),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Transaction History',
            style: BoldTextStyle(const Color(0xFF323F4B)),
          ),
          bottom: TabBar(
            unselectedLabelColor: greyColor,
            labelColor: blackColor,
            indicatorColor: primaryColor,
            tabs: const [
              Tab(text: 'In Progress'),
              Tab(text: 'Done'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => _inProgressTransactionList()),
            Obx(() => _doneTransactionList()),
          ],
        ),
      ),
    );
  }

  Widget _inProgressTransactionList() {
    return SizedBox(
      child: ListView.builder(
        itemCount: controller.transactions.length,
        itemBuilder: (context, index) {
          TRANSACTIONSTATUS _status = controller.transactions[index].status;

          bool _isInProgress = (_status != TRANSACTIONSTATUS.canceled) &&
              (_status != TRANSACTIONSTATUS.done) &&
              (_status != TRANSACTIONSTATUS.paymentRejected);

          if (_isInProgress) {
            return TransactionCardComponent(
              date: controller.transactions[index].date,
              id: controller.transactions[index].id,
              price: controller.transactions[index].price,
              status: controller.transactions[index].status,
              type: controller.transactions[index].type,
              onTap: () => {},
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _doneTransactionList() {
    return SizedBox(
      child: ListView.builder(
        itemCount: controller.transactions.length,
        itemBuilder: (context, index) {
          TRANSACTIONSTATUS _status = controller.transactions[index].status;

          bool _isInProgress = (_status != TRANSACTIONSTATUS.canceled) &&
              (_status != TRANSACTIONSTATUS.done) &&
              (_status != TRANSACTIONSTATUS.paymentRejected);

          if (!_isInProgress) {
            return TransactionCardComponent(
              date: controller.transactions[index].date,
              id: controller.transactions[index].id,
              price: controller.transactions[index].price,
              status: controller.transactions[index].status,
              type: controller.transactions[index].type,
              onTap: () => {},
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
