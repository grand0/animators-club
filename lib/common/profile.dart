import 'package:flutter/material.dart';
import 'package:get_ded/auth.dart';
import 'package:get_ded/common/messages_panel.dart';
import 'package:get_ded/common/reviews.dart';
import 'package:get_ded/models/message.dart';

import '../common/avatar.dart';
import '../models/animator.dart';
import '../models/review.dart';
import '../models/user.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.user, required this.reviews})
      : super(key: key);

  final User user;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(name: user.name, url: user.avatarUrl),
          const SizedBox(height: 8),
          Text(
            user.name,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 32),
          const Text(
            "Ваши отзывы",
            style: TextStyle(fontSize: 18),
          ),
          ReviewBar(
            displayUserName: false,
            reviews: reviews,
          ),
        ],
      ),
    );
  }
}

class AnimatorProfile extends StatelessWidget {
  const AnimatorProfile(
      {Key? key, required this.animator, required this.reviews})
      : super(key: key);

  final Animator animator;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(name: animator.name, url: animator.avatarUrl),
          const SizedBox(height: 8),
          Text(
            animator.name,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            "${(reviews.fold(0, (value, review) => value + review.mark) / reviews.length).toStringAsFixed(1)}/10",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_box_outlined),
            label: const Text("Заказать"),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                builder: (_) => MessagesPanel(
                  messages: [
                    Message(senderName: animator.name, avatarUrl: null, text: "даров", sentTime: DateTime(2022, 12, 18, 17, 7, 12)),
                    Message(senderName: Auth.currentUser.name, avatarUrl: null, text: "прив", sentTime: DateTime(2022, 12, 18, 17, 5, 23)),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.message),
            label: const Text("Отправить сообщение"),
          ),
          const SizedBox(height: 32),
          const Text(
            "Отзывы",
            style: TextStyle(fontSize: 24),
          ),
          ReviewBar(
            displayAnimatorName: false,
            reviews: reviews,
          ),
        ],
      ),
    );
  }
}
