import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_client/unsplash_client.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final Faker _faker = Faker();
  List<Photo> _photos = [];
  bool isLoadingFin = false;

  final _tabs = [
    const Tab(text: "All"),
    const Tab(text: "Replies"),
    const Tab(text: "Mentions"),
    const Tab(text: "Idontknow"),
    const Tab(text: "blaaa"),
  ];

  final client = UnsplashClient(
    settings: const ClientSettings(
        credentials: AppCredentials(
      accessKey: 'oW5CFs6CDHAJr79an_ky432z3XXTJS2GBnaxxeTj0BY',
      secretKey: 'IxCi0xW2kVzqrRGViVZxyTE_uUWiTM1YUsliZMhrGdg',
    )),
  );

  @override
  void initState() {
    super.initState();
    initUnsplash();
  }

  void initUnsplash() async {
    final photos = await client.photos.random(count: 20).goAndGet();

    setState(() {
      _photos = photos;
      isLoadingFin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Activity",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                tabs: _tabs,
                isScrollable: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TabBarView(
                    children: List.generate(
                      _tabs.length,
                      (index) => ListView.builder(
                        itemCount: 20,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) {
                          return isLoadingFin
                              ? ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      _photos[index].urls.thumb.toString(),
                                    ),
                                  ),
                                  title: Text(
                                    _faker.person.name(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    _faker.lorem.sentence().substring(0, 20),
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text("Follow"),
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text("loading..."),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
