import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        elevation: 0,
        backgroundColor: const Color(0xFF1579BE),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: whiteColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: BoldTextStyle(whiteColor),
        ),
      ),
      body: Column(
        children: [
          // Header Component
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.loose,
              children: [
                Image.asset(
                  'assets/image/app-profile-background.png',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),

                // Profile Picture Component

                Positioned(
                  // 86 is the radius of circular avatar
                  right: (MediaQuery.of(context).size.width / 2) - 86,
                  bottom: 0,
                  child: imageContainer(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget imageContainer() {
  return SizedBox(
    height: 172,
    width: 172,
    child: Stack(
      children: [
        Container(
          child: const CircleAvatar(
            radius: 86,
            backgroundImage: NetworkImage(
              'https://cdn.discordapp.com/attachments/900022715321311258/933381528157831260/259219153_1761134020752132_5367289037432796973_n.jpg',
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: whiteColor,
              width: 4.0,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {
                print("object");
              },
              icon: Icon(
                Icons.photo_camera,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
