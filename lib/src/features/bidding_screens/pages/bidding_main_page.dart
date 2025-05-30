import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class BiddingMainScreen extends StatelessWidget {
  const BiddingMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Auctions",
          style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: const Color.fromARGB(255, 228, 227, 225),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('bidding_products')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No auction products found"));
            }

            final products = snapshot.data!.docs;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final data = products[index].data() as Map<String, dynamic>;
                final subCategoryName = data['subCategory'] ?? 'Unnamed';
                final imageUrl = data['imageUrl'] ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () => context.pushNamed(AppRoute.startbid),
                    child: Container(
                      height: h * 0.14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          if (imageUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image, size: 80),
                              ),
                            )
                          else
                            Icon(Icons.image, size: 80, color: Colors.grey),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              subCategoryName,
                              style: txtTheme(context).headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme(context).surface,
                                  ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
