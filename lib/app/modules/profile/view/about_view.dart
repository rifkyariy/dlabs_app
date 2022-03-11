import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_divider_with_title.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  final String about = '''
Directlab.id is a company engaged in the field of Health services. Direct Lab has a Biosafety Level 2 (BSL-2) standard laboratory and has been registered as a COVID-19 Examination Laboratory at the Ministry of Health of the Republic of Indonesia. 

As a certified Clinical Laboratory, We strive to play an active role in efforts to handle, prevent and overcome the COVID-19 pandemic, by providing facilities equipped with international standard technology and in accordance with WHO standards.''';

  final String visi =
      '''To become a trusted and affordable choice of public health services to support public health by providing fast and high-quality services and on the basis of our commitment to support the capacity and needs to deal with the pandemic.''';

  final String misi =
      '''Providing convenience for the public in obtaining Covid-19 test health services in order to create a healthier lifestyle in the future.''';

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
        title: Text('profile_about_us'.tr, style: BoldTextStyle(blackColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            children: [
              paragraphView(about),
              const SizedBox(
                height: 20,
              ),
              brandingImage(),
              AppDividerWithTitle.visi(
                title: 'gen_vision'.tr,
              ),
              paragraphView(visi),
              AppDividerWithTitle.misi(
                title: 'gen_mission'.tr,
              ),
              paragraphView(misi),
            ],
          ),
        ),
      ),
    );
  }

  Widget paragraphView(String text) => Text(
        text,
        style: regularTextStyle(blackColor),
        textAlign: TextAlign.left,
      );

  Widget brandingImage() => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image.network(
            'https://cdn.discordapp.com/attachments/900022715321311256/939547510408622090/24.png',
          ),
        ),
      );
}
