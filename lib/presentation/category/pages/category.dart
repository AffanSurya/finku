import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 120,
                    minHeight: 50,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    cornerRadius: 20,
                    customTextStyles: [
                      GoogleFonts.montserrat(
                        color: Colors.white,
                      )
                      ],
                    labels: const ['Pemasukan', 'Pengeluaran'],
                    activeBgColors: const [[Colors.green], [Colors.red]],
                    onToggle: (index) {
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}