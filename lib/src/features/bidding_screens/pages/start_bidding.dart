import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class StartBidding extends StatelessWidget {
  final String subCategory;
  const StartBidding({super.key, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme(context).onPrimary),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text(
          'Products in "$subCategory"',
          style: txtTheme(context)
              .displayMedium
              ?.copyWith(color: colorScheme(context).primary),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('subCategory', isEqualTo: subCategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              final name = product['title'] ?? 'Unnamed';
              final image = product['imageUrl'] ?? '';
              final discription = product['description'] ?? '';
              final minmunprice = product['minPrice'] ?? '';
              final maximumprice = product['maxPrice'] ?? '';
              final startingTime = product['biddingStartTime'] ?? '';
              final enddingTime = product['biddingEndTime'] ?? '';
              final id = product['id'] ?? '';

              return Card(
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    context.pushNamed(
                      AppRoute.aution,
                      extra: {
                        'title': name,
                        'description': discription,
                        'imageUrl': image,
                        'minPrice': minmunprice,
                        'maxPrice': maximumprice,
                        'biddingStartTime': startingTime,
                        'biddingEndTime': enddingTime,
                        'id': id
                      },
                    );
                  },
                  leading: image.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(strokeWidth: 2),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image),
                        )
                      : const Icon(Icons.image),
                  title: Text(name,
                      style: txtTheme(context).titleLarge?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  subtitle: Text(discription,
                      style: txtTheme(context)
                          .titleSmall
                          ?.copyWith(color: Colors.black)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
