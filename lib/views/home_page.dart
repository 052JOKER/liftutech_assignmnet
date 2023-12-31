import 'package:flutter/material.dart';
import 'package:liftutech_assignmnet/controller/networks.dart';
import 'package:liftutech_assignmnet/views/customProductCard.dart';
import 'package:liftutech_assignmnet/views/productDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List jsonCategoriesListList = [];
  List jsonProductsListList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    List? categoriesData = await Networks().getCategoriesListData();
    List? productData = await Networks().getProductsListData();
    setState(() {
      if (categoriesData != null && productData != null) {
        jsonCategoriesListList = categoriesData;
        jsonProductsListList = productData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (const Text("Shopping App")),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SafeArea(
        child: jsonCategoriesListList.isEmpty && jsonProductsListList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: jsonCategoriesListList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, right: 4.0),
                              child: Container(
                                height: 100,
                                width: 180,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          jsonCategoriesListList[index]["image"]
                                              .toString(),
                                        ),
                                        radius: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        jsonCategoriesListList[index]["name"],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Text(
                        'Products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.6),
                        itemCount: jsonProductsListList.length,
                        itemBuilder: (context, productIndex) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                      selectedProductList:
                                          jsonProductsListList[productIndex]),
                                ),
                              );
                            },
                            child: CustomProductCard(
                              productImageURL:
                                  jsonProductsListList[productIndex]['images']
                                      [0],
                              productDescription:
                                  jsonProductsListList[productIndex]
                                      ['description'],
                              productPrice: jsonProductsListList[productIndex]
                                  ['price'],
                              productName: jsonProductsListList[productIndex]
                                  ['title'],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
