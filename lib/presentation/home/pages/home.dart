import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final DateTime selectedDate;
  const HomePage({
    super.key,
    required this.selectedDate
    });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            _incomeOutcome(),
            _textTransaction(),
            _listTransaction(),
            _listTransaction(),
          ],
        )
      ),
    );
  }

  Padding _listTransaction() {
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
                title: const Text('Rp 20.000'),
                subtitle: const Text('Makan siang'),
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Icon(Icons.upload, color: Colors.red),
                ),
              ),
            ),
          );
  }

  Padding _textTransaction() {
    return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Transaksi',
              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
  }

  Padding _incomeOutcome() {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Column(
                        
                        children: [
                          Text(
                            'Pemasukan',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 15
                            ),
                            ),
                            const SizedBox(height: 5,),
                          Text(
                            'Rp. 3.000.000',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 15
                            )
                            )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(                          
                        children: [
                          Text(
                            'Pengeluaran',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 15
                            ),
                            ),
                            const SizedBox(height: 5,),
                          Text(
                            'Rp. 3.000.000',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 15
                            )
                            )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}