import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get_ded/common/profile.dart';
import 'package:get_ded/models/review.dart';
import 'package:get_ded/models/user.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_database/firebase_database.dart';

import '../auth.dart';
import '../models/animator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase db = FirebaseDatabase.instance;
  List<Animator> animators = [];
  List<StreamSubscription> streams = [];
  bool initialized = false;

  Marker getMarker(Animator animator) => Marker(
        point: animator.coords,
        width: 40,
        height: 40,
        rotate: true,
        builder: (context) => FutureBuilder(
          future: db.ref('reviews').get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.warning,
                  size: 32,
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            List<Review> reviews = (snapshot.requireData.value as List)
                .where((e) => e['animator_name'] == animator.name)
                .map((e) => Review.fromJson(Map.from(e)))
                .toList();
            return GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => SingleChildScrollView(
                    child:
                        AnimatorProfile(animator: animator, reviews: reviews)),
              ),
              child: const Text(
                "🎅",
                style: TextStyle(fontSize: 24),
              ),
            );
          },
        ),
      );

  @override
  void initState() {
    super.initState();
    streams.add(
      db.ref('deds').onValue.listen(
        (event) {
          List json = event.snapshot.value as List;
          setState(() {
            animators = json.map((e) {
              Map<String, dynamic> map = Map.from(e);
              return Animator.fromJson(map);
            }).toList();
          });
        },
        onError: (err) => print(err),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final stream in streams) {
      stream.cancel();
    }
  }

  void showUserProfile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => FutureBuilder(
        future: db.ref('reviews').get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.warning,
                size: 32,
              ),
            );
          }
          if (!snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              height: 36,
              width: 36,
              child: const CircularProgressIndicator(),
            );
          }
          List<Review> list = (snapshot.requireData.value as List)
              .where((e) => e['user_name'] == Auth.currentUser.name)
              .map((e) => Review.fromJson(Map.from(e)))
              .toList();
          return UserProfile(
            user: Auth.currentUser,
            reviews: list,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animators Club"),
        actions: [
          IconButton(
            onPressed: showUserProfile,
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(55.796127, 49.106414),
          zoom: 13,
          maxZoom: 18,
          minZoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'ru.maslyata.get_ded',
          ),
          MarkerLayer(
            markers: animators.map((e) => getMarker(e)).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.search),
      ),
    );
  }
}
