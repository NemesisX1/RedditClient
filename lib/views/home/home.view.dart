import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:redditech/locator.dart';
import 'package:redditech/models/subreddit.model.dart';
import 'package:redditech/services/api/api.dart';
import 'package:redditech/services/api/data/subreddits.dart';
import 'package:redditech/services/local/local.service.dart';
import 'package:redditech/viewmodels/app.viewmodel.dart';
import 'package:redditech/viewmodels/home.viewmodel.dart';
import 'package:redditech/views/base.view.dart';
import 'package:redditech/views/home/widgets/subreddit.widget.dart';
import 'package:redditech/views/login/login.view.dart';
import 'package:redditech/views/profile/profile.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final _localService = locator<LocalService>();
  int _count = 50;
  final _scrollController = ScrollController();
  final _futureGetter = locator<HomeViewModel>();
  Future<List<Subreddit>>? _future;
  String trends = Trends.news;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _future = _futureGetter.getSubreddits(
      type: trends,
      count: _count,
      limit: _count,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async => Navigator.of(context).pushNamed(
                ProfileView.routeName,
                arguments: await model.getMe(),
              ),
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  FontAwesomeIcons.redditAlien,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  final appProvider = Provider.of<AppViewModel>(
                    context,
                    listen: false,
                  );
                  if (appProvider.isDarKMode) {
                    appProvider.setDarkMode();
                  } else {
                    appProvider.setLightMode();
                  }
                },
                icon: const Icon(
                  FontAwesomeIcons.moon,
                ),
              ),
              const Gap(10),
              IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "Voulez vous vous déconnecter ?",
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              _localService.deleteBoxes(HiveClassName.token);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                LoginView.routeName,
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Oui",
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Non"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
          body: FutureBuilder<List<Subreddit>>(
            future: _future,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return ErrorWidget(snapshot);
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List<Widget>.generate(
                        snapshot.data!.length,
                        (index) => SubredditTile(
                          subreddit: snapshot.data![index],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
                switch (value) {
                  case 0:
                    trends = Trends.news;
                    break;
                  case 1:
                    trends = Trends.rising;
                    break;
                  case 2:
                    trends = Trends.hot;
                    break;
                  default:
                }
                _future = _futureGetter.getSubreddits(
                  type: trends,
                  count: _count,
                  limit: _count,
                );
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: 'New',
                icon: Icon(
                  FontAwesomeIcons.newspaper,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Popular',
                icon: Icon(
                  FontAwesomeIcons.star,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Hot',
                icon: Icon(
                  FontAwesomeIcons.fire,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _scrollListener() {
    if (_scrollController.position.extentAfter <= 0) {
      setState(() {
        _count += 10;
        _future = _futureGetter.getSubreddits(
          type: trends,
          count: _count,
          limit: _count,
        );
      });
    }
  }
}
