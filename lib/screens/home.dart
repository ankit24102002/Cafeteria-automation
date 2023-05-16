import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'anotherpage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isTapped = false;

  final List<String> imageAssets = [
    'assets/images/imgkj.png',
    'assets/images/imgkl.png',
    'assets/images/imgkk.png',
  ];

  final List<String> titles = [
    'Image 1',
    'Image 2',
    'Image 3',
  ];

  final List<String> descriptions = [
    'Cafeteria A',
    'Cafeteria B',
    'Cafeteria C'
  ];

  void onCarouselPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  void toggleText() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.1), // Adjust the height as needed
          Container(
              height: screenHeight * 0.1, // Adjust the height as needed
              alignment: Alignment.topCenter,
              child: Text(
                descriptions[currentIndex],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Expanded(
            flex: 2,
            child: CarouselSlider.builder(
              itemCount: imageAssets.length,
              itemBuilder: (context, index, _) {
                return GestureDetector(
                  onTap: () {
                    toggleText();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              imageAssets[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned.fill(
                            child: AnimatedOpacity(
                              opacity: isTapped ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 200),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  titles[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: screenHeight * 0.6, // Adjust the height as needed
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: onCarouselPageChanged,
              ),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnotherPage(),
                    ),
                  );
                },
                child: Text('Click Here'),
              ),
            ),
          ),
          SizedBox(height: 26),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}