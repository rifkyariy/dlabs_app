import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:dlabs_apps/app/global_widgets/app_empty_state.dart';
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
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  Obx(
                    () => RefreshIndicator(
                      child: _inProgressTransactionList(),
                      onRefresh: () async {
                        await controller.updateHistoryRowList();
                      },
                    ),
                  ),
                  Obx(
                    () => RefreshIndicator(
                        child: _doneTransactionList(),
                        onRefresh: () async {
                          await controller.updateHistoryRowList();
                        }),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _inProgressTransactionList() {
    if (controller.isLoading.value) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (controller.transactionHistory.isEmpty) {
      return const AppEmptyStatePlaceholder(
        medical: false,
        messages: 'There is no transaction history data',
      );
    } else {
      return SizedBox(
        child: ListView.builder(
          itemCount: controller.transactionHistory.length,
          itemBuilder: (context, index) {
            TRANSACTIONSTATUS _status =
                controller.transactionHistory[index].status;

            bool _isInProgress = (_status != TRANSACTIONSTATUS.canceled) &&
                (_status != TRANSACTIONSTATUS.done) &&
                (_status != TRANSACTIONSTATUS.paymentRejected);

            if (controller.transactionHistory.isEmpty) {
              return const AppEmptyStatePlaceholder(
                medical: false,
                messages: 'There is no transaction history data',
              );
            }

            if (_isInProgress) {
              return TransactionCardComponent(
                date: controller.transactionHistory[index].date,
                id: controller.transactionHistory[index].id,
                price: controller.transactionHistory[index].price,
                status: controller.transactionHistory[index].status,
                type: controller.transactionHistory[index].type,
                onTap: () async {
                  final _transactionId =
                      controller.transactionHistory[index].id;
                  final _status = controller.transactionHistory[index].status;

                  controller.onTransactionCardPressed(
                    transactionId: _transactionId,
                    status: _status,
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
    }
  }

  Widget _doneTransactionList() {
    if (controller.isLoading.value) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (controller.transactionHistory.isEmpty) {
      return const AppEmptyStatePlaceholder(
        medical: false,
        messages: 'There is no transaction history data',
      );
    } else {
      return SizedBox(
        child: ListView.builder(
          itemCount: controller.transactionHistory.length,
          itemBuilder: (context, index) {
            TRANSACTIONSTATUS _status =
                controller.transactionHistory[index].status;

            bool _isInProgress = (_status != TRANSACTIONSTATUS.canceled) &&
                (_status != TRANSACTIONSTATUS.done) &&
                (_status != TRANSACTIONSTATUS.paymentRejected);

            if (!_isInProgress) {
              return TransactionCardComponent(
                date: controller.transactionHistory[index].date,
                id: controller.transactionHistory[index].id,
                price: controller.transactionHistory[index].price,
                status: controller.transactionHistory[index].status,
                type: controller.transactionHistory[index].type,
                onTap: () async {
                  final _transactionId =
                      controller.transactionHistory[index].id;
                  final _status = controller.transactionHistory[index].status;
                  await controller.onTransactionCardPressed(
                    transactionId: _transactionId,
                    status: _status,
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
    }
  }
}
