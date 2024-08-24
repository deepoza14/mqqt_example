import 'package:flutter/material.dart';
import 'package:rurux_assignment/services/utils/input_decoration.dart';

import '../../data/controller/mqttservice_controller.dart';

class MqttTopicDataScreen extends StatefulWidget {
  final String broker;
  final String topic;

  const MqttTopicDataScreen({super.key, required this.broker, required this.topic});

  @override
  MqttTopicDataScreenState createState() => MqttTopicDataScreenState();
}

class MqttTopicDataScreenState extends State<MqttTopicDataScreen> {
  late MQTTServiceController _mqttManager;
  final ValueNotifier<List<String>> _messagesNotifier = ValueNotifier([]);
  final ValueNotifier<String> _connectionStatusNotifier = ValueNotifier('Disconnected');

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mqttManager = MQTTServiceController(
      host: widget.broker,
      topic: widget.topic,
      identifier: 'rurux_assignment',
      messagesNotifier: _messagesNotifier,
      connectionStatusNotifier: _connectionStatusNotifier,
    );
    _mqttManager.initializeMQTTClient();
    _mqttManager.connect();
  }

  @override
  void dispose() {
    _mqttManager.disconnect();
    _messagesNotifier.dispose();
    _connectionStatusNotifier.dispose();

    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _mqttManager.publish(_messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'MQTT Topic: ${widget.topic}',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<String>(
              valueListenable: _connectionStatusNotifier,
              builder: (context, status, _) {
                return Text(
                  'Connection Status: $status',
                  style: TextStyle(
                    color: status == 'Connected' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _messagesNotifier,
              builder: (context, messages, _) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(messages[index]),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 20, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: _messageController, decoration: CustomDecoration.inputDecoration(label: "Message")),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
