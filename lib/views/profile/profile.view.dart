import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
    this.data,
  }) : super(key: key);

  final Map<String, dynamic>? data;

  static const String routeName = '/profil';

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 800,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: widget.data!['icon_img']!,
                  ),
                ),
                Text(widget.data!['subreddit']['title']),
                Text(widget.data!['subreddit']['display_name_prefixed']),
                Text(
                  widget.data!['subreddit']['subscribers'].toString() +
                      ' followers',
                ),
              ],
            ),
            const Gap(20),
            const Text(
              "Description",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            const Divider(),
            Text(
              widget.data!['description'] ?? "Vide",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
