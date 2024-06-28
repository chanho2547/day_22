import 'package:day_22/features/home/views/post.dart';
import 'package:day_22/features/home/views/widgets/ellipsis_contents.dart';
import 'package:day_22/features/profile/views/setting_screen.dart';
import 'package:day_22/features/profile/views/widgets/profile_tab_bar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unsplash_client/unsplash_client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  List<Photo> _photos = [];
  final List<String> _photosURL = [];
  bool _isPhotosLoad = false;
  int picAmount = 10;
  final Faker _faker = Faker();
  // late TabController _tabController;

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
    initPhotos();
    // _tabController = TabController(length: 2, vsync: this);
  }

  void initPhotos() async {
    final photoOne = await client.photos.random(count: 1).goAndGet();
    makeRamdomPhotos();
    setState(() {
      _photos = photoOne;
      _isPhotosLoad = true;
    });
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

  void _onBarsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // 상단바
              SliverAppBar(
                leading: const Center(
                  child: FaIcon(FontAwesomeIcons.earthAsia),
                ),
                actions: [
                  const FaIcon(FontAwesomeIcons.instagram),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: _onBarsTap,
                      child: const FaIcon(FontAwesomeIcons.bars)),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                backgroundColor: Colors.white,
              ),

              // 개인정보
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _faker.person.name(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "jane_mobbin",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "thread.net",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _faker.lorem.sentence().length < 24
                                    ? _faker.lorem.sentence()
                                    : _faker.lorem.sentence().substring(0, 24),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // 아바타 사진
                          _isPhotosLoad
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      _photos.first.urls.thumb.toString()),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Edit Profile, Share Profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 160,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 1.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 1.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Share Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: ProfileTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
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
                                  mainImage:
                                      NetworkImage(_photosURL[index * 2 + 1]),
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
              const Center(
                child: Text("Replies"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
