import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rurux_assignment/data/controller/localdata_controller.dart';
import 'package:rurux_assignment/services/utils/route_helper.dart';
import 'package:rurux_assignment/views/screens/brokerdetail_screen.dart';
import 'package:rurux_assignment/views/widgets/addbroker_bottomsheet.dart';

import '../../services/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      Get.find<LocalDataController>().getBrokers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Available Broker List"),
      ),
      body: GetBuilder<LocalDataController>(builder: (localDataController) {
        if (localDataController.brokers.isEmpty) {
          return const Center(
            child: Text("No broker available? Kindly add a new broker"),
          );
        }
        return ListView.separated(
          itemCount: localDataController.brokers.length,
          itemBuilder: (BuildContext context, int index) {
            final broker = localDataController.brokers[index];
            return ListTile(
                onTap: () {
                  Navigator.push(context, getCustomRoute(child: BrokerDetailScreen(selectedBroker: broker)));
                },
                leading: CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                  ),
                ),
                title: Text(
                  broker.brokerIp,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                ),
                subtitle: Text(
                  'Created At: ${DateFormat('dd MMMM yyyy').format(broker.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                ),
                trailing: const Icon(Icons.arrow_right));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      }),
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: primaryColor,
        child: Center(
          child: IconButton(
            onPressed: () {
              AddNewBroker().dialogue(context);
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
