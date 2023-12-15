import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/dummy_data/dummy_data.dart';
import '../home/lists_home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SearchBar(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey[50]),
              controller: _searchController,
              onChanged: (query) {
                _performSearch(query);
              },
              padding:
                  MaterialStateProperty.all(const EdgeInsets.only(left: 10)),
              hintText: "Search Destination",
              hintStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 20)),
              trailing: [
                IconButton.filled(
                  highlightColor: Colors.black38,
                  iconSize: 32,
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
                const SizedBox(width: 3.5),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSearchResults(),
                  SizedBox(height: 20),
                  _buildSectionTitle("Popular"),
                  SizedBox(height: 10),
                  _buildTopRatedHotels(),
                  SizedBox(height: 5),
                  _buildSectionTitle("All"),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 12,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: details.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 180,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            'details',
                            arguments: {
                              'id': details[index]['id'],
                              'color': HomeData.gridItemColors[
                                  index % HomeData.gridItemColors.length],
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      details[index]['profile'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HomeData.gridItemColors[
                                        index % HomeData.gridItemColors.length],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  height: 35,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      details[index]['title'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                        Get.toNamed(
                          'details',
                          arguments: {
                            'id': result['id'],
                            'color': HomeData.gridItemColors[
                                result['id'] % HomeData.gridItemColors.length],
                          },
                        );
                      },
                    ))
                .toList(),
          )
        : SizedBox.shrink();
  }

  Widget _buildTopRatedHotels() {
    List<Map<String, dynamic>> topRatedHotels = _getTopRatedHotels();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
      child: SizedBox(
        height: 365,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: topRatedHotels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 180,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.toNamed(
                'details',
                arguments: {
                  'id': topRatedHotels[index]['id'],
                  'color': HomeData
                      .gridItemColors[index % HomeData.gridItemColors.length],
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(topRatedHotels[index]['profile']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: HomeData.gridItemColors[
                            index % HomeData.gridItemColors.length],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      height: 35,
                      width: double.infinity,
                      child: Center(
                        child: Text(topRatedHotels[index]['title']),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        SizedBox(width: 25),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ],
    );
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults.clear();
      } else {
        _searchResults = details
            .where((detail) =>
                detail['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  List<Map<String, dynamic>> _getTopRatedHotels() {
    details.sort((a, b) => b['rating'].compareTo(a['rating']));
    return details.take(3).toList();
  }
}
