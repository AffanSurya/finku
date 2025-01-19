import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int currentToggle = 1;
  List<String> list = ['makan', 'minum', 'jalan'];
  late String dropDownValue = list.first;
  TextEditingController dateController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _toggleIncomeOutcome(),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),

                  labelText: 'Jumlah',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Kategori',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                value: dropDownValue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
              
                  value: value,
                  child: Text(value)
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
            ),
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                readOnly: true,
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Tanggal'),
                onTap: () async{
                  DateTime ? pickedDate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), 
                    lastDate: DateTime(2999)
                    );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              
                    dateController.text = formattedDate;
                  }
                },
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                onPressed: () {}, 
                child: const Text('Simpan', style: TextStyle(color: Colors.white))
                ),
            )
            ],
          ) 
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