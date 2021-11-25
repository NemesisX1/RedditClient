import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:redditech/models/subreddit.model.dart';
import 'package:redditech/views/subreddit/subreddit.view.dart';

class SubredditTile extends StatelessWidget {
  const SubredditTile({
    Key? key,
    this.subreddit,
  }) : super(key: key);

  final Subreddit? subreddit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white54,
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 1)),
                      onPressed: () => Navigator.of(context).pushNamed(
                        SubredditView.routeName,
                        arguments: subreddit!.subredditNamePrefixed!,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          subreddit!.subredditNamePrefixed!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    subreddit!.subredditType! == 'public'
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ],
                ),
                const Gap(10),
                Text(
                  subreddit!.title!.trim(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subreddit!.preview != null
                    ? Column(
                        children: [
                          const Gap(10),
                          CachedNetworkImage(
                            placeholder: (_, __) {
                              return const CircularProgressIndicator();
                            },
                            imageUrl: subreddit!.preview!.source!.url!,
                            errorWidget: (_, __, ___) {
                              return const Icon(
                                FontAwesomeIcons.ambulance,
                              );
                            },
                          ),
                        ],
                      )
                    : Container(),
                const Gap(10),
                Text(
                  subreddit!.selftext!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
