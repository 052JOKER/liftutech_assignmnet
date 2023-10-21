import 'dart:convert';

import 'package:dio/dio.dart';

class Networks {
  Dio dio = Dio();
  List categoriesList = [];
  List productsList = [];

  Future getCategoriesListData() async {
    try {
      var response =
          await dio.get('https://api.escuelajs.co/api/v1/categories');
      if (response.statusCode == 200) {
        categoriesList = response.data as List;
        print(categoriesList.length);
        return categoriesList;
      } else {
        print("error");
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future getProductsListData() async {
    try {
      var productsResponse =
          await dio.get('https://api.escuelajs.co/api/v1/products');
      if (productsResponse.statusCode == 200) {
        productsList = productsResponse.data as List;
        print(productsList.length);
        return productsList;
      } else {
        print("error");
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
