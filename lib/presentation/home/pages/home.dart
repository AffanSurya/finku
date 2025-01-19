import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:finku/data/database.dart';
import 'package:finku/models/transaction_with_category.dart';
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
  final AppDatabase database = AppDatabase();
  int totalOutcome = 0;
  int totalIncome = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalAmounts();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _calculateTotalAmounts();
    }
  }

  Future<void> _calculateTotalAmounts() async {
    final outcome = await getTotalAmountByDateAndCategoryType(widget.selectedDate, 1);
    final income = await getTotalAmountByDateAndCategoryType(widget.selectedDate, 2);

    setState(() {
      totalOutcome = outcome;
      totalIncome = income;
    });
  }

  Future<int> getTotalAmountByDateAndCategoryType(DateTime date, int categoryType) async {
    return await database.getTotalAmountByDateAndCategoryType(date, categoryType);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            _incomeOutcome(totalIncome.toString(), totalOutcome.toString()),
            _textTransaction(),
            StreamBuilder<List<TransactionWithCategory>>(
              stream: database.getTransactionByDateRepo(widget.selectedDate),
              // initialData: initialData,
              builder: ( context,  snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }else{
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return _listTransaction(
                            snapshot.data![index].transaction.id, 
                            snapshot.data![index].transaction.amount.toString(), 
                            snapshot.data![index].category.name,
                            snapshot.data![index].transaction.description,
                            snapshot.data![index].category.type,
                            );
                        }
                        );
                    }else{
                    return const Center(
                    child: Text('Data Masih Kosong'),
                  );
                  }
                  }else{
                    return const Center(
                    child: Text('Tidak Ada Data'),
                  );
                  }
                }
              },
            ),
          ],
        )
      ),
    );
  }

  Padding _listTransaction(int id, String amount, String category, String description, int type) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 10,
              child: ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min ,
                  children: [
                    IconButton(
                      onPressed: () {
                        database.deleteTransactionByDateRepo(id);
                        setState(() {
                          
                        });
                      }, 
                      icon: const Icon(Icons.delete)
                      ) ,
                    // SizedBox(width: 10,),
                    // Icon(Icons.edit)
                  ],
                ),
                title: Text('Rp $amount'),
                subtitle: Text("$category : $description"),
                leading: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)
                  ),
                  child: (type == 1) ? const Icon(Icons.upload, color: Colors.red) : 
                  const Icon(Icons.download, color: Colors.green),
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

  Padding _incomeOutcome(String amountIncome, String amountOutcome) {
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
                            'Rp. $amountIncome',
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
                            'Rp. $amountOutcome',
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