import 'dart:convert';

import 'package:get/get.dart';
import 'package:rurux_assignment/services/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/broker_model.dart';
import '../model/topic_model.dart';

class LocalDataController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalDataController({required this.sharedPreferences});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<bool> saveBroker(MqttBroker broker) async {
    List<String>? brokerStrings = sharedPreferences.getStringList(AppConstants.allBroker) ?? [];
    brokerStrings.add(jsonEncode(broker.toMap()));
    return await sharedPreferences.setStringList(AppConstants.allBroker, brokerStrings);
  }

  List<MqttBroker> brokers = [];

  Future<void> getBrokers() async {
    List<String>? brokerStrings = sharedPreferences.getStringList(AppConstants.allBroker);

    if (brokerStrings != null) {
      brokers = brokerStrings.map((brokerString) => MqttBroker.fromMap(jsonDecode(brokerString))).toList();
      update();
    } else {}
  }

  Future<bool> addTopic(BrokerTopics topic) async {
    List<String>? topicStrings = sharedPreferences.getStringList(AppConstants.allTopics) ?? [];
    topicStrings.add(jsonEncode(topic.toMap()));

    return await sharedPreferences.setStringList(AppConstants.allTopics, topicStrings);
  }

  List<BrokerTopics> brokerTopics = [];

  Future<void> getTopics(String brokerID) async {
    List<String>? topicStrings = sharedPreferences.getStringList(AppConstants.allTopics);

    if (topicStrings != null) {
      brokerTopics = topicStrings
          .map((topicString) => BrokerTopics.fromMap(jsonDecode(topicString)))
          .where((topic) => topic.brokerID == brokerID) // Apply the filter here
          .toList();
    } else {
      brokerTopics.clear(); // Clear the list if no topics are found
    }
    update();
  }
}
