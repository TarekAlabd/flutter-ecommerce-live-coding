import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  late OrderStatuses currentActive = OrderStatuses.delivered;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 15.0, left: 15.0, bottom: 20.0, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const Icon(
                    CupertinoIcons.back,
                    size: 30,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                InkWell(
                  child: const Icon(
                    CupertinoIcons.search,
                    size: 30,
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              ' My Orders',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterItem("Delivered", OrderStatuses.delivered),
                _buildFilterItem("Completed", OrderStatuses.completed),
                _buildFilterItem("Cancelled", OrderStatuses.cancelled),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) {
                  return _buildOrderCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        //  height: 120,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'orderNo 1283978686872',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '21-02-2022',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Tracking No. ',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey),
                    ),
                    Text(
                      'IWAEEEK123123',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Qty: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          '10',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Total amount: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          '40 ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 32,
                      width: 75,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 0.75,
                            )),
                        child: Center(
                          child: Text(
                            'Details',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      getStatusLabel(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: getStatusColor(),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterItem(String label, OrderStatuses val) {
    bool isSelected = val == currentActive;
    return InkWell(
      onTap: () => setState(() {
        currentActive = val;
      }),
      child: SizedBox(
        height: 40,
        width: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: isSelected ? Colors.white : Colors.black),
          )),
        ),
      ),
    );
  }

  Color getStatusColor() {
    if (currentActive == OrderStatuses.completed) {
      return Color.fromARGB(255, 254, 232, 31);
    } else if (currentActive == OrderStatuses.delivered) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String getStatusLabel() {
    if (currentActive == OrderStatuses.completed) {
      return "Completed";
    } else if (currentActive == OrderStatuses.delivered) {
      return "Delivered";
    } else {
      return "Cancelled";
    }
  }
}

enum OrderStatuses { delivered, completed, cancelled }
