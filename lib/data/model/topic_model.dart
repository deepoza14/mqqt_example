class BrokerTopics {
  int id;
  String topic;
  String brokerID;
  DateTime createdAt;

  BrokerTopics({
    required this.id,
    required this.topic,
    required this.brokerID,
    required this.createdAt,
  });

  factory BrokerTopics.fromMap(Map<String, dynamic> map) {
    return BrokerTopics(
      id: map['id'],
      topic: map['title'],
      brokerID: map['brokerIp'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': topic,
      'brokerIp': brokerID,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
