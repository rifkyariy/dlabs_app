import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
        title: Text('profile_help_center'.tr, style: BoldTextStyle(blackColor)),
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
        title('gen_address'.tr),
        paragraphView(address),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconWithText(Icons.call_outlined, text: '087718891840'),
            iconWithText(Icons.email_outlined, text: 'info@directlab.id')
          ],
        ),
        title("\n ${'gen_operating_hours'.tr}"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            paragraphView("${'gen_monday'.tr} - ${'gen_sunday'.tr}"),
            paragraphView('08.00 WIB - 21.00 WIB')
          ],
        ),
        const SizedBox(height: 20),
        AppDividerWithTitle.contactUs(
            title: 'profile_about_us'.tr, fontSize: 18),
        TextInput(
          controller: controller.fullNameController,
          label: "gen_fullname".tr,
          name: "fullname",
          errorMsg: '',
          isDisabled: controller.auth.isLoggedIn.value,
        ),
        TextInput(
          controller: controller.emailController,
          label: "gen_email".tr,
          name: "email",
          errorMsg: '',
          isDisabled: controller.auth.isLoggedIn.value,
        ),
        TextInput(
          controller: controller.phoneNumberController,
          label: "gen_phone".tr,
          name: "phone",
          errorMsg: '',
          isDisabled: controller.auth.isLoggedIn.value,
        ),
        TextInput(
          controller: controller.subjectController,
          label: "gen_subject".tr,
          name: "subject",
          errorMsg: '',
          isDisabled: false,
        ),
        TextInput(
          controller: controller.messageController,
          label: "gen_message".tr,
          name: "message",
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
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    final marker = const Marker(
      markerId: MarkerId('Direct Lab'),
      position: LatLng(-6.191842, 106.746557),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'Direct Lab',
        snippet:
            'Ruko Kencana Niaga D1 2N, Jl. Aries Utama IV No.7, RT.12/RW.8, Meruya Utara, Daerah Khusus Ibukota Jakarta 11620, Indonesia',
      ),
    );

    markers[MarkerId('Direct Lab')] = marker;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      child: SizedBox.expand(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(-6.191842, 106.746557),
            zoom: 18.0,
          ),
          markers: markers.values.toSet(),
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
    return false;
  }
}
