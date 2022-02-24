import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_divider_with_title.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/profile/controller/profile_view_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_android_button.dart';

class HelpCenterView extends GetView<ProfileViewController> {
  const HelpCenterView({Key? key}) : super(key: key);

  final String about =
      '''DirectLab also serves Swab Tests for company needs, for security and safety at work. Our professionals will come to the location specified by the client.

DirectLab is supported by professionals who routinely undergo medical tests, so you can feel safe and comfortable to undergo a Swab Test with Corporate Service services.

Make an appointment for Swab Test Corporate Service now and get test results within 24 hours for PCR Swab Test and Swab Antigen ± 30 minutes by contacting us via WhatsApp to 0877 1889 1840.''';

  final String address =
      '''Ruko Kencana Niaga D1 - 2N. Jl. Aries Utama IV No.7, RT.12/RW.8, Meruya Utara, Kec. Kembangan, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11620, Indonesia.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        elevation: 0,
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: primaryColor,
          ),
          color: whiteColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Help Center', style: BoldTextStyle(blackColor)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MapsSliverHeader(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverList(
              delegate: SliverChildListDelegate(infoBody()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomButtonComponent(offline: true),
    );
  }

  Widget paragraphView(String text, {Color? color}) => Text(
        text,
        style: regularTextStyle(color ?? blackColor),
        textAlign: TextAlign.justify,
      );

  Widget title(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Text(
          title,
          style: BoldTextStyle(primaryColor, fontSize: 18),
          textAlign: TextAlign.left,
        ),
      );

  Widget iconWithText(IconData icon, {String? text}) => SizedBox(
        child: Row(
          children: [
            Icon(icon, color: primaryColor),
            paragraphView('  :   $text')
          ],
        ),
      );

  List<Widget> infoBody() => [
        title('Addresss'),
        paragraphView(address),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconWithText(Icons.call_outlined, text: '087718891840'),
            iconWithText(Icons.email_outlined, text: 'info@directlab.id')
          ],
        ),
        title('\nOperating Hours'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            paragraphView('Monday - Sunday'),
            paragraphView('08.00 WIB - 21.00 WIB')
          ],
        ),
        const SizedBox(height: 20),
        const AppDividerWithTitle.contactUs(fontSize: 18),
        TextInput(
          controller: controller.fullNameController,
          label: "Full Name*",
          name: "fullname",
          errorMsg: '',
          isDisabled: controller.auth.isLoggedIn.value,
        ),
        TextInput(
          controller: controller.emailController,
          label: "Email*",
          name: "email",
          errorMsg: '',
          isDisabled: controller.auth.isLoggedIn.value,
        ),
        TextInput(
          controller: controller.phoneNumberController,
          label: "Phone*",
          name: "phone",
          errorMsg: '',
          isDisabled: controller.auth.isLoggedIn.value,
        ),
        TextInput(
          controller: controller.subjectController,
          label: "Subject*",
          name: "subject",
          errorMsg: '',
          isDisabled: false,
        ),
        TextInput(
          controller: controller.messageController,
          label: "Message*",
          name: "subject",
          errorMsg: '',
          isDisabled: false,
          type: 'textarea',
        ),
        const SizedBox(height: 20),
      ];

  Widget _bottomButtonComponent({bool? offline}) {
    return SizedBox(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(height: 0, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: TransactionTextButton(
                    title: "Submit",
                    isWhiteBackground: false,
                    onPressed: () async {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class MapsSliverHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      child: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.discordapp.com/attachments/900022715321311256/940632706860085378/maps_1_1.png'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  color: Colors.grey[50],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
