// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class OnbordingModel {
  String img;
  String title;
  String desc;

  OnbordingModel({
    required this.img,
    required this.title,
    required this.desc,
  });
}

List<OnbordingModel> contents = [
  OnbordingModel(
    img: 'assets/images/img1.png',
    title: "Find books lover community",
    desc: "Sharing about your book with others bookly lovers",
  ),
  OnbordingModel(
    img: 'assets/images/img2.png',
    title: "A place to buy your favourite E-Book",
    desc: "The best place to buy e-books for you to read and collect",
  ),
  OnbordingModel(
    img: 'assets/images/img3.png',
    title: "Be close with your books",
    desc: "Schedulling and tracking your reading life and rutinity",
  ),
];
