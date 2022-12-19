import 'package:flutter/material.dart';

import '../models/review.dart';
import 'avatar.dart';

class ReviewBar extends StatelessWidget {
  const ReviewBar({
    Key? key,
    required this.reviews,
    this.displayUserName = true,
    this.displayAnimatorName = true,
  }) : super(key: key);

  final bool displayUserName;
  final bool displayAnimatorName;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: reviews
            .map(
              (e) => ReviewCard(
                review: e,
                displayUserName: displayUserName,
                displayAnimatorName: displayAnimatorName,
              ),
            )
            .toList(),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.review,
    this.displayUserName = true,
    this.displayAnimatorName = true,
  }) : super(key: key);

  final bool displayUserName;
  final bool displayAnimatorName;
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => ExpandedReview(review: review),
          );
        },
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (displayUserName) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Avatar(
                        name: review.userName,
                        url: review.userAvatarUrl,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        review.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (displayAnimatorName) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Avatar(
                        name: review.animatorName,
                        url: review.animatorAvatarUrl,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        review.animatorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  "${review.mark}/10",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(review.shortText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedReview extends StatelessWidget {
  const ExpandedReview({Key? key, required this.review}) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Аниматор:'),
              const SizedBox(width: 8),
              Avatar(
                name: review.animatorName,
                url: review.animatorAvatarUrl,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(review.animatorName),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Пользователь:'),
              const SizedBox(width: 8),
              Avatar(
                name: review.userName,
                url: review.userAvatarUrl,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(review.userName),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "${review.mark}/10",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(review.text),
        ],
      ),
    );
  }
}
