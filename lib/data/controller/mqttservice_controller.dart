import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/material.dart';
import 'package:rurux_assignment/main.dart';
import 'dart:async';

import 'package:rurux_assignment/services/utils/snack_bar.dart';

class MQTTServiceController {
  final String host;
  final String topic;
  final String identifier;
  MqttServerClient? client;
  final ValueNotifier<List<String>> messagesNotifier;
  final ValueNotifier<String> connectionStatusNotifier;

  final int maxReconnectAttempts = 5;
  final Duration reconnectDelay = const Duration(seconds: 5);
  int reconnectAttempts = 0;
  Timer? reconnectTimer;
  bool _isDisposed = false;

  MQTTServiceController({
    required this.host,
    required this.topic,
    required this.identifier,
    required this.messagesNotifier,
    required this.connectionStatusNotifier,
  });

  void initializeMQTTClient() {
    client = MqttServerClient(host, identifier);
    client!.port = 1883;
    client!.keepAlivePeriod = 20;
    client!.onDisconnected = onDisconnected;
    client!.secure = false;
    client!.onConnected = onConnected;
    client!.onSubscribed = onSubscribed;
    client!.logging(on: true);

    final connMess =
        MqttConnectMessage().withClientIdentifier(identifier).withWillTopic('willtopic').withWillMessage('My Will message').startClean().withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMess;
  }

  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  Future<void> connect() async {
    try {
      if (_isDisposed) return;
      connectionStatusNotifier.value = 'Connecting...';
      await client!.connect();
    } on Exception catch (e) {
      print('Exception - $e');
      if (!_isDisposed) connectionStatusNotifier.value = 'Connection Failed';
      disconnect();
    }
  }

  void disconnect() {
    reconnectAttempts = 0;
    reconnectTimer?.cancel();
    reconnectTimer = null;
    client?.disconnect();
  }

  void publish(String message) {
    if (connectionStatusNotifier.value == 'Connected') {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client!.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    } else {
      showSnackBar(navigatorKey.currentContext!, content: 'To push a message, a connection must be established.');
    }
  }

  void onDisconnected() {
    print('Disconnected');
    if (!_isDisposed) connectionStatusNotifier.value = 'Disconnected';
    reconnect();
  }

  void onConnected() {
    print('Connected to MQTT broker');
    reconnectAttempts = 0;
    if (!_isDisposed) connectionStatusNotifier.value = 'Connected';
    client?.subscribe(topic, MqttQos.atLeastOnce);
    client?.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      if (c != null && c.isNotEmpty) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        if (!_isDisposed) {
          messagesNotifier.value = [...messagesNotifier.value, pt];
          print(pt);
        }
      }
    });
  }

  void reconnect() {
    if (reconnectAttempts < maxReconnectAttempts && !_isDisposed) {
      reconnectAttempts++;
      if (!_isDisposed) connectionStatusNotifier.value = 'Reconnecting...';
      reconnectTimer = Timer(reconnectDelay, () {
        print('Attempting to reconnect... (Attempt $reconnectAttempts)');
        connect();
      });
    } else {
      if (!_isDisposed) connectionStatusNotifier.value = 'Max reconnect attempts reached.';
      print('Max reconnect attempts reached.');
    }
  }

  void dispose() {
    _isDisposed = true;
    reconnectTimer?.cancel();
    reconnectTimer = null;
    client?.disconnect();
    client = null;
  }
}
