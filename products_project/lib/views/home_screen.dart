import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../widgets/grid_card_widget.dart';
import '../widgets/list_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  List<dynamic> _basketProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.200:3000/products'));
    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> _search() async {
    final searchString = _searchController.text.toLowerCase();
    final response =
        await http.get(Uri.parse('http://192.168.1.200:3000/products'));

    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body);
      final List<dynamic> filteredProducts = products.where((product) {
        final productName = product['name'].toString().toLowerCase();
        return productName.contains(searchString);
      }).toList();

      setState(() {
        _searchResults = filteredProducts;
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Card(
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: _basketProducts.length,
                      itemBuilder: (context, index) {
                        return ListCardWidget(
                          key: Key(_basketProducts[index]['id'].toString()),
                          product: _basketProducts[index],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(999),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Chercher un produit ...',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _search,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: const Text(
                            'Chercher',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Card(
                    color: Colors.transparent,
                    child: GridView.builder(
                      itemCount: _searchResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GridCardWidget(
                          key: Key(_searchResults[index]['id'].toString()),
                          onTap: () {
                            setState(() {
                              _basketProducts.add(_searchResults[index]);
                            });
                          },
                          product: _searchResults[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
