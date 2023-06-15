import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/news/controllers/post_controller.dart';
import 'package:rikedu/src/features/news/models/post_model.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/news/views/widgets/tag_widget.dart';

class NewsDetailPage extends GetView<PostController> {
  const NewsDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final post = Get.arguments as Post;

    return ImageContainer(
      borderRadius: 0,
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
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            // color: Colors.white,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).colorScheme.background),
            child: Column(children: [
              buildHandleBar(context),
              const SizedBox(height: 5),
              TagWidget(
                backgroundColor: Colors.grey.shade200,
                children: [
                  ImageContainer(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.all(0),
                    borderRadius: 10,
                    isLoading: controller.isLoading,
                    imageUrl: controller.admin.avatarUrl,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    controller.admin.fullName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                post.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                      height: 1.25,
                    ),
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.25,
                    ),
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

Widget buildHandleBar(BuildContext context) {
  final theme = Theme.of(context);
  return FractionallySizedBox(
    widthFactor: 0.10,
    child: Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
      ),
      child: Container(
        height: 5.0,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(2.5)),
        ),
      ),
    ),
  );
}
