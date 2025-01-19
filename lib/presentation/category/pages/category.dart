import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int currentToggle = 0;
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _toggleIncomeOutcome(),
          _listCategory(),
          _listCategory(),
        ],
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
                  child: (currentToggle == 0) ? const Icon(Icons.upload, color: Colors.red) : const Icon(Icons.download, color: Colors.green),
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