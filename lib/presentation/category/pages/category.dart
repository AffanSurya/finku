import 'package:finku/data/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final AppDatabase database = AppDatabase();
  int currentToggle = 0;
  
  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }
  TextEditingController categoryNameController = TextEditingController();
  int currenIndexDialog = 0;

  Future update(int categoryId, String newName) async {
    await database.updateCategoryRepo(categoryId, newName);
  }

  void openDialog(Category? category) {
    categoryNameController.text = category!.name;
    currenIndexDialog = category.type - 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialogAddCategory(category.id);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            _toggleIncomeOutcome(),
            FutureBuilder(
              future: getAllCategory(currentToggle + 1),
              // initialData: InitialData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
                  
                }else{
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true ,
                        itemBuilder: ( context,  index) {
                          return _listCategory(snapshot.data![index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Tidak Ada Data'),
                      );
                    }
                  }else{
                    return const Center(
                      child: Text(
                        'Tidak Ada Data'
                      ),
                    );
                  }
                }
              },
            ),
            
          ],
        ),
      ),
    );
  }

  AlertDialog _alertDialogAddCategory(int id) {
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
                    // insert(categoryNameController.text, currenIndexDialog + 1);
                    Navigator.of(context, rootNavigator: true).pop('dialog');

                    update(id, categoryNameController.text);

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

  Padding _listCategory(Category category) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 10,
              child: ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min ,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        database.deleteCategoryRepo(category.id);
                        setState(() {
                          
                        });
                      },
                    ),
                    const SizedBox(width: 10,),
                    IconButton(
                      onPressed: () {
                        openDialog(category);
                      }, 
                      icon: const Icon(Icons.edit)
                      ) 
                  ],
                ),
                title: Text(category.name),
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