import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<String> colors;
  final List<int> size;
  final int disCount;
  final int gender;
  final double rating, price;
  final bool isFavourite, isPopular;
  final int category;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.size,
    required this.gender,
    required this.disCount,
    required this.title,
    required this.price,
    required this.description,
    this.category = 0,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
      id: 1,
      images: [
        "assets/images/shoe1.png",
        "assets/images/shoe1.png",
        "assets/images/shoe1.png",
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Wireless Controller for PS4™",
      price: 64.99,
      description: description,
      rating: 4.8,
      isFavourite: true,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 2,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Nike Sport White - Man Pant",
      price: 50.5,
      description: description,
      rating: 4.1,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 3,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Gloves XC Omega - Polygon",
      price: 36.55,
      description: description,
      rating: 4.1,
      isFavourite: true,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 4,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Logitech Head",
      price: 20.20,
      description: description,
      rating: 4.1,
      isFavourite: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 2,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Nike Sport White - Man Pant",
      price: 50.5,
      description: description,
      rating: 4.1,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 2,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Nike Sport White - Man Pant",
      price: 50.5,
      description: description,
      rating: 4.1,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 2,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Nike Sport White - Man Pant",
      price: 50.5,
      description: description,
      rating: 4.1,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 2,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Nike Sport White - Man Pant",
      price: 50.5,
      description: description,
      rating: 4.1,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
  Product(
      id: 2,
      images: [
        "assets/images/shoe1.png",
      ],
      colors: [
        "0xFFF6625E",
        "0xFF836DB8",
        "0xFFDECB9C",
      ],
      title: "Nike Sport White - Man Pant",
      price: 50.5,
      description: description,
      rating: 4.1,
      isPopular: true,
      category: 1,
      gender: 0,
      disCount: 0,
      size: [37, 38, 39]),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
