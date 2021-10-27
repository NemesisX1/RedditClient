import 'package:flutter/material.dart';
import 'widgets/custom.widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [],
      ),
    );
  }
}
