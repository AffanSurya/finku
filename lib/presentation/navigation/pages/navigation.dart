import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finku/core/configs/assets/app_images.dart';
import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:finku/presentation/category/pages/category.dart';
import 'package:finku/presentation/home/pages/home.dart';
import 'package:finku/presentation/transaction/pages/transaction.dart';
import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> _children = [const HomePage(), const TransactionPage(), const CategoryPage()];

  int currentPageIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _bottomNavigation(),
      body: _children[currentPageIndex],
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    switch (currentPageIndex) {
      case 0:
        return _calenderAppBar();
      case 1:
        return AppBar(
          title: const Text('Transaksi'),
        );
      case 2:
        return AppBar(
          title: const Text('Kategori'),
        );
      default:
        return AppBar(
          title: const Text('Default'),
        );
    }
  }

  SizedBox _floatingActionButton() {
    return SizedBox(
      height: 70,
      width: 70,

      child: FloatingActionButton(
        onPressed: (){
          final CurvedNavigationBarState? navBarState = 
            _bottomNavigationKey.currentState;
          navBarState?.setPage(1);
        }, 
        backgroundColor: AppColors.secondPrimary,
        shape: const CircleBorder(),
        child: Image.asset(AppImages.plus, height: 40),
        ),
    );
  }

  CurvedNavigationBar _bottomNavigation() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: AppColors.background,
      color: AppColors.primary,
      buttonBackgroundColor: AppColors.primary,
      items: [
        Image.asset(AppImages.home, height: 30,),
        // Image.asset(AppImages.chart, height: 30),
        Container(child: const Text(''),),
        Image.asset(AppImages.report, height: 30),
        // Image.asset(AppImages.setting, height: 30),
      ],
      index: currentPageIndex,
      letIndexChange: (index) => true,
      onTap: (index) {
        setState(() {
        currentPageIndex = index;
        });
      },
    );
  }

  CalendarAppBar _calenderAppBar() {
    return CalendarAppBar(
      accent: AppColors.primary,
      backButton: false,
      locale: 'id',
      onDateChanged: (value) => print(value),
      firstDate: DateTime.now().subtract(const Duration(days: 140)),
      lastDate: DateTime.now(),
    );
  }
}