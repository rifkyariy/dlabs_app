import 'package:get/get.dart';

class AppInternationalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ///
        /// English Translation
        ///
        'en_US': {
          ///
          /// Bottom Sheet
          ///
          'bottomsheet_book_now': 'Book Now',
          'bottomsheet_personal': 'Personal',
          'bottomsheet_organization': 'Organization',
          'bottomsheet_subtitle':
              'Please, choose who this medical test is needed for',
          'bottomsheet_personal_subtitle':
              'This option is provided for personal needs. For private and seamless service',
          'bottomsheet_organization_subtitle':
              'This option is provided for organization needs. For security and safety at work',

          ///
          /// Personal Book Test
          ///
          'p_bt_subtitle': 'Fill this form to book a test',
          'p_bt_service': 'Service',
          'p_bt_patient_subject': 'Patient Subject',
          'p_bt_myself': 'Myself',
          'p_bt_other': 'Other',

          ///
          /// General
          ///
          'gen_nationality': 'Nationality',
          'gen_identity_number': 'Identity Number',
          'gen_fullname': 'Fullname',
          'gen_email': 'Email Address',
          'gen_phone': 'Phone Number',
          'gen_gender': 'Gender',
          'gen_address': 'Address',
          'gen_test_information': 'Test Information',
          'gen_test_purpose': 'Test Purpose',
          'gen_test_date': 'Test Date',
          'gen_location': 'Location',
          'gen_location_address': 'Location Address',
          'gen_test_type': 'Test Type',
          'gen_price': 'Price',
          'gen_total_price': 'Total Price',
          'gen_patient_information': 'Patient Information',
          'gen_personal_service': 'Personal Service',
          'gen_organization_service': 'Organization Service',
          'gen_yes': 'Yes',
          'gen_no': 'No',

          ///
          /// Questionnaire
          ///
          'qst_questionnaire': 'Questionnaire',
          'qst_subtitle':
              'Fill this questionnaire to book a test for medical history',

          ///
          /// Alert Popup
          ///
          'pop_confirmation': 'Confirmation',
          'pop_form_confirm':
              'Are you sure and agree that the information you have filled on the form is original and correct data ?',
          'pop_confirm': 'Confirm',
          'pop_cancel': 'Cancel',

          ///
          /// Transaction Detail
          ///
          'tr_d_transaction_detail': 'Transaction Detail',
          'tr_d_invoice': 'Invoice',
          'tr_d_view_status': 'View Status',
          'tr_d_invoice_for': 'Invoice for',
          'tr_d_transaction_date': 'Transaction Date',
          'tr_d_view_detail': 'View Detail',
          'tr_d_choose': 'Choose',
          'tr_d_payment_detail': 'Payment Detail',
          'tr_d_payment_time': 'Payment Time',
          'tr_d_caution_messages':
              'Please make payment before the due date. Payment will be canceled automatically after 24 hours.',
          'tr_d_pay': 'Pay',

          ///
          /// Alert Popup
          ///
          'inv_invoice': 'Invoice',
          'inv_transaction_number': 'Transaction Number',
          'inv_result': 'Result',
        },

        ///
        /// Indonesian Translation
        'id_ID': {
          ///
          /// Bottom Sheet
          ///
          'bottomsheet_book_now': 'Pesan Sekarang',
          'bottomsheet_personal': 'Pribadi',
          'bottomsheet_organization': 'Kelompok',
          'bottomsheet_subtitle':
              'Silahkan, pilih untuk siapa tes medis ini diperlukan',
          'bottomsheet_personal_subtitle':
              'Pilihan ini disediakan untuk layanan pribadi/perorangan',
          'bottomsheet_organization_subtitle':
              'Pilihan ini disediakan untuk layanan kelompok',

          ///
          /// Personal Book Test
          ///
          'p_bt_subtitle': 'Lengkapi formulir di bawah ini',
          'p_bt_service': 'Layanan',
          'p_bt_patient_subject': 'Tipe Pasien',
          'p_bt_myself': 'Diri Sendiri',
          'p_bt_other': 'Orang Lain',

          ///
          /// General
          ///
          'gen_nationality': 'Kewarganegaraan',
          'gen_identity_number': 'Nomor Identitas',
          'gen_fullname': 'Nama Lengkap',
          'gen_email': 'Email',
          'gen_phone': 'Nomor Telepon',
          'gen_gender': 'Jenis Kelamin',
          'gen_address': 'Alamat',
          'gen_test_information': 'Informasi Pemeriksaan',
          'gen_test_purpose': 'Tujuan Pemeriksaan',
          'gen_test_date': 'Tanggal Pemeriksaan',
          'gen_location': 'Lokasi',
          'gen_location_address': 'Alamat Lokasi',
          'gen_test_type': 'Tipe Pemeriksaan',
          'gen_price': 'Harga',
          'gen_total_price': 'Total Harga',
          'gen_patient_information': 'Informasi Pasien',
          'gen_personal_service': 'Layanan Personal',
          'gen_organization_service': 'Layanan Organisasi',
          'gen_yes': 'Ya',
          'gen_no': 'Tidak',

          ///
          /// Questionnaire
          ///
          'qst_questionnaire': 'Kuisioner',
          'qst_subtitle':
              'Jawab pertanyaan di bawah ini dengan sebenar - benarnya',

          ///
          /// Alert Popup
          ///
          'pop_confirmation': 'Konfirmasi',
          'pop_form_confirm':
              'Apakah anda yakin dan setuju bahwa informasi yang anda isi pada formulir tersebut adalah data asli dan benar?',
          'pop_confirm': 'Konfirmasi',
          'pop_cancel': 'Batal',

          ///
          /// Transaction Detail
          ///
          'tr_d_transaction_detail': 'Rincian Transaksi',
          'tr_d_invoice': 'Tagihan',
          'tr_d_view_status': 'Lihat Status',
          'tr_d_invoice_for': 'Informasi Tagihan',
          'tr_d_transaction_date': 'Tanggal Transaksi',
          'tr_d_view_detail': 'Lihat Detail',
          'tr_d_choose': 'Pilih',
          'tr_d_payment_detail': 'Detail Pembayaran',
          'tr_d_payment_time': 'Waktu Pembayaran',
          'tr_d_caution_messages':
              'Harap melakukan pembayaran sebelum tanggal jatuh tempo. Pembayaran akan dibatalkan secara otomatis setelah 24 jam.',
          'tr_d_pay': 'Bayar',

          ///
          /// Invoice
          ///
          'inv_invoice': 'Tagihan',
          'inv_transaction_number': 'Nomor Transaksi',
          'inv_result': 'Hasil Pemeriksaan',
        }
      };
}
