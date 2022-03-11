import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_divider_with_title.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({Key? key}) : super(key: key);

  final String about =
      '''DirectLab also serves Swab Tests for company needs, for security and safety at work. Our professionals will come to the location specified by the client.

DirectLab is supported by professionals who routinely undergo medical tests, so you can feel safe and comfortable to undergo a Swab Test with Corporate Service services.

Make an appointment for Swab Test Corporate Service now and get test results within 24 hours for PCR Swab Test and Swab Antigen ± 30 minutes by contacting us via WhatsApp to 0877 1889 1840.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        elevation: 1,
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: primaryColor,
          ),
          color: whiteColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('profile_services'.tr, style: BoldTextStyle(blackColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: paragraphView(
                  'Service that provided by Direct Lab.',
                  color: greyColor,
                ),
              ),
              brandingImage(context),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(),
                      paragraphView(about),
                      AppDividerWithTitle.price(
                        title: 'gen_price'.tr,
                      ),
                      paragraphView('Rp 700.000/ orang (minimal 100 orang)'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget paragraphView(String text, {Color? color}) => Text(
        text,
        style: regularTextStyle(color ?? blackColor),
        textAlign: TextAlign.left,
      );

  Widget brandingImage(context) => Padding(
        padding: const EdgeInsets.only(bottom: 15, top: 20),
        child: Image.network(
          'https://cdn.discordapp.com/attachments/900022715321311256/939551258300256296/1-600x600_2.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
      );

  Widget title() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Text(
          'profile_about_corporate'.tr,
          style: BoldTextStyle(primaryColor, fontSize: 18),
          textAlign: TextAlign.left,
        ),
      );
}
