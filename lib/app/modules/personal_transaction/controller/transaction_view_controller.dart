import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:dlabs_apps/app/data/models/patient_model.dart';
import 'package:dlabs_apps/app/data/models/transaction.dart';
import 'package:get/get.dart';

class TransactionViewController extends GetxController {
  RxList<Transaction> transactions = [
    // Transaction
    Transaction(
      id: 'IND20210915',
      type: 'Swab Antigen',
      date: '14 October 2021',
      price: 590000,
      status: TRANSACTIONSTATUS.done,
      patient: PatientModel(
        address:
            'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
        dateOfBirth: '26-05-2001',
        email: 'paytren@mail.com',
        fullName: 'Romy Roma',
        gender: 'Male',
        identityNumber: '3401918272728',
        phoneNumber: '+6289789567898',
        testPrice: 800000,
        testType: 'Swab Antigen',
      ),
    ),
    // Transaction
    Transaction(
      id: 'IND20210915',
      type: 'Swab Antigen',
      date: '14 October 2021',
      price: 590000,
      status: TRANSACTIONSTATUS.canceled,
      patient: PatientModel(
        address:
            'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
        dateOfBirth: '26-05-2001',
        email: 'paytren@mail.com',
        fullName: 'Romy Roma',
        gender: 'Male',
        identityNumber: '3401918272728',
        phoneNumber: '+6289789567898',
        testPrice: 800000,
        testType: 'Swab Antigen',
      ),
    ),
    Transaction(
      id: 'IND20210915',
      type: 'Swab Antigen',
      date: '14 October 2021',
      price: 590000,
      status: TRANSACTIONSTATUS.readyToLab,
      patient: PatientModel(
        address:
            'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
        dateOfBirth: '26-05-2001',
        email: 'paytren@mail.com',
        fullName: 'Romy Roma',
        gender: 'Male',
        identityNumber: '3401918272728',
        phoneNumber: '+6289789567898',
        testPrice: 800000,
        testType: 'Swab Antigen',
      ),
    ),
    Transaction(
      id: 'IND20210915',
      type: 'Swab Antigen',
      date: '14 October 2021',
      price: 590000,
      status: TRANSACTIONSTATUS.inProgress,
      patient: PatientModel(
        address:
            'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
        dateOfBirth: '26-05-2001',
        email: 'paytren@mail.com',
        fullName: 'Romy Roma',
        gender: 'Male',
        identityNumber: '3401918272728',
        phoneNumber: '+6289789567898',
        testPrice: 800000,
        testType: 'Swab Antigen',
      ),
    ),
    Transaction(
      id: 'IND20210915',
      type: 'Swab Antigen',
      date: '14 October 2021',
      price: 590000,
      status: TRANSACTIONSTATUS.canceled,
      patient: PatientModel(
        address:
            'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
        dateOfBirth: '26-05-2001',
        email: 'paytren@mail.com',
        fullName: 'Romy Roma',
        gender: 'Male',
        identityNumber: '3401918272728',
        phoneNumber: '+6289789567898',
        testPrice: 800000,
        testType: 'Swab Antigen',
      ),
    ),
    Transaction(
      id: 'IND20210915',
      type: 'Swab Antigen',
      date: '14 October 2021',
      price: 590000,
      status: TRANSACTIONSTATUS.done,
      patient: PatientModel(
        address:
            'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
        dateOfBirth: '26-05-2001',
        email: 'paytren@mail.com',
        fullName: 'Romy Roma',
        gender: 'Male',
        identityNumber: '3401918272728',
        phoneNumber: '+6289789567898',
        testPrice: 800000,
        testType: 'Swab Antigen',
      ),
    )
  ].obs;
}
