import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:finku/data/database.dart';
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
  final AppDatabase database = AppDatabase();
  int currentToggle = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Category? selectedCategory;

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  Future insert(int amount, DateTime date, String description, int categoryId) async {
     DateTime now = DateTime.now();
    final row = await database.into(database.transactions).insertReturning(
        TransactionsCompanion.insert(
            description: description,
            categoryId: categoryId,
            amount: amount,
            transactionDate: date,
            createdAt: now,
            updatedAt: now));

    print(row);
  }


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
                controller: amountController,
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
            FutureBuilder<List<Category>>(
              future: getAllCategory(currentToggle + 1),
              // initialData: InitialData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                }else{
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButton<Category>(
                          value: (selectedCategory == null) ? snapshot.data!.first : selectedCategory,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          items: snapshot.data!.map((Category item) {
                            return DropdownMenuItem<Category>(
                              value: item,
                              child: Text(item.name),
                            );
                          }).toList(),
                          onChanged: (Category? value){
                            setState(() {
                            selectedCategory = value;
                            });
                          },
                        ),
                      );
                    }else{
                      return const Center(
                        child: Text('Data Kosong'),
                      );
                    }
                  } else {
                      return const Center(
                        child: Text('Tidak Ada Data'),
                      );
                    
                  }
                }
              },
            ),
            
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
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
            ),const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),

                  labelText: 'Keterangan',
                ),
              ),
            ),
            
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  insert(
                    int.parse(amountController.text), 
                    DateTime.parse(dateController.text), 
                    descriptionController.text, 
                    selectedCategory!.id
                    );
                    Navigator.pop(context, true);
                }, 
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
                          selectedCategory = null;
                        });
                      },
                    ),
                  ),
                
    );
  }
}