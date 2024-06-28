import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.avaterImage,
    required this.mainImage,
    required this.name,
    required this.randomHour,
    required this.randomReplies,
    required this.randomLikes,
    required this.randomText,
    required this.onEllipsisTap,
  });

  final NetworkImage avaterImage;
  final NetworkImage mainImage;
  final String name;
  final int randomHour;
  final int randomReplies;
  final int randomLikes;
  final String randomText;
  final Function onEllipsisTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: avaterImage,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 2,
                  height: 195,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              const FaIcon(FontAwesomeIcons.users),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text("${randomHour}h"),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => onEllipsisTap(),
                          child: const FaIcon(
                            FontAwesomeIcons.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Text(randomText),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Image.network(
                      mainImage.url,
                      width: 300,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("$randomReplies replies - $randomLikes likes")
              ],
            ),
          )
        ],
      ),
    );
  }
}
