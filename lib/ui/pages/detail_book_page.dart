// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:book_apps/controllers/book_controller.dart';
import 'package:book_apps/ui/pages/image_page_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6746CC),
        title: const Text(
          "Detail Book",
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.share,
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return controller.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImagePageScreen(
                                    imageUrl: controller.detailBook!.image!),
                              ),
                            );
                          },
                          child: Image.network(
                            controller.detailBook!.image!,
                            height: 150,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.detailBook!.title!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.authors!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: index <
                                              int.parse(controller
                                                  .detailBook!.rating!)
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.subtitle!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.price!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff473DD5)),
                        onPressed: () async {
                          Uri uri = Uri.parse(controller.detailBook!.url!);
                          try {
                            (await canLaunchUrl(uri))
                                ? launchUrl(uri)
                                : debugPrint("tidak berhasil navigasi");
                          } catch (e) {
                            debugPrint("ERROR");
                          }
                        },
                        child: const Text("BUY  NOW"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                          text: expanded == false
                              ? controller.detailBook!.desc!
                                          .toString()
                                          .replaceAll('<p>', '')
                                          .replaceAll('</p>', ' ')
                                          .length <
                                      30
                                  ? controller.detailBook!.desc!
                                      .toString()
                                      .replaceAll('<p>', '')
                                      .replaceAll('</p>', ' ')
                                  : '${controller.detailBook!.desc!.toString().replaceAll('<p>', '').replaceAll('</p>', '').substring(0, 50)}...'
                              : controller.detailBook!.desc!
                                  .toString()
                                  .replaceAll('<p>', '')
                                  .replaceAll('</p>', ' '),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xff717076),
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                                text: expanded == false
                                    ? 'Read More'
                                    : 'Read Less',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      expanded = !expanded;
                                    });
                                  },
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue[700],
                                ))
                          ]),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Year",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xff717076),
                              ),
                            ),
                            Text(controller.detailBook!.year!),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Page",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xff717076),
                              ),
                            ),
                            Text(controller.detailBook!.pages!),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Publisher",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xff717076),
                              ),
                            ),
                            Text(controller.detailBook!.publisher!),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Language",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xff717076),
                              ),
                            ),
                            Text(controller.detailBook!.language!),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "ISBN",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xff717076),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(controller.detailBook!.isbn13!),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Similiar",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "More",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    controller.similiarBooks == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 180,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.similiarBooks!.books!.length,
                              itemBuilder: (context, index) {
                                final current =
                                    controller.similiarBooks!.books![index];
                                return SizedBox(
                                  width: 150,
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Image.network(
                                          current.image!,
                                          height: 100,
                                        ),
                                        Text(
                                          current.title!,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                  ],
                ),
              );
      }),
    );
  }
}
