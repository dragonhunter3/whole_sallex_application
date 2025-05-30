import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String? selectedAddressId;

  void setSelectedAddress(String addressId) {
    setState(() {
      selectedAddressId = addressId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Shipping Address",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoute.addresspage);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('addresses')
              .orderBy('addedAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Text("No addresses found.");
            }

            final addresses = snapshot.data!.docs;

            return ListView.separated(
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final doc = addresses[index];
                final id = doc.id;
                final data = doc.data() as Map<String, dynamic>;

                final address = data['address'] ?? '';
                final city = data['city'] ?? '';
                final state = data['state'] ?? '';
                final zip = data['zipCode'] ?? '';
                final country = data['country'] ?? '';

                final fullAddress = "$address\n$city, $state $zip, $country";

                return customAddressContainer(
                  fullAddress,
                  selectedAddressId == id,
                  () {
                    context.pushNamed(AppRoute.addresspage, extra: doc);
                  },
                  () {
                    setSelectedAddress(id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget customAddressContainer(
    String addressText,
    bool isSelected,
    VoidCallback onEdit,
    VoidCallback onSelect,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isSelected ? colorScheme(context).primary : Colors.grey,
            width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  addressText,
                  style: txtTheme(context).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface),
                ),
              ),
              TextButton(
                onPressed: onEdit,
                child: Text(
                  "Edit",
                  style: txtTheme(context).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).primary),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (_) => onSelect(),
              ),
              const SizedBox(width: 10),
              Text(
                "Use as the shipping address",
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              )
            ],
          ),
        ],
      ),
    );
  }
}
