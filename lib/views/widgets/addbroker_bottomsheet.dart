import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rurux_assignment/data/controller/localdata_controller.dart';
import 'package:rurux_assignment/services/utils/extensions.dart.dart';
import 'package:rurux_assignment/services/utils/snack_bar.dart';

import '../../data/model/broker_model.dart';
import '../../services/utils/common_button.dart';
import '../../services/utils/input_decoration.dart';

class AddNewBroker {
  dialogue(context) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (context) {
        return const AddNewBrokerScreen();
      },
    );
  }
}

class AddNewBrokerScreen extends StatefulWidget {
  const AddNewBrokerScreen({super.key});

  @override
  State<AddNewBrokerScreen> createState() => _AddNewBrokerScreenState();
}

class _AddNewBrokerScreenState extends State<AddNewBrokerScreen> {
  TextEditingController brokerIpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all()),
                              child: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              "Add Broker Details",
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    CustomButton(
                      radius: 6,
                      height: 25,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          MqttBroker newBroker = MqttBroker(
                            id: DateTime.now().millisecondsSinceEpoch,
                            brokerIp: brokerIpController.text.trim(),
                            clientId: 'clientId_${DateTime.now().millisecondsSinceEpoch}',
                            createdAt: DateTime.now(),
                          );
                          Get.find<LocalDataController>().saveBroker(newBroker).then((value) {
                            if (value) {
                              showSnackBar(context, content: 'Broker saved successfully');
                              Get.find<LocalDataController>().getBrokers();
                              Navigator.pop(context);
                            } else {
                              showSnackBar(context, content: 'Failed to save broker');
                            }
                          });
                        }
                      },
                      title: "ADD",
                    )
                  ],
                ),
                const SizedBox(height: 30),
                TextFormField(
                    validator: (value) {
                      if (value.isNotValid) {
                        return "Enter Broker IP";
                      }
                      return null;
                    },
                    controller: brokerIpController,
                    decoration: CustomDecoration.inputDecoration(floating: true, bgColor: const Color(0xFFF5F5F5), borderColor: const Color(0xFFF5F5F5), label: "Broker IP")),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
