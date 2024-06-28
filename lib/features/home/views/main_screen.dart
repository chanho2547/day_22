import 'package:day_22/features/home/views/widgets/ellipsis_contents.dart';
import 'package:day_22/features/home/views/post.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unsplash_client/unsplash_client.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Faker _faker = Faker.withGenerator(random);
  int picAmount = 10;
  List<Photo> _photos = [];
  final List<String> _photosURL = [];
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
    makeRamdomPhotos();
  }

  Future<void> makeRamdomPhotos() async {
    final photos = await client.photos.random(count: picAmount * 2).goAndGet();

    setState(() {
      _photos = photos;
      makePhotoToURL();
    });

    // print(_photos.first.urls.thumb);
  }

  void makePhotoToURL() {
    _photosURL.clear();
    for (var x in _photos) {
      _photosURL.add(x.urls.small.toString());
    }
  }

  void _onEllipsisTap() {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: const EllipsisContents(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: makeRamdomPhotos,
      displacement: 60,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: FaIcon(FontAwesomeIcons.threads),
            stretch: true,
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          _photosURL.isEmpty
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Post(
                          avaterImage: NetworkImage(_photosURL[index]),
                          mainImage: NetworkImage(_photosURL[index * 2 + 1]),
                          name: _faker.person.name(),
                          randomHour: random.integer(10),
                          randomReplies: random.integer(100),
                          randomLikes: random.integer(1000),
                          randomText: _faker.lorem.sentence(),
                          onEllipsisTap: _onEllipsisTap,
                        ),
                      );
                    },
                    childCount: picAmount,
                  ),
                ),
        ],
      ),
    );
  }
}
