import 'package:flutter/material.dart';

class AddBillAlert extends StatefulWidget {
  const AddBillAlert({Key? key}) : super(key: key);

  @override
  State<AddBillAlert> createState() => _AddBillAlertState();
}

class _AddBillAlertState extends State<AddBillAlert> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void pickTime() async {
    final DateTime? dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.parse("3000-12-31"));
    if (dt != null) {
      setState(() {
        _dateController.text = dt.toString();
      });
    }
  }

  void pickCategory() async {
    showModalBottomSheet(context: context, builder: (_) => CategoryPicker());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Bill"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            focusNode: _nameFocusNode,
            controller: _nameController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.description),
              labelText: "Bill Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            focusNode: _amountFocusNode,
            controller: _amountController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.numbers),
              labelText: "Bill Amount",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onTap: pickTime,
            focusNode: _dateFocusNode,
            controller: _dateController,
            keyboardType: TextInputType.none,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              labelText: "Due Date",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onTap: pickCategory,
            focusNode: _categoryFocusNode,
            controller: _categoryController,
            keyboardType: TextInputType.none,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.category_outlined),
              labelText: "Category",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Add"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
