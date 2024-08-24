import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rurux_assignment/data/controller/localdata_controller.dart';
import 'package:rurux_assignment/services/utils/extensions.dart.dart';

import '../../data/model/topic_model.dart';
import '../../services/utils/common_button.dart';
import '../../services/utils/input_decoration.dart';

class AddNewTopic {
  dialogue(BuildContext context, int brokerId) {
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
        return AddNewTopicScreen(brokerId: brokerId);
      },
    );
  }
}

class AddNewTopicScreen extends StatefulWidget {
  final int brokerId;

  const AddNewTopicScreen({super.key, required this.brokerId});

  @override
  State<AddNewTopicScreen> createState() => _AddNewTopicScreenState();
}

class _AddNewTopicScreenState extends State<AddNewTopicScreen> {
  TextEditingController topicController = TextEditingController();

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
                              "Add Broker Topic",
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
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final newTopic = BrokerTopics(
                            id: DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
                            topic: topicController.text.trim(),
                            brokerID: widget.brokerId.toString(),
                            createdAt: DateTime.now(),
                          );
                          await Get.find<LocalDataController>().addTopic(newTopic).then((value) {
                            if (value) {
                              Get.find<LocalDataController>().getTopics(widget.brokerId.toString());
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      title: "ADD",
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 30),
                TextFormField(
                    validator: (value) {
                      if (value.isNotValid) {
                        return "Enter Broker Topic";
                      }
                      return null;
                    },
                    controller: topicController,
                    decoration:
                        CustomDecoration.inputDecoration(floating: true, bgColor: const Color(0xFFF5F5F5), borderColor: const Color(0xFFF5F5F5), label: "Subscription Topic")),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
