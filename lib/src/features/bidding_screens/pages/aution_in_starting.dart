import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AuctionScreen extends StatefulWidget {
  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  ];

  final List<Map<String, dynamic>> bids = [
    {'name': 'Ronald Richards', 'time': '20s', 'amount': '\$24.5K'},
    {'name': 'Cameron Williamson', 'time': '1m', 'amount': '\$20K'},
    {'name': 'Guy Hawkins', 'time': '5m', 'amount': '\$15K'},
    {'name': 'Darrell Steward', 'time': '7m', 'amount': '\$12.5K'},
    {'name': 'Wade Warren', 'time': '10m', 'amount': '\$10K'},
  ];

  int _currentIndex = 0;

  final List<String> bidAmounts = [
    '\$28K',
    '\$32K',
    '\$35K',
    '\$38K',
    '\$40K',
    '\$42K',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Image Carousel
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: imageUrls.map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageUrls.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                // Black Section
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[800],
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LOVE OF SOUL Z500',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Milinda Peterson',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Horizontal divider
                      Container(
                        height: 1,
                        color: Colors.grey[800],
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STARTING PRICE',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$5,000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'CURRENT BID PRICE',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$24,500',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              3,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.grey[700],
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'are live',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '0:1:23 remaining',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Scrollable List of Bids
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.grey[600]),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bids[index]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        bids[index]['amount'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    bids[index]['time'],
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }, childCount: bids.length),
          ),
          // Fixed Section at the Bottom
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Spacer(),
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'LIVE AUCTION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '14 Bids made',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bidAmounts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                                child: Text(
                                  bidAmounts[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          showMyDialogBox();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'PLACE BID for \$25K',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showMyDialogBox() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12),
                Icon(Icons.task_alt, color: Colors.green, size: 50),
                SizedBox(height: 6),
                Text(
                  'Confirm Bid',
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  'You have placed a bid for \$25,000.\nShould we place this as our Bid?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Yes, Place My Bid',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        // 👈 Yeh line border add karti hai
                        color: Colors
                            .black, // 🔁 Aap border ka color yahan change kar sakte hain
                        width: 1, // Border ki motai (thickness)
                      ),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
