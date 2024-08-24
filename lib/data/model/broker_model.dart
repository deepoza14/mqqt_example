class MqttBroker {
  int id;
  String brokerIp;
  String clientId;
  DateTime createdAt; // New field to store the creation date and time

  MqttBroker({
    required this.id,
    required this.brokerIp,
    required this.clientId,
    required this.createdAt, // Initialize the createdAt field
  });

  factory MqttBroker.fromMap(Map<String, dynamic> map) {
    return MqttBroker(
      id: map['id'],
      brokerIp: map['brokerIp'],
      clientId: map['clientId'],
      createdAt: DateTime.parse(map['createdAt']), // Parse the DateTime from a string
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brokerIp': brokerIp,
      'clientId': clientId,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
}
