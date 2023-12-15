import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_project/data/hotels_data/hotel_dummy_data.dart';

class HotelsListScreen extends StatefulWidget {
  HotelsListScreen({super.key});

  @override
  State<HotelsListScreen> createState() => _HotelsListScreenState();
}

class _HotelsListScreenState extends State<HotelsListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Hotels",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: SearchBar(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue[50]),
                    controller: _searchController,
                    onChanged: (query) {
                      _performSearch(query);
                    },
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(left: 10)),
                    hintText: "Search Hotels",
                    hintStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14)),
                    trailing: [
                      IconButton.filled(
                        highlightColor: Colors.black38,
                        iconSize: 22,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber[600]),
                        ),
                        onPressed: () {
                          _performSearch(_searchController.text);
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                      ),
                      // const SizedBox(width: 3.5),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // _buildSearchResults(),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: _searchResults.isNotEmpty
                  ? _searchResults.length
                  : hotels.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.toNamed(
                    'hotels',
                    arguments: {
                      'id': _searchResults.isNotEmpty
                          ? _searchResults[index]['id']
                          : hotels[index]['id'],
                    },
                  );
                },
                child: SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    _searchResults.isNotEmpty
                                        ? _searchResults[index]['profile']
                                        : hotels[index]['profile'],
                                  ),
                                  fit: BoxFit.cover)),
                          height: double.infinity,
                          width: 150,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 58.0),
                                  child: Text(
                                    _searchResults.isNotEmpty
                                        ? _searchResults[index]['title']
                                        : hotels[index]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(hotels[index]['subtitle']),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16),
                                Text(_searchResults.isNotEmpty
                                    ? _searchResults[index]['location']
                                    : hotels[index]["location"])
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      hotels[index]["rating"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.star,
                                        size: 15, color: Colors.amber)
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.red[200],
                                    child: Text(hotels[index]["price"]))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return _searchResults.isNotEmpty
        ? Column(
            children: _searchResults
                .map((result) => ListTile(
                      title: Text(result['title']),
                      onTap: () {
                        // Navigate to the details screen or perform desired action
                        Get.toNamed(
                          'hotels',
                          arguments: {
                            'id': result['id'],
                          },
                        );
                      },
                    ))
                .toList(),
          )
        : SizedBox.shrink();
  }

  void _performSearch(String query) {
    // Implement your search logic here
    // For example, filter details based on the query
    setState(() {
      if (query.isEmpty) {
        _searchResults.clear(); // Clear the suggestions if the query is empty
      } else {
        _searchResults = hotels
            .where((hotel) =>
                hotel['location'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
