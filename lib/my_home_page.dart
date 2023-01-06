import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock/service/stock_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();

  bool isInit = true;
  bool isLoading = false;
  @override
  @override
  void initState() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<StockProvider>(context, listen: false)
          .getStock()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    setState(() {
      isInit = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<StockProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Stocks"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  data.search(value);
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  ),
                                  // hintStyle: AppTextStyle.body5
                                  //     .copyWith(color: Theme.of(context).hintColor),
                                  contentPadding: const EdgeInsets.only(
                                    top: 24,
                                    bottom: 16,
                                  ),
                                  fillColor: Theme.of(context).cardColor,
                                  filled: true,
                                  hintText: 'Search',
                                  prefixIcon: const Icon(Icons.search),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 64,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.parse(data.date),
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 140)),
                                    lastDate: DateTime.now());
                                if (picked != null &&
                                    picked != DateTime.parse(data.date)) {
                                  data.pickedDate(
                                      DateFormat('yyyy-MM-dd').format(picked));
                                }
                              },
                              icon: const Icon(Icons.calendar_month_sharp)),
                        ],
                      ),
                      isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : data.data.isNotEmpty
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: constraint.maxWidth / 6,
                                            child: const Center(
                                                child: Text(
                                              'Company',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        SizedBox(
                                            width: constraint.maxWidth / 6,
                                            child: const Center(
                                                child: Text(
                                              'Open',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        SizedBox(
                                            width: constraint.maxWidth / 6,
                                            child: const Center(
                                                child: Text(
                                              'Low',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        SizedBox(
                                            width: constraint.maxWidth / 6,
                                            child: const Center(
                                                child: Text(
                                              'High',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        SizedBox(
                                            width: constraint.maxWidth / 6,
                                            child: const Center(
                                                child: Text(
                                              'Change',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        SizedBox(
                                            width: constraint.maxWidth / 6,
                                            child: const Center(
                                                child: Text(
                                              'Close',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 600,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          String change = ((double.parse(data
                                                          .data[index]
                                                          .data!
                                                          .eod!
                                                          .close
                                                          .toString()) -
                                                      double.parse(data
                                                          .data[index]
                                                          .data!
                                                          .eod!
                                                          .open
                                                          .toString())) *
                                                  100 /
                                                  double.parse(data.data[index]
                                                      .data!.eod!.close
                                                      .toString()))
                                              .toStringAsPrecision(3);
                                          return Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: SizedBox(
                                                    width:
                                                        constraint.maxWidth / 6,
                                                    height: 50,
                                                    child: Center(
                                                        child: Text(
                                                      data.data[index].data!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ))),
                                              ),
                                              SizedBox(
                                                  width:
                                                      constraint.maxWidth / 6,
                                                  child: Center(
                                                      child: Text(data
                                                          .data[index]
                                                          .data!
                                                          .eod!
                                                          .open
                                                          .toString()))),
                                              SizedBox(
                                                  width:
                                                      constraint.maxWidth / 6,
                                                  child: Center(
                                                      child: Text(data
                                                          .data[index]
                                                          .data!
                                                          .eod!
                                                          .low
                                                          .toString()))),
                                              SizedBox(
                                                  width:
                                                      constraint.maxWidth / 6,
                                                  child: Center(
                                                      child: Text(data
                                                          .data[index]
                                                          .data!
                                                          .eod!
                                                          .high
                                                          .toString()))),
                                              SizedBox(
                                                  width:
                                                      constraint.maxWidth / 6,
                                                  child: Center(
                                                      child: Text(
                                                    change,
                                                    style: TextStyle(
                                                        color: double.parse(
                                                                    change) >
                                                                0
                                                            ? Colors.green
                                                            : Colors.red),
                                                  ))),
                                              SizedBox(
                                                width: constraint.maxWidth / 6,
                                                child: Center(
                                                    child: Text(data.data[index]
                                                        .data!.eod!.close
                                                        .toString())),
                                              )
                                            ],
                                          );
                                        },
                                        itemCount: data.data.length,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  height: 600,
                                  child: Center(
                                      child: Text(
                                    'Empty Data',
                                    style: TextStyle(fontSize: 25),
                                  ))),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
