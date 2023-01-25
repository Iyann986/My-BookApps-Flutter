// ignore_for_file: unused_import, avoid_print, avoid_unnecessary_containers, non_constant_identifier_names, unnecessary_const, avoid_types_as_parameter_names

import 'package:book_apps/ui/models/onboarding_model.dart';
import 'package:book_apps/ui/pages/book_list_page.dart';
import 'package:book_apps/ui/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({Key? key}) : super(key: key);

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 1 == 0 ? kwhite : kblue,
      appBar: AppBar(
        backgroundColor: currentIndex % 1 == 0 ? kwhite : kblue,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BookListPage(),
                ),
              );
            },
            child: Text(
              "Skip",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: currentIndex % 1 == 0 ? kgrey : kwhite,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].img,
                        height: 250,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff6746CC)),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        contents[i].desc,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff717076),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.all(45),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(
                      color: const Color(0xff473DD5),
                    ),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff473DD5)),
              ),
              child: Text(
                  currentIndex == contents.length - 1 ? "Get Started" : "Next"),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BookListPage(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext) {
    return Container(
      height: 10,
      width: currentIndex == index ? 40 : 13,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index ? kblue : kgrey,
      ),
    );
  }
}
