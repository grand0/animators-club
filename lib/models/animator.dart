import 'package:latlong2/latlong.dart';

class Animator {
  final String name;
  final String? avatarUrl;
  final bool working;
  final LatLng coords;

  Animator({
    required this.name,
    required this.avatarUrl,
    required this.working,
    required this.coords,
  });

  factory Animator.fromJson(Map<String, dynamic> json) {
    return Animator(
      name: json['name'],
      avatarUrl: json['avatar_url'],
      working: json['working'],
      coords: LatLng(json['lat'], json['lon']),
    );
  }
}
