import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
import 'package:quick_bill/model/models.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  void initState() {
    BlocProvider.of<StorageCubit>(context).loadItemListFromPreferences();
    super.initState();
  }

  double _calculateGrandTotal(List<Item> items) {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.qty));
  }

  @override
  Widget build(BuildContext context) {
    List<Item> itemList = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          await showAddNewItemDialog(context);
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
        // clearItemList: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocConsumer<StorageCubit, StorageState>(
            listener: (context, state) {
              if (state is ItemAdded) {
                itemList = state.item;

                print("ItemList :$itemList");
              }
            },
            builder: (context, state) {
              if (state is ItemAdded) {
                double grandTotal = _calculateGrandTotal(itemList);
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    _buildItemsTable(itemList),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                            "Grand Total: Rs ${grandTotal.toStringAsFixed(2)}"),
                      ],
                    ),
                  ],
                );
              } else if (state is ItemLoaded) {
                itemList = state.item;
                double grandTotal = _calculateGrandTotal(itemList);
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    _buildItemsTable(itemList),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                            "Grand Total: Rs ${grandTotal.toStringAsFixed(2)}"),
                      ],
                    ),
                  ],
                );
              }
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 700,
                    child: Center(child: Text("No items are added")),
                  )
                ],
              );
            },
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
        4: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            _buildTableHeader('Item Name'),
            _buildTableHeader('Qty'),
            _buildTableHeader('Price'),
            _buildTableHeader('Total'),
            _buildTableHeader('Action'),
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
              _buildTableAction(item),
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
        textAlign: TextAlign.justify,
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

  Widget _buildTableAction(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () {
            BlocProvider.of<StorageCubit>(context).removeItem(item);
          },
          icon: const Icon(Icons.delete)),
    );
  }
}
