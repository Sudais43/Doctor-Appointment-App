import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/feature/settings/presentation/widgets/custom_search_bar.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/widget/CustomButton.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _MyOrderState();
}

class _MyOrderState extends State<ContactUs> {

  TextEditingController searchController = TextEditingController();
  String _currentQuery = "";

  final List<Map<String, String>> addresses = [
    {'icons': 'assets/icons/settings/customer_service_icon.svg', 'title': 'Customer Service'},
    {'icons': 'assets/icons/settings/website_icon.svg', 'title': 'Website'},
    {'icons': 'assets/icons/settings/whatsapp_icon.svg', 'title': 'WhatsApp'},
    {'icons': 'assets/icons/settings/facebook_icon.svg', 'title': 'Facebook'},
    {'icons': 'assets/icons/settings/instagram_icon.svg', 'title': 'Instagram'},
  ];

  void _handleSearch(String query){
    setState(() {
      _currentQuery = query;
    });

    print("New Search Query : $_currentQuery");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 168,
              color: LightColorPalette.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: BackButton( color: LightColorPalette.white,),
                      ),

                      // SizedBox(width: 120),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Help Center",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w600,
                              color: LightColorPalette.white,
                            ),
                          ),

                          Text(
                            "How can we help you?",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w400,
                              color: LightColorPalette.white,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 50),
                    ],
                  ),
                  SizedBox(height: 10,),

                  CustomSearchBar(controller: searchController, onSearchChanged: _handleSearch),

                ],
              ),
            ),

            SizedBox(height: 30),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    height: 41,
                    width: 155,
                    textStyle: TextStyle(
                      color: LightColorPalette.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    BackgroundColor: LightColorPalette.secondary,
                    text: "FAQ",
                    onPressed: (){}
                ),

                SizedBox(width: 30,),

                CustomButton(
                    height: 41,
                    width: 155,
                    textStyle: TextStyle(
                      color: LightColorPalette.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    BackgroundColor: LightColorPalette.primary,
                    text: "Contact Us",
                    onPressed: (){}
                ),

              ],
            ),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: SvgPicture.asset(
                            addresses[index]['icons']!,
                          ),
                          title: Text(
                            addresses[index]['title']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Transform.rotate(
                            angle: -90 * math.pi / 180,
                            child: SvgPicture.asset(
                              "assets/icons/settings/down_arrow_icon.svg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    searchController.dispose();
  }

  searchBar() {
    return Container(
      height: 33,
      width: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: LightColorPalette.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.asset("assets/icons/HomeScreen/search_icon.svg"),
          ),
        ],
      ),
    );
  }

}
