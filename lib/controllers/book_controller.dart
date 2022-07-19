import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:book_app/models/book_list_response.dart';
import 'package:http/http.dart' as http;

import '../models/book_detail_response.dart';

class BookController extends ChangeNotifier {
  ListBookResponse? bookList;
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = ListBookResponse.fromJson(jsonBookList);
      notifyListeners();
    }
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  BookDetailResponse? detailBook;
  fetchDetailBookApi(isbn) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();
      fetchSimiliarBookApi(detailBook!.title!);
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  ListBookResponse? similiarBooks;
  fetchSimiliarBookApi(String title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/${title}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBooks = ListBookResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }
}