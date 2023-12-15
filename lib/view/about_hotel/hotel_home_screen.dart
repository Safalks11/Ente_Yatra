import 'package:flutter/material.dart';
import 'package:main_project/data/hotels_data/hotel_dummy_data.dart';
import 'package:readmore/readmore.dart';
import '../../widgets/background_container.dart';
import '../../widgets/rating_icons.dart';
import '../about_place/widgets_about.dart';

class HotelHomeScreen extends StatefulWidget {
  HotelHomeScreen({super.key});

  @override
  State<HotelHomeScreen> createState() => _HotelsListScreenState();
}

class _HotelsListScreenState extends State<HotelHomeScreen> {
  late Map<String, dynamic> hotel;

  @override
  Widget build(BuildContext context) {
    final id =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final hotel = hotels.firstWhere((hotel) => hotel['id'] == id['id']);
    return SafeArea(
      child: BackgroundContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(hotel["location"] ?? "", hotel["title"] ?? ""),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.indigo[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 190,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel["title"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(hotel["subtitle"]),
                              const SizedBox(height: 5),
                              Row(
                                children: buildRatingIcons(hotel['rating']),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 120,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(hotel["profile"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Text(
                      'About ${hotel["title"]}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: ReadMoreText(
                    hotel['description'],
                    textAlign: TextAlign.left,
                    trimMode: TrimMode.Line,
                    trimLines: 9,
                    trimCollapsedText: "Read more",
                    trimExpandedText: "Read less",
                    moreStyle: TextStyle(color: Colors.grey),
                    lessStyle: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      'Special Facilities',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigo[100]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_parking,
                                  color: Colors.blue[700],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Parking',
                                    style: TextStyle(color: Colors.blue[700]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled,
                                  color: Colors.blue[700],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    '24*7 Support',
                                    style: TextStyle(color: Colors.blue[700]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.wifi,
                                  color: Colors.blue[700],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Free WiFi',
                                    style: TextStyle(color: Colors.blue[700]),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 3,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.grey.shade400,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(hotel['image']))),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Row(
                  children: [
                    Text(
                      'Accomodation',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('Adult'), Text('02')],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('Adult'), Text('02')],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('Adult'), Text('02')],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 80)

                // Add more widgets as needed.
              ],
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      hotel["price"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      " / day",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[400])),
                        onPressed: () {},
                        child: Text(
                          "Book Now",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
