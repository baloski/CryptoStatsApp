import 'package:cryptostats/pages/Favorites.dart';
import 'package:cryptostats/pages/Market.dart';
import 'package:cryptostats/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
    Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(

      drawer: const Navbar(),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(40),
          child: SizedBox(

              height: 45,
              child: Image.asset(
                "assets/images/nametrans2.png",
                fit: BoxFit.contain,

              )),
        ),
      ),
      body: SafeArea(
        child: Container(

          padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              TabBar(
                controller: viewController,

                tabs: [
                  Tab(
                    child: Text(
                      "Markets",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Favorites",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(

                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: viewController,
                  children: const [Markets(), Favorites()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}