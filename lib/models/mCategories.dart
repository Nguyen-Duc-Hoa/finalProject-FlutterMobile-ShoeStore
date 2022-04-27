import 'package:flutter/material.dart';

class mCategories {
  final int id;
  final String name;

  mCategories({
    required this.id,
    required this.name,
  });
}

List<mCategories> demoType = [
  mCategories(id: 4, name: "Male"),
  mCategories(id: 5, name: "Female"),
  mCategories(id: 6, name: "Kid"),
  mCategories(id: 7, name: "Special"),
  mCategories(id: 8, name: "Hot deal"),

];