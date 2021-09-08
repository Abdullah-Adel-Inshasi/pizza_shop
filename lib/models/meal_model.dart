import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Meal {
  final String name;
  final double price;
  final String description;
  final String ingredients;
  final String imageUrl;
  final List<String> images;

  Meal({this.name,
    this.ingredients,
    this.price,
    this.description,
    this.imageUrl
    , this.images});
}

List<Meal> pizzas = [
  Meal(
      name: 'Margarita Pizza',
      description:
      'Fresh tomatoes, basil and mozzarella.',
      price: 17,
      imageUrl: 'assets/images/margarita_pizza.jpg',
      images: [
        'assets/images/pizza1.jpg',
        'assets/images/pizza2.jpg',
        'assets/images/pizza3.jpg'
      ]),
  Meal(
      name: 'Cherry-tomato Pizza',
      description: 'Cherry Tomatoes, Garlic, Basil, and Mozzarella',
      price: 16,
      imageUrl: 'assets/images/cherry_tomato_pizza.jpg',
      images: [
        'assets/images/pizza1.jpg',
        'assets/images/pizza2.jpg',
        'assets/images/pizza3.jpg'
      ]),
  Meal(
      name: 'Pepperoni Pizza',
      description: 'Pepperoni and Spicy Tomato Sauce',
      price: 20,
      imageUrl: 'assets/images/pepperoni_pizza.jpg',
      images: [
        'assets/images/pizza1.jpg',
        'assets/images/pizza2.jpg',
        'assets/images/pizza3.jpg'
      ])
];
List<Meal> burgers = [
  Meal(
      name: 'Cheese Burger',
      price: 12,
      description: 'Beef Burger with onion and tomato',
      imageUrl: 'assets/images/burger1.jpg'),
  Meal(
    name: 'Double Cheese Burger',
    imageUrl: 'assets/images/burger2.jpg',
    description: 'Beef Burger with extra onion and tomato',
    price: 14,
  ),
];

class Category {
  final String name;
  final String imageUrl;

  Category({this.name, this.imageUrl});
}

List<Category> categories = [
  Category(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
  Category(name: 'Burger', imageUrl: 'assets/images/burger.png'),
  Category(name: 'Sandwich', imageUrl: 'assets/images/sandwich.png'),
  Category(name: 'Breakfast', imageUrl: 'assets/images/breakfast.png'),
  Category(name: 'Barbecue', imageUrl: 'assets/images/barbecue.png')
];

List<String> sizes = ['S', 'M', 'L', 'XL'];

List<Meal> cart = [];
