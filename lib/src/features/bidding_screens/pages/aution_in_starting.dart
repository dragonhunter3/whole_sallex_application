import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuctionScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const AuctionScreen({super.key, required this.product});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double? _currentBid;
  late double _minBid;
  late DateTime _endTime;
  late String _productId;
  final List<String> _imageUrls = [];
  int _currentIndex = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bidController = TextEditingController();
  List<Map<String, dynamic>> _bidHistory = [];
  int _bidderCount = 0;

  @override
  void initState() {
    super.initState();
    _minBid = (widget.product['minPrice'] ?? 0).toDouble();

    if (widget.product['biddingEndTime'] is Timestamp) {
      _endTime = (widget.product['biddingEndTime'] as Timestamp).toDate();
    } else if (widget.product['biddingEndTime'] is String) {
      _endTime = DateTime.parse(widget.product['biddingEndTime']);
    } else {
      _endTime = DateTime.now().add(const Duration(days: 1));
    }

    _productId = widget.product['id'] ?? '';
    _initializeData();

    // Initialize images
    if (widget.product['imageUrl'] != null) {
      _imageUrls.add(widget.product['imageUrl']);
    }
    if (widget.product['additionalImages'] != null) {
      _imageUrls
          .addAll(List<String>.from(widget.product['additionalImages'] ?? []));
    }
    if (_imageUrls.isEmpty) {
      _imageUrls.add('https://via.placeholder.com/400');
    }
  }

  Future<void> _initializeData() async {
    await _initializeCurrentBid();
    await _loadBidHistory();
    await _countBidders();
  }

  Future<void> _initializeCurrentBid() async {
    try {
      final allBids = await _firestore
          .collection('bids')
          .where('productId', isEqualTo: _productId)
          .orderBy('amount', descending: true)
          .limit(1)
          .get();

      double highestAmount = _minBid;
      if (allBids.docs.isNotEmpty) {
        highestAmount = allBids.docs.first['amount']?.toDouble() ?? _minBid;
      }

      setState(() {
        _currentBid = highestAmount;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching current bid: $e')),
      );
      setState(() {
        _currentBid = _minBid; // Fallback to minBid on error
      });
    }
  }

  Future<void> _loadBidHistory() async {
    try {
      final allBids = await _firestore
          .collection('bids')
          .where('productId', isEqualTo: _productId)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      setState(() {
        _bidHistory = allBids.docs.map((doc) {
          final data = doc.data();
          return {
            'userName': data['userName'] ?? 'Anonymous',
            'amount': data['amount']?.toDouble() ?? 0.0,
            'time': DateFormat('HH:mm').format(data['timestamp'].toDate()),
          };
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading bid history: $e')),
      );
      setState(() {
        _bidHistory = []; // Clear bid history on error
      });
    }
  }

  Future<void> _countBidders() async {
    final bidders = await _firestore
        .collection('bids')
        .where('productId', isEqualTo: _productId)
        .get();

    final uniqueBidders = <String>{};
    for (var doc in bidders.docs) {
      uniqueBidders.add(doc['userName']);
    }

    setState(() {
      _bidderCount = uniqueBidders.length;
    });
  }

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
                _buildImageCarousel(),
                _buildProductDetails(),
              ],
            ),
          ),
          _buildBidsHistory(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                _buildBiddingControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
            items: _imageUrls
                .map((url) => Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _imageUrls
                .asMap()
                .entries
                .map((entry) => Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == entry.key
                            ? Colors.white
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[800],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['title'] ?? 'No Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Seller: ${widget.product['sellerName'] ?? 'Unknown'}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            color: Colors.grey[800],
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'STARTING PRICE',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${_minBid.toStringAsFixed(2)}',
                    style: const TextStyle(
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
                  const Text(
                    'CURRENT BID PRICE',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('bids')
                        .where('productId', isEqualTo: _productId)
                        .orderBy('amount', descending: true)
                        .limit(1)
                        .snapshots(),
                    builder: (context, snapshot) {
                      double currentHighest = _minBid;
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        currentHighest =
                            snapshot.data!.docs.first['amount']?.toDouble() ??
                                _minBid;
                      }
                      return Text(
                        '\$${currentHighest.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Bidders: $_bidderCount',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: StreamBuilder<int>(
                  stream: Stream.periodic(
                    const Duration(seconds: 1),
                    (count) => count,
                  ),
                  builder: (context, snapshot) {
                    final remaining = _endTime.difference(DateTime.now());
                    return Text(
                      '${remaining.inHours}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')} remaining',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBidsHistory() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final bid = _bidHistory[index];
          return ListTile(
            leading: const Icon(Icons.gavel, color: Colors.grey),
            title: Text(
              bid['userName'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('\$${bid['amount']} at ${bid['time']}'),
          );
        },
        childCount: _bidHistory.length,
      ),
    );
  }

  Widget _buildBiddingControls() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _placeQuickBid(),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'LIVE AUCTION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('bids')
                    .where('productId', isEqualTo: _productId)
                    .snapshots(),
                builder: (context, snapshot) {
                  int bidCount =
                      snapshot.hasData ? snapshot.data!.docs.length : 0;
                  return Text(
                    '$bidCount Bids made',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildQuickBidButton(_currentBid! + 100),
                _buildQuickBidButton(_currentBid! + 200),
                _buildQuickBidButton(_currentBid! + 500),
                _buildQuickBidButton(_currentBid! + 1000),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _showBidDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'PLACE BID for \$${(_currentBid! + 100).toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickBidButton(double amount) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () =>
            _placeBid(amount, 'Anonymous'), // Fixed: Added userName
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showBidDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const Icon(Icons.gavel, color: Colors.amber, size: 50),
              const SizedBox(height: 6),
              const Text(
                'Place Your Bid',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _bidController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Bid Amount',
                  prefixText: '\$',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final bidAmount = double.tryParse(_bidController.text) ?? 0;
                  final userName = _nameController.text.isNotEmpty
                      ? _nameController.text
                      : 'Anonymous';
                  if (bidAmount > _currentBid!) {
                    _placeBid(bidAmount, userName);
                    Navigator.pop(context);
                    _nameController.clear();
                    _bidController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bid must be higher than \$$_currentBid'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Confirm Bid',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _nameController.clear();
                  _bidController.clear();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _placeQuickBid() async {
    final amount = _currentBid! + 100;
    const userName = 'Anonymous';
    await _placeBid(amount, userName);
  }

  Future<void> _placeBid(double amount, String userName) async {
    try {
      final highestBid = await _firestore
          .collection('bids')
          .where('productId', isEqualTo: _productId)
          .orderBy('amount', descending: true)
          .limit(1)
          .get();
      double currentHighest = _minBid;
      if (highestBid.docs.isNotEmpty) {
        currentHighest = highestBid.docs.first['amount']?.toDouble() ?? _minBid;
      }

      if (amount <= currentHighest) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bid must be higher than \$$currentHighest'),
          ),
        );
        return;
      }

      // Add bid to bids collection
      await _firestore.collection('bids').add({
        'productId': _productId,
        'userName': userName,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update local state
      setState(() {
        _currentBid = amount;
      });

      // Refresh data
      await _initializeData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bid of \$$amount placed successfully by $userName!'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing bid: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bidController.dispose();
    super.dispose();
  }
}
