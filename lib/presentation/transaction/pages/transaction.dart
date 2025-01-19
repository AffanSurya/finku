import 'package:finku/core/configs/assets/app_images.dart';
import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int currentToggle = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _toggleIncomeOutcome(),
              _listCategory(),
              
            ],
          ) 
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  SizedBox _floatingActionButton() {
    return SizedBox(
      height: 70,
      width: 70,

      child: FloatingActionButton(
        onPressed: (){
          
        }, 
        backgroundColor: AppColors.secondPrimary,
        shape: const CircleBorder(),
        child: Image.asset(AppImages.plus, height: 40),

        ),
    );
  }

  Padding _listCategory() {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 10,
              child: ListTile(
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min ,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 10,),
                    Icon(Icons.edit)
                  ],
                ),
                title: const Text('Makanan'),
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)
                  ),
                  child: (currentToggle == 0) ? Icon(Icons.upload, color: Colors.red) : Icon(Icons.download, color: Colors.green),
                ),
              ),
            ),
          );
  }

  Padding _toggleIncomeOutcome() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      
        child: Center(
          child: ToggleSwitch(
                      minWidth: 120,
                      minHeight: 50,
                      initialLabelIndex: currentToggle,
                      totalSwitches: 2,
                      cornerRadius: 20,
                      customTextStyles: [
                        GoogleFonts.montserrat(
                          color: Colors.white,
                        )
                        ],
                      labels: const ['Pengeluaran', 'Pemasukan'],
                      activeBgColors: const [[Colors.red], [Colors.green]],
                      onToggle: (index) {
                        setState(() {
                          currentToggle = index!;
                        });
                      },
                    ),
                  ),
                
    );
  }
}