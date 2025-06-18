import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class SubmitOrderScreen extends StatefulWidget {
  const SubmitOrderScreen({super.key});

  @override
  State<SubmitOrderScreen> createState() => _SubmitOrderScreenState();
}

class _SubmitOrderScreenState extends State<SubmitOrderScreen> {
  // Controllers for payment inputs (unused in UI here, but kept for future)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expireController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  String? latestAddress;
  Map<String, dynamic>? latestCheckout;

  @override
  void initState() {
    super.initState();
    fetchLatestAddress();
    fetchLatestCheckout().then((data) {
      setState(() {
        latestCheckout = data;
      });
    });
  }

  Future<void> fetchLatestAddress() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('addresses')
          .orderBy('addedAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first.data();
        final address = doc['address'] ?? '';
        final city = doc['city'] ?? '';
        final state = doc['state'] ?? '';
        final zip = doc['zipCode'] ?? '';
        final country = doc['country'] ?? '';

        setState(() {
          latestAddress = "$address\n$city, $state $zip, $country";
        });
      } else {
        setState(() {
          latestAddress = "No address found.";
        });
      }
    } catch (e) {
      debugPrint("Error fetching address: $e");
      setState(() {
        latestAddress = "Failed to load address.";
      });
    }
  }

  Future<Map<String, dynamic>?> fetchLatestCheckout() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('checkout')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      } else {
        debugPrint("No checkout data found.");
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching latest checkout: $e');
      return null;
    }
  }

  Future<void> _submitOrder() async {
    if (latestCheckout == null) {
      debugPrint("No checkout data available");
      return;
    }

    try {
      // Get the latest checkout document
      final checkoutDocSnapshot = await FirebaseFirestore.instance
          .collection('checkout')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (checkoutDocSnapshot.docs.isEmpty) {
        debugPrint("No checkout document found");
        return;
      }

      final doc = checkoutDocSnapshot.docs.first;
      final checkoutData = doc.data();

      // Move to pending_product collection
      final pendingRef =
          await FirebaseFirestore.instance.collection('pending_product').add({
        ...checkoutData,
        'movedAt': FieldValue.serverTimestamp(),
      });

      // Delete from checkout collection
      await doc.reference.delete();

      // Schedule movement after 1 minute
      Future.delayed(const Duration(minutes: 1), () async {
        // Randomly decide to complete or cancel
        final random = Random().nextBool();
        final targetCollection = random ? 'complete_product' : 'cancel_product';
        final statusField = random ? 'completedAt' : 'cancelledAt';

        // Get the pending product
        final pendingSnapshot = await pendingRef.get();
        if (!pendingSnapshot.exists) {
          debugPrint("Pending product not found");
          return;
        }

        final pendingData = pendingSnapshot.data();

        // Move to target collection
        await FirebaseFirestore.instance.collection(targetCollection).add({
          ...pendingData!,
          statusField: FieldValue.serverTimestamp(),
        });

        // Remove from pending
        await pendingRef.delete();

        debugPrint("Product moved to $targetCollection");
      });

      if (context.mounted) {
        context.pushNamed(AppRoute.completeorder);
      }
    } catch (e) {
      debugPrint("Error submitting order: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error submitting order: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final txtTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        iconTheme: IconThemeData(color: colorScheme.surface),
        centerTitle: true,
        title: Text(
          "Checkout",
          style: txtTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme.surface),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Address",
              style:
                  txtTheme.headlineSmall?.copyWith(color: colorScheme.surface),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: latestAddress == null
                        ? Center(
                            child: CircularProgressIndicator(
                              color: colorScheme.primary,
                            ),
                          )
                        : Text(
                            latestAddress!,
                            style: txtTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.surface),
                          ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.editaddress);
                    },
                    child: Text(
                      "Change",
                      style: txtTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment",
                  style: txtTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: colorScheme.surface),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Change",
                    style: txtTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.mastercard1,
                      cacheHeight: 40,
                      cacheWidth: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Text(
                  "***** ***** **** 3333",
                  style: txtTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold, color: colorScheme.surface),
                )
              ],
            ),
            const SizedBox(height: 30),
            Text(
              "Delivery method",
              style: txtTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: colorScheme.surface),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customContainer(AppImages.fedex, "2-3 days"),
                customContainer(AppImages.usps, "2-3 days"),
                customContainer(AppImages.dhl, "2-3 days"),
              ],
            ),
            const SizedBox(height: 30),
            customRow(
                "Order",
                latestCheckout != null
                    ? "\$${latestCheckout!['quantity'] ?? 0}"
                    : "\$--"),
            const SizedBox(height: 10),
            customRow(
                "Delivery",
                latestCheckout != null
                    ? "PKR ${latestCheckout!['deliveryFee'] ?? 0}"
                    : "PKR 200"),
            const SizedBox(height: 10),
            customRow(
                "Summary",
                latestCheckout != null
                    ? "\$${latestCheckout!['totalPrice'] ?? 0}"
                    : "300"),
            const SizedBox(height: 30),
            CustomGradientButton(
              onPressed: _submitOrder,
              buttonText: "SUBMIT ORDER",
            ),
          ],
        ),
      ),
    );
  }

  Widget customContainer(String image, String text) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final txtTheme = theme.textTheme;

    return Container(
      height: 95,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            cacheHeight: 60,
            cacheWidth: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: txtTheme.headlineSmall?.copyWith(
              color: colorScheme.surface.withOpacity(0.4),
            ),
          )
        ],
      ),
    );
  }

  Widget customRow(String text, String price) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final txtTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: txtTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.surface.withOpacity(0.3),
          ),
        ),
        Text(
          price,
          style: txtTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.surface,
          ),
        )
      ],
    );
  }
}
