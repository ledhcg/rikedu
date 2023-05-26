import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/news/models/post_model.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/news/views/widgets/tag_widget.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';

class NewsDetailPage extends GetView<SettingsController> {
  const NewsDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final post = Get.arguments as Post;

    return ImageContainer(
      width: double.infinity,
      imageUrl: post.image.coverUrl,
      overlay: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              FluentIcons.chevron_left_48_filled,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: ListView(children: [
          NewsHeadline(
            post: post,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            // color: Colors.white,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Column(children: [
              TagWidget(
                backgroundColor: Colors.black38,
                children: [
                  const CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                          "https://api.ledinhcuong.com/storage/images/default/avatar/1.png")),
                  const SizedBox(width: 10),
                  Text(
                    'Admin'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                post.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      height: 1.25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              ImageContainer(
                width: double.infinity,
                imageUrl: post.image.coverUrl,
              ),
              const SizedBox(height: 10),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      height: 1.25,
                    ),
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      height: 1.25,
                    ),
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      height: 1.25,
                    ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}

class NewsHeadline extends StatelessWidget {
  const NewsHeadline({
    required this.post,
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          TagWidget(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                post.category,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  height: 1.25,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            post.summary,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
        ],
      ),
    );
  }
}
