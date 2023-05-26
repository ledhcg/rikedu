import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/news/controllers/post_controller.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/news/views/widgets/tag_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class NewsPage extends GetView<PostController> {
  const NewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => controller.isLoading
            ? const LoadingWidget()
            : ListView(
                controller: scrollController,
                padding: EdgeInsets.zero,
                children: const [
                  NewsOfTheDay(),
                  BreakingNews(),
                  CategoryNews(),
                ],
              ),
      ),
    );
  }
}

class CategoryNews extends GetView<PostController> {
  const CategoryNews({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final categories = controller.categories;
    return DefaultTabController(
      length: categories.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            padding: EdgeInsets.zero,
            tabs: categories
                .map((category) => Tab(text: category.title))
                .toList(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
                children: categories
                    .map((category) => BuildNewsList(category: category.title))
                    .toList()),
          )
        ],
      ),
    );
  }
}

class BuildNewsList extends GetView<PostController> {
  const BuildNewsList({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final posts = controller.getPostsByCategory(category);
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.NEWS_DETAIL, arguments: posts[index]);
          },
          child: Row(
            children: [
              ImageContainer(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(10),
                  borderRadius: 5,
                  imageUrl: posts[index].image.thumbnailUrl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      posts[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'X hours ago'.trParams({
                        'hours': DateTime.now()
                            .difference(posts[index].publishedAt)
                            .inHours
                            .toString()
                      }),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BreakingNews extends GetView<PostController> {
  const BreakingNews({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final posts = controller.breakingNews;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Breaking News'.tr,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
          ),
          items: posts.map((post) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.NEWS_DETAIL, arguments: post);
                  },
                  child: ImageContainer(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    overlay: true,
                    imageUrl: post.image.coverUrl,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TagWidget(
                            backgroundColor: Colors.grey.withAlpha(150),
                            children: [
                              Text(
                                post.category,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            post.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                  height: 1.25,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'X hours ago'.trParams({
                              'hours': DateTime.now()
                                  .difference(post.publishedAt)
                                  .inHours
                                  .toString()
                            }),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ]),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class NewsOfTheDay extends GetView<PostController> {
  const NewsOfTheDay({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final post = controller.newsOfTheDay;
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.40,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      overlay: true,
      imageUrl: post.image.coverUrl,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TagWidget(
              backgroundColor: Colors.grey.withAlpha(150),
              children: [
                Text(
                  'News of the Day'.tr,
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
                    color: Colors.white,
                    height: 1.25,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              post.summary,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Get.toNamed(Routes.NEWS_DETAIL, arguments: post);
              },
              child: Row(
                children: [
                  Text(
                    "Read more".tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    FluentIcons.chevron_right_28_filled,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
