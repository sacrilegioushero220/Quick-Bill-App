import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/cubits/items_cubit/items_cubit.dart';
import 'package:quick_bill/model/models.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.large(
          onPressed: () async {
            final newItem = await showAddNewItemDialog(context);
            if (newItem != null) {
              context.read<ItemCubit>().addItem(newItem);
            }
          },
          backgroundColor: const Color.fromARGB(255, 27, 50, 140),
          child: Image.asset(
            addToCart,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 221, 220, 220),
        appBar: customAppBar(
          "Add Items",
          context,
          isHome: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: BlocBuilder<ItemCubit, List<Item>>(
              builder: (context, items) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    if (items.isNotEmpty) _buildItemsTable(items),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsTable(List<Item> items) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            _buildTableHeader('Item Name'),
            _buildTableHeader('Quantity'),
            _buildTableHeader('Price'),
            _buildTableHeader('Total'),
          ],
        ),
        ...items.map((item) {
          final itemData = item.toList();
          return TableRow(
            children: [
              _buildTableCell(itemData[0]),
              _buildTableCell(itemData[1]),
              _buildTableCell(itemData[2]),
              _buildTableCell(itemData[3]),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTableCell(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(content),
    );
  }
}
