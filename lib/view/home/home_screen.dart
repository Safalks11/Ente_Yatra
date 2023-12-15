import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_project/widgets/_drawer.dart';
import 'package:main_project/widgets/app_bar.dart';
import '../../data/dummy_data/dummy_data.dart';
import '../../widgets/background_container.dart';
import '../../widgets/bottomnavbar.dart';
import '../favourite_screen/favourite_screen.dart';
import '../hotels_list/hotels_list_screen.dart';
import '../search_screen/search_screen.dart';
import 'lists_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(),
          drawer: CustomDrawer(),
          body: _getBody(),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return SearchScreen();
      case 2:
        return HotelsListScreen();
      case 3:
        return FavouriteScreen();
      default:
        return Container();
    }
  }

  Widget _buildHomeContent() {
    details.sort((a, b) => b['rating'].compareTo(a['rating']));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExploreSection(),
        const SizedBox(height: 20),
        _buildSearchDestinationContainer(),
        const SizedBox(height: 25),
        _buildCategorySection(),
        const SizedBox(height: 25),
        _buildPopularSection(),
        const SizedBox(height: 10),
        _buildPopularGrid(),
      ],
    );
  }

  Widget _buildExploreSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        "Explore",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
    );
  }

  Widget _buildSearchDestinationContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = 2;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.07,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.blueGrey[100],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Search Destination",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: IconButton.filled(
                    highlightColor: Colors.black38,
                    iconSize: 32,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amber[600]),
                    ),
                    icon: const Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HomeData.catColors[index],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  HomeData.category[index],
                ),
              ),
              width: 70,
              height: 65,
            ),
            const SizedBox(height: 10),
            Text(HomeData.catName[index]),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularSection() {
    return Row(
      children: [
        SizedBox(width: 25),
        Text(
          "Popular",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ],
    );
  }

  Widget _buildPopularGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 5,
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 180,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.toNamed(
                'details',
                arguments: {
                  'id': details[index]['id'],
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
                        image: AssetImage(details[index]['profile']),
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
                      child: Center(child: Text(details[index]['title'])),
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
}
