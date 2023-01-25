// ignore_for_file: unused_import

import 'package:book_apps/controllers/book_controller.dart';
import 'package:book_apps/ui/pages/detail_book_page.dart';
import 'package:book_apps/ui/pages/onboarding_screen/onbording_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6746CC),
        title: const Text("Book Catalogue"),
        centerTitle: true,
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
          child: bookController!.bookList == null
              ? child
              : ListView.builder(
                  itemCount: bookController!.bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook = bookController!.bookList!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailBookPage(
                              isbn: currentBook.isbn13!,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 150,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentBook.title!),
                                    Text(currentBook.subtitle!),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        currentBook.price!,
                                        style: TextStyle(
                                          color: Colors.green[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
