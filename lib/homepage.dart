import 'package:expence_tracker/appwrite_service.dart';
import 'package:expence_tracker/expencetracker.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late AppwriteServices _appwriteService;
  late List<Expence> _expences;

  final ItemController = TextEditingController();
  final AmountController = TextEditingController();
  final DateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteServices();
    _expences = [];
    
    _loadExpences();
  }

  Future<void> _loadExpences() async {
    try {
      final task = await _appwriteService.getExpence();
      setState(() {
        _expences = task.map((e) => Expence.fromDocument(e)).toList();
      });
    } catch (e) {
      print('Error loading task:$e');
    }
  }

  Future<void> _addExpance() async {
    final Item = ItemController.text;
    final Amount = AmountController.text;
    final Date = DateController.text;
    if (Item.isNotEmpty && Amount.isNotEmpty && Date.isNotEmpty) {
      try {
        await _appwriteService.addExpence(Item, Amount, Date);
        ItemController.clear();
        AmountController.clear();
        DateController.clear();

        _loadExpences();
      } catch (e) {
        print('Error adding tasks:$e');
      }
    }
  }

  DateTime? selectedDate;
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        DateController.text =
            '${selectedDate!.day.toString()}/${selectedDate!.month.toString()}/${selectedDate!.year.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 176, 197),
      appBar: AppBar(
        title: Text('Expence tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _expences.length,
            itemBuilder: (context, index) {
              final expence = _expences[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        TextField(
                          controller: ItemController,
                          decoration: InputDecoration(labelText: "Item"),
                        ),
                        TextField(
                          controller: AmountController,
                          decoration: InputDecoration(labelText: "Amount"),
                        ),
                        TextField(
                          controller: DateController,
                          onTap: () => _selectedDate(context),
                          decoration: InputDecoration(labelText: "Date"),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: _addExpance, child: Text("ADD")),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Text("+"),
      ),
    );
  }
}
