class Message {
  String senderName;
  String? avatarUrl;
  String text;
  DateTime sentTime;

  Message({
    required this.senderName,
    required this.avatarUrl,
    required this.text,
    required this.sentTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderName: json['sender_name'],
      avatarUrl: json['avatar_url'],
      text: json['text'],
      sentTime: DateTime.fromMillisecondsSinceEpoch(json['time']),
    );
  }
}
