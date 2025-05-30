import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/bottom_nav.dart';
import 'package:whole_selle_x_application/src/features/auth/forgot_screen.dart';
import 'package:whole_selle_x_application/src/features/auth/signup_screen.dart';
import 'package:whole_selle_x_application/src/features/bidding_screens/pages/aution_in_starting.dart';
import 'package:whole_selle_x_application/src/features/bidding_screens/pages/bidding_main_page.dart';
import 'package:whole_selle_x_application/src/features/bidding_screens/pages/start_bidding.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';
import 'package:whole_selle_x_application/src/features/chatScreen/chat_users.dart';
import 'package:whole_selle_x_application/src/features/checkout/pages/add_payment_method.dart';
import 'package:whole_selle_x_application/src/features/checkout/pages/address_screen.dart';
import 'package:whole_selle_x_application/src/features/checkout/pages/checkout.dart';
import 'package:whole_selle_x_application/src/features/checkout/pages/complete_order_screen.dart';
import 'package:whole_selle_x_application/src/features/checkout/pages/edit_address_screen.dart';
import 'package:whole_selle_x_application/src/features/checkout/pages/submit_order.dart';
import 'package:whole_selle_x_application/src/features/favorites/favorit_screen.dart';
import 'package:whole_selle_x_application/src/features/filters/brands.dart';
import 'package:whole_selle_x_application/src/features/filters/filter_screen.dart';
import 'package:whole_selle_x_application/src/features/items_screen/detail_screen.dart';
import 'package:whole_selle_x_application/src/features/items_screen/item_screen.dart';
import 'package:whole_selle_x_application/src/features/categories/main_catogery.dart';
import 'package:whole_selle_x_application/src/features/categories/search_items.dart';
import 'package:whole_selle_x_application/src/features/home/add_products.dart';
import 'package:whole_selle_x_application/src/features/home/home_page.dart';
import 'package:whole_selle_x_application/src/features/home/user_profile.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/introduction_one.dart';
import 'package:whole_selle_x_application/src/features/auth/login_screen.dart';
import 'package:whole_selle_x_application/src/features/notifications/notifications.dart';
import 'package:whole_selle_x_application/src/features/profile/pages/order_detail.dart';
import 'package:whole_selle_x_application/src/features/profile/pages/profile_page.dart';
import 'package:whole_selle_x_application/src/features/profile/pages/selected_order_detail.dart';
import 'package:whole_selle_x_application/src/features/rating_and_reviw/rating_screen.dart';
import 'package:whole_selle_x_application/src/router/error_route.dart';
import 'package:whole_selle_x_application/src/router/route_transition.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.introductionPageOne}',
    routes: [
      GoRoute(
        name: AppRoute.introductionPageOne,
        path: '/${AppRoute.introductionPageOne}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const IntroductionOneScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.login,
        path: '/${AppRoute.login}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.signup,
        path: '/${AppRoute.signup}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.forgot,
        path: '/${AppRoute.forgot}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ForgotScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.bottom,
        path: '/${AppRoute.bottom}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: BottomNavBar(),
        ),
      ),
      GoRoute(
        name: AppRoute.home,
        path: '/${AppRoute.home}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.products,
        path: '/${AppRoute.products}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: AddProductsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.profile,
        path: '/${AppRoute.profile}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: UserProfileScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.notificationscreen,
        path: '/${AppRoute.notificationscreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: NotificationScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.catogerypage,
        path: '/${AppRoute.catogerypage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: MainCategoryPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.itemsScreen,
        path: '/${AppRoute.itemsScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: SearchItems(),
        ),
      ),
      GoRoute(
          name: AppRoute.itempage,
          path: '/${AppRoute.itempage}',
          pageBuilder: (context, state) {
            final products = state.extra as List<ProductModel>;
            return buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: ItemScreenPage(
                products: products,
              ),
            );
          }),
      GoRoute(
        name: AppRoute.filterpage,
        path: '/${AppRoute.filterpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: FilterScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.brandpage,
        path: '/${AppRoute.brandpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: BrandsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.favorit,
        path: '/${AppRoute.favorit}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: FavoritesScreen(),
        ),
      ),
      GoRoute(
          name: AppRoute.detailpage,
          path: '/${AppRoute.detailpage}',
          pageBuilder: (context, state) {
            final String productId = state.extra as String;
            return buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: DetailScreenItems(productId: productId),
            );
          }),
      GoRoute(
        name: AppRoute.ratingpage,
        path: '/${AppRoute.ratingpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: RatingScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.checkoutpage,
        path: '/${AppRoute.checkoutpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: CheckoutScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.addpayment,
        path: '/${AppRoute.addpayment}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: AddPaymentMethod(),
        ),
      ),
      GoRoute(
        name: AppRoute.addresspage,
        path: '/${AppRoute.addresspage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: AddressScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.submitorderpage,
        path: '/${AppRoute.submitorderpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: SubmitOrderScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.editaddress,
        path: '/${AppRoute.editaddress}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: EditAddressScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.completeorder,
        path: '/${AppRoute.completeorder}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: CompleteOrderScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.profilescreen,
        path: '/${AppRoute.profilescreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ProfilePage(),
        ),
      ),
      GoRoute(
        name: AppRoute.orderDetailScreen,
        path: '/${AppRoute.orderDetailScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: OrderDetailScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.selectedorder,
        path: '/${AppRoute.selectedorder}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: SelectedOrderDetail(),
        ),
      ),
      GoRoute(
        name: AppRoute.biddingmain,
        path: '/${AppRoute.biddingmain}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: BiddingMainScreen(),
        ),
      ),
      GoRoute(
          name: AppRoute.startbid,
          path: '/${AppRoute.startbid}',
          pageBuilder: (context, state) {
            final subCategory = state.uri.queryParameters['subCategory'] ?? '';
            return buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: StartBidding(subCategory: subCategory),
            );
          }),
      GoRoute(
          name: AppRoute.aution,
          path: '/${AppRoute.aution}',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return buildPageWithFadeTransition<void>(
              context: context,
              state: state,
              child: AuctionScreen(product: extra),
            );
          }),
      GoRoute(
        name: AppRoute.chatUsers,
        path: '/${AppRoute.chatUsers}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: UsersScreen(
            currentUserEmail: 'muhammadshahidmalghani10@gmai.com',
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String introductionPageOne = 'introduction-one';
  static const String login = 'login-screen';
  static const String signup = 'signup-screen';
  static const String forgot = 'forgot-screen';
  static const String bottom = 'bottom-nav';
  static const String home = 'home-page';
  static const String products = 'add-products';
  static const String profile = 'user-profile';
  static const String notificationscreen = 'notifications';
  static const String catogerypage = 'main-catogery';
  static const String itemsScreen = 'search-items';
  static const String itempage = 'item-screen';
  static const String filterpage = 'filter-screen';
  static const String brandpage = 'brands';
  static const String favorit = 'favorit-screen';
  static const String detailpage = 'detail-screen';
  static const String ratingpage = 'rating-screen';
  static const String checkoutpage = 'checkout';
  static const String addpayment = 'add-payment-method';
  static const String addresspage = 'address-screen';
  static const String submitorderpage = 'submit-order';
  static const String editaddress = 'edit-address-screen';
  static const String completeorder = 'complete-order-screen';
  static const String profilescreen = 'profile-page';
  static const String orderDetailScreen = 'order-detail';
  static const String selectedorder = 'selected-order-detail';
  static const String biddingmain = 'bidding-main-page';
  static const String startbid = 'start-bidding';
  static const String chatUsers = 'chatscreen';
  static const String aution = 'aution-in-starting';
}
