import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finku/common/helper/navigation/app_navigation.dart';
import 'package:finku/core/configs/assets/app_images.dart';
import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:finku/data/database.dart';
import 'package:finku/presentation/category/pages/category.dart';
import 'package:finku/presentation/home/pages/home.dart';
import 'package:finku/presentation/transaction/pages/transaction.dart';
import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentPageIndex;
  late int currenIndexDialog;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    updateView(0, 0, DateTime.now());
    super.initState();
  }

  void updateView(int index, int indexDialog, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }

      currentPageIndex = index;
      currenIndexDialog = indexDialog;
      _children = [HomePage(selectedDate: selectedDate), const TransactionPage(),  const CategoryPage()];
    });
  }

  final AppDatabase database = AppDatabase();
  TextEditingController categoryNameController = TextEditingController();

  Future insert(String name, int type) async {
    DateTime now = DateTime.now();

    final row = await database.into(database.categories).insertReturning(CategoriesCompanion.insert(
      name: name,
      type: type,
      createdAt: now,
      updatedAt: now
    ));
    print(row);
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialogAddCategory();
      }
    );
  }

  

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
          // final CurvedNavigationBarState? navBarState = 
          //   _bottomNavigationKey.currentState;
          // navBarState?.setPage(1);
          (currentPageIndex == 0) ? AppNavigator.push(context, const TransactionPage()) : openDialog();
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

  AlertDialog _alertDialogAddCategory() {
    return AlertDialog(
        content: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Tambah Kategori', 
                  style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),
                TextFormField(
                  controller: categoryNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nama'
                  ),
                ),
                  const SizedBox(height: 10,),
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColors: const [[Colors.red], [Colors.green]],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: currenIndexDialog,
                    totalSwitches: 2,
                    icons: const [
                      Icons.upload,
                      Icons.download,
                    ],
                    
                    radiusStyle: true,
                    onToggle: (index) {
                      setState(() {
                        currenIndexDialog = index!;
                      });
                    },
                  ),
                  const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    insert(categoryNameController.text, currenIndexDialog + 1);
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    // Navigator.pop(context, true);

                    setState(() {
                      
                    });
                    categoryNameController.clear();
                  }, 
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.montserrat(color: Colors.white),
                    )
                  )
              ],
            ),
          ),
        ),
      );
  }


  CalendarAppBar _calenderAppBar() {
    return CalendarAppBar(
      accent: AppColors.primary,
      backButton: false,
      locale: 'id',
      onDateChanged: (value) {
        setState(() {
        selectedDate = value;
        updateView(0, 0, selectedDate);
        });
      },
      firstDate: DateTime.now().subtract(const Duration(days: 140)),
      lastDate: DateTime.now(),
    );
  }
}