class Review {
  final String userName;
  final String? userAvatarUrl;
  final String animatorName;
  final String? animatorAvatarUrl;
  final int mark;
  final String text;

  String get shortText {
    if (text.length <= 60) {
      return text;
    } else {
      return "${text.substring(0, 60)}...";
    }
  }

  Review({
    required this.userAvatarUrl,
    required this.animatorAvatarUrl,
    required this.userName,
    required this.mark,
    required this.text,
    required this.animatorName,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userName: json['user_name'],
      userAvatarUrl: json['user_avatar_url'],
      animatorName: json['animator_name'],
      animatorAvatarUrl: json['animator_avatar_url'],
      text: json['text'],
      mark: json['mark'],
    );
  }
}
