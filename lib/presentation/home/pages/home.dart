import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finku/core/configs/assets/app_images.dart';
import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: AppColors.background,
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.primary,
        items: [
          Image.asset(AppImages.home),
          Image.asset(AppImages.chart),
          Container(child: const Text(''),),
          Image.asset(AppImages.report),
          Image.asset(AppImages.setting),
        ],
        index: currentPageIndex,
        letIndexChange: (index) => true,
        onTap: (index) {
          currentPageIndex = index;
        },
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: (){
            final CurvedNavigationBarState? navBarState = 
              _bottomNavigationKey.currentState;
            navBarState?.setPage(2);
          }, 
          backgroundColor: AppColors.secondPrimary,
          child: Image.asset(AppImages.plus),
          ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.background,
      toolbarHeight: 90,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hai Zero', 
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24
              ),
            ),
          Text(
            'Senang Bertemu Lagi!',
            style: TextStyle(
              fontSize: 30
            ),
            ),
        ],
      ),
    );
  }
}