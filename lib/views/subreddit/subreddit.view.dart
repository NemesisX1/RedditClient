import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:redditech/viewmodels/subreddit.viewmodel.dart';
import 'package:redditech/views/base.view.dart';
import 'dart:developer';
import 'package:redditech/helpers/extensions.dart';

class SubredditView extends StatefulWidget {
  const SubredditView({
    Key? key,
    this.subredditName,
  }) : super(key: key);

  static const String routeName = '/subreddit';
  final String? subredditName;
  @override
  _SubredditViewState createState() => _SubredditViewState();
}

class _SubredditViewState extends State<SubredditView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SubredditViewModel>(
      builder: (context, model, child) {
        return FutureBuilder<Map<String, dynamic>>(
          future: model.getInfos(widget.subredditName!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return ErrorWidget(snapshot);
            } else {
              log(snapshot.data.toString());
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data!['icon_img'] ??
                              'https://korii.slate.fr/sites/default/files/styles/375x400/public/nyancat.png',
                        ),
                      ),
                      const Gap(10),
                      Text(
                        widget.subredditName!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: snapshot.data!['banner_img']
                                .toString()
                                .isEmpty
                            ? 'https://korii.slate.fr/sites/default/files/styles/375x400/public/nyancat.png'
                            : snapshot.data!['banner_img'],
                        errorWidget: (_, __, ___) {
                          return const Placeholder();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data!["title"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                    color: snapshot.data!["key_color"]
                                        .toString()
                                        .toColor(),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed:
                                      snapshot.data!['user_is_subscriber']
                                          ? () {}
                                          : () {},
                                  child: snapshot.data!['user_is_subscriber']
                                      ? Text("Abonné")
                                      : Text("Suivre"),
                                )
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * (0.55),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!["description"],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
