import 'package:flutter/material.dart';

class mCategories {
  final int id;
  final String name;

  mCategories({
    required this.id,
    required this.name,
  });
}

class Gender {
  final int id;
  final String name;

  Gender({
    required this.id,
    required this.name,
  });
}

List<Gender> demoGender = [
  Gender(id: 0, name: "Male"),
  Gender(id: 1, name: "Female"),
  Gender(id: 2, name: "Kid"),
  Gender(id: 3, name: "Special"),
  Gender(id: 4, name: "Hot deal"),
];