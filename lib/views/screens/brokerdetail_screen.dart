import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rurux_assignment/data/controller/localdata_controller.dart';
import 'package:rurux_assignment/services/constant.dart';
import 'package:rurux_assignment/services/utils/route_helper.dart';
import 'package:rurux_assignment/views/screens/mqttdata_screen.dart';
import 'package:rurux_assignment/views/widgets/addtopics_bottomsheet.dart';

import '../../data/model/broker_model.dart';

class BrokerDetailScreen extends StatefulWidget {
  final MqttBroker selectedBroker;

  const BrokerDetailScreen({super.key, required this.selectedBroker});

  @override
  State<BrokerDetailScreen> createState() => _BrokerDetailScreenState();
}

class _BrokerDetailScreenState extends State<BrokerDetailScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      Get.find<LocalDataController>().getTopics(widget.selectedBroker.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Available Topics for ${widget.selectedBroker.brokerIp}',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<LocalDataController>(
          builder: (localDataController) {
            if (localDataController.brokerTopics.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Center(
                  child: Text(
                    "There are currently no broker topics available. Please add a new broker topic.",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return ListView.separated(
              itemCount: localDataController.brokerTopics.length,
              itemBuilder: (BuildContext context, int index) {
                final topic = localDataController.brokerTopics[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(context, getCustomRoute(child: MqttTopicDataScreen(broker: widget.selectedBroker.brokerIp, topic: topic.topic)));
                  },
                  leading: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                    ),
                  ),
                  title: Text(topic.topic),
                  trailing: const Icon(Icons.arrow_right_outlined),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          },
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: primaryColor,
        child: Center(
          child: IconButton(
            onPressed: () {
              AddNewTopic().dialogue(context, widget.selectedBroker.id);
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
