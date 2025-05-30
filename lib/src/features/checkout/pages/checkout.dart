import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_textform_filed.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/cart_provider.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, dynamic>> _latestCartItems = [];
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  List<Map<String, dynamic>> _savedCards = [];
  bool _isLoadingCards = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCards();
  }

  Future<void> _loadSavedCards() async {
    Uuid uid = Uuid();
    String userid = uid.v4();
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('cards')
          .where('userId', isEqualTo: userid) // Replace with actual user ID
          .get();

      setState(() {
        _savedCards = snapshot.docs.map((doc) => doc.data()).toList();
        _isLoadingCards = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCards = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading saved cards: $e')),
        );
      }
    }
  }

  Future<void> _saveCardDetails() async {
    Uuid uid = Uuid();
    String userid = uid.v4();
    try {
      if (_cardNumberController.text.isEmpty ||
          _expiryController.text.isEmpty ||
          _cvvController.text.isEmpty ||
          _cardNameController.text.isEmpty) {
        throw Exception('Please fill all card details');
      }

      await FirebaseFirestore.instance.collection('cards').add({
        'cardNumber': _cardNumberController.text,
        'expiry': _expiryController.text,
        'cvv': _cvvController.text,
        'cardName': _cardNameController.text,
        'userId': userid, // Replace with actual user ID
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _loadSavedCards();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving card: $e')),
        );
      }
    }
  }

  Future<void> _proceedToCheckout(List<Map<String, dynamic>> cartItems) async {
    try {
      // First show the payment bottom sheet
      await _showPaymentBottomSheet(context, cartItems);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error proceeding to checkout: $e')),
        );
      }
    }
  }

  Future<void> _completeCheckout(List<Map<String, dynamic>> cartItems) async {
    Uuid uid = Uuid();
    String userid = uid.v4();
    try {
      final checkoutData = cartItems.map((item) {
        final product = item['product'] as ProductModel;
        final quantity = item['quantity'] as int;
        return {
          'product': product.toMap(),
          'quantity': quantity,
          'totalPrice': product.price * quantity,
          'selectedSize': item['selectedSize'],
          'selectedColor': item['selectedColor'],
          'paymentMethod': {
            'cardNumber': _cardNumberController.text,
            'expiry': _expiryController.text,
            'cvv': _cvvController.text,
            'cardName': _cardNameController.text,
          },
        };
      }).toList();

      // Store checkout data in 'checkout' collection with timestamp-based doc id
      await FirebaseFirestore.instance
          .collection('checkout')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({
        'items': checkoutData,
        'paymentDetails': {
          'cardNumber': _cardNumberController.text,
          'expiry': _expiryController.text,
          'cvv': _cvvController.text,
          'cardName': _cardNameController.text,
        },
        'createdAt': FieldValue.serverTimestamp(),
        'userId': userid, // Replace with actual user ID
      });

      // Clear cart after checkout
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      for (var item in cartItems) {
        final product = item['product'] as ProductModel;
        await cartProvider.removeFromCart(product.id);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error completing checkout: $e')),
        );
      }
    }
  }

  Future<void> _showPaymentBottomSheet(
      BuildContext context, List<Map<String, dynamic>> cartItems) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Payment Method',
                    style: txtTheme(context).headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface,
                        ),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoadingCards)
                    const CircularProgressIndicator()
                  else if (_savedCards.isNotEmpty)
                    Column(
                      children: [
                        Text(
                          'Saved Cards',
                          style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _savedCards.length,
                            itemBuilder: (context, index) {
                              final card = _savedCards[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _cardNumberController.text =
                                        card['cardNumber'];
                                    _expiryController.text = card['expiry'];
                                    _cardNameController.text = card['cardName'];
                                  });
                                },
                                child: Container(
                                  width: 200,
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        card['cardName'] ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '•••• •••• •••• ${card['cardNumber']?.substring(card['cardNumber'].length - 4) ?? ''}',
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Exp: ${card['expiry'] ?? ''}'),
                                      if (card['isDefault'] == true)
                                        const Text('(Default)',
                                            style:
                                                TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                      ],
                    ),

                  // New card form
                  Text(
                    'Add New Card',
                    style: txtTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15),
                  // TextField(
                  //   controller: _cardNameController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Cardholder Name',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  CustomTextFormField(
                    controller: _cardNameController,
                    keyboardType: TextInputType.name,
                    labelText: "Card name",
                  ),
                  const SizedBox(height: 15),

                  CustomTextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    labelText: "Card number",
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          labelText: "Expiry Date (MM/YY)",
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomTextFormField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          labelText: "CVV",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (val) {}),
                      Text(
                        'Save this card for future payments',
                        style: txtTheme(context)
                            .titleSmall
                            ?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await _saveCardDetails();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'SAVE CARD',
                            style: txtTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomGradientButton(
                          fontSize: 10,
                          onPressed: () async {
                            context.pushNamed(AppRoute.addresspage);
                            await _completeCheckout(cartItems);
                          },
                          buttonText: "CONFIRM PAYMENT",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text(
          "Checkout",
          style: txtTheme(context).headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: cartProvider.getCartItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final cartItems = snapshot.data ?? [];
                  _latestCartItems = cartItems;

                  if (cartItems.isEmpty) {
                    return const Center(child: Text('No items in cart.'));
                  }

                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final product = item['product'] as ProductModel;
                      final quantity = item['quantity'] as int;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My ${product.title}",
                            style: txtTheme(context).headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).surface,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorScheme(context).onPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: product.imageUrl ?? '',
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    height: 80,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  product.title,
                                                  style: txtTheme(context)
                                                      .headlineSmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            colorScheme(context)
                                                                .surface,
                                                      ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      height: 130,
                                                      width: 200,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              try {
                                                                final favoritesProvider =
                                                                    Provider.of<
                                                                            FavoritesProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                await favoritesProvider
                                                                    .toggleFavorite(
                                                                        product
                                                                            .id);
                                                                if (mounted) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          'Favorite updated'),
                                                                    ),
                                                                  );
                                                                }
                                                              } catch (e) {
                                                                if (mounted) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          'Error: $e'),
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            child: Text(
                                                              "Add to Favorite",
                                                              style: txtTheme(
                                                                      context)
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: colorScheme(
                                                                            context)
                                                                        .surface,
                                                                  ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              try {
                                                                await cartProvider
                                                                    .removeFromCart(
                                                                        product
                                                                            .id);
                                                                if (mounted) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          'Item removed from cart'),
                                                                    ),
                                                                  );
                                                                }
                                                              } catch (e) {
                                                                if (mounted) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          'Error: $e'),
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            child: Text(
                                                              "Delete From The List",
                                                              style: txtTheme(
                                                                      context)
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: colorScheme(
                                                                            context)
                                                                        .surface,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "Size: ${item['selectedSize'] ?? 'N/A'}",
                                                style: txtTheme(context)
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        color: Colors.black),
                                              ),
                                              const SizedBox(width: 40),
                                              Text(
                                                "Color: ${item['selectedColor'] ?? 'N/A'}",
                                                style: txtTheme(context)
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    cartProvider.updateQuantity(
                                                        product.id,
                                                        quantity - 1);
                                                  } else {
                                                    cartProvider.removeFromCart(
                                                        product.id);
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                quantity.toString(),
                                                style: txtTheme(context)
                                                    .headlineMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          colorScheme(context)
                                                              .surface,
                                                    ),
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider.updateQuantity(
                                                      product.id, quantity + 1);
                                                },
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 50),
                                              Text(
                                                "PKR ${product.price * quantity}",
                                                style: txtTheme(context)
                                                    .headlineSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          colorScheme(context)
                                                              .surface,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            CustomGradientButton(
              onPressed: _latestCartItems.isNotEmpty
                  ? () => _proceedToCheckout(_latestCartItems)
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cart is empty')),
                      );
                    },
              buttonText: "CHECK OUT",
            ),
          ],
        ),
      ),
    );
  }
}
