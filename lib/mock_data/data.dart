import 'package:flutter/material.dart';

import '../models/Product.dart';

List<Product> pizzas = [
  Product(
    id: 1,
    title: "Pizza margherita",
    price: 25.0,
    description: dummyText,
    image: "assets/images/pizza/pizza_margherita.png",
  ),
  Product(
    id: 2,
    title: "Pizza vegetariana",
    price: 27.0,
    description: dummyText,
    image: "assets/images/pizza/pizza_vegetariana.png",
  ),
  Product(
    id: 3,
    title: "Pizza venezia",
    price: 31.0,
    description: dummyText,
    image: "assets/images/pizza/pizza_venezia.png",
  ),
  Product(
    id: 4,
    title: "Pizza tosca",
    price: 30.0,
    description: dummyText,
    image: "assets/images/pizza/pizza_tosca.png",
  ),
];

List<Product> main_courses = [
  Product(
    id: 1,
    title: "Kotlet schabowy",
    price: 35.0,
    description: dummyText,
    image: "assets/images/courses/kotlet_schabowy.png",
  ),
  Product(
    id: 2,
    title: "Ryba z frytkami",
    price: 33.0,
    description: dummyText,
    image: "assets/images/courses/ryba_z_frytkami.jpg",
  ),
  Product(
    id: 3,
    title: "Placek po węgiersku",
    price: 25.0,
    description: dummyText,
    image: "assets/images/courses/placek_po_wegiersku.jpg",
  ),
];

List<Product> soups = [
  Product(
    id: 1,
    title: "Zupa pomidorowa",
    price: 13.5,
    description: dummyText,
    image: "assets/images/soups/pomidorowa.jpg",
  ),
  Product(
    id: 2,
    title: "Rosół",
    price: 12.0,
    description: dummyText,
    image: "assets/images/soups/rosol.jpg",
  ),
];

List<Product> drinks = [
  Product(
    id: 1,
    title: "Kawa",
    price: 7.0,
    description: dummyText,
    image: "assets/images/drinks/coffee.jpg",
  ),
  Product(
    id: 2,
    title: "Herbata",
    price: 7.0,
    description: dummyText,
    image: "assets/images/drinks/tea.jpg",
  ),
  Product(
    id: 2,
    title: "Coca-Cola",
    price: 7.0,
    description: dummyText,
    image: "assets/images/drinks/cola_glass.jpg",
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
