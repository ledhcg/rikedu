import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/news/controllers/post_controller.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/news/views/widgets/tag_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rikedu/src/utils/constants/colors_constants.dart';
import 'package:skeletons/skeletons.dart';

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
        () => ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            NewsOfTheDay(isLoading: controller.isLoading),
            BreakingNews(isLoading: controller.isLoading),
            CategoryNews(isLoading: controller.isLoading),
          ],
        ),
      ),
    );
  }
}

class CategoryNews extends GetView<PostController> {
  const CategoryNews({
    required this.isLoading,
    super.key,
  });
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final categories = controller.categories;
    return DefaultTabController(
      length: categories.length,
      child: Column(
        children: [
          Skeleton(
            isLoading: isLoading,
            skeleton: SkeletonItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 100,
                          height: 20,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          alignment: Alignment.center),
                    ),
                    SizedBox(width: 5),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 70,
                          height: 20,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          alignment: Alignment.center),
                    ),
                    SizedBox(width: 5),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          width: 100,
                          height: 20,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          alignment: Alignment.center),
                    ),
                  ]),
            ),
            child: TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              tabs: categories
                  .map((category) => Tab(text: category.title))
                  .toList(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
                children: categories
                    .map((category) => BuildNewsList(
                        isLoading: isLoading, category: category.title))
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
    required this.isLoading,
  });

  final String category;
  final bool isLoading;
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
            isLoading
                ? null
                : Get.toNamed(Routes.NEWS_DETAIL, arguments: posts[index]);
          },
          child: Row(
            children: [
              ImageContainer(
                width: 80,
                height: 80,
                margin: const EdgeInsets.all(10),
                borderRadius: 5,
                isLoading: isLoading,
                imageUrl: posts[index].image.thumbnailUrl,
              ),
              Expanded(
                child: Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 4),
                  skeleton: SkeletonItem(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 2,
                                spacing: 5,
                                padding: const EdgeInsets.all(0),
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 20,
                                  borderRadius: BorderRadius.circular(12),
                                  alignment: Alignment.centerLeft,
                                  minLength:
                                      MediaQuery.of(context).size.width / 2,
                                )),
                          ),
                          const SizedBox(height: 15),
                          const SkeletonLine(
                            style: SkeletonLineStyle(
                                width: 150,
                                height: 20,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                alignment: Alignment.centerLeft),
                          ),
                        ]),
                  ),
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
                            .titleMedium!
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
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
    required this.isLoading,
    super.key,
  });
  final bool isLoading;
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
              Skeleton(
                isLoading: isLoading,
                skeleton: const SkeletonLine(
                  style: SkeletonLineStyle(
                      width: 250,
                      height: 30,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                child: Text(
                  'Breaking News'.tr,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                    isLoading
                        ? null
                        : Get.toNamed(Routes.NEWS_DETAIL, arguments: post);
                  },
                  child: ImageContainer(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                    overlay: true,
                    imageUrl: post.image.coverUrl,
                    isLoading: isLoading,
                    child: Skeleton(
                      shimmerGradient: SkeletonColorStyle.ON_SHIMMER_LIGHT,
                      darkShimmerGradient:
                          SkeletonColorStyle.DEFAULT_SHIMMER_LIGHT,
                      isLoading: isLoading,
                      duration: const Duration(seconds: 4),
                      skeleton: SkeletonItem(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 150,
                                    height: 30,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    alignment: Alignment.center),
                              ),
                              const SizedBox(height: 15),
                              SkeletonParagraph(
                                style: SkeletonParagraphStyle(
                                    lines: 3,
                                    spacing: 5,
                                    padding: const EdgeInsets.all(0),
                                    lineStyle: SkeletonLineStyle(
                                      randomLength: true,
                                      height: 20,
                                      borderRadius: BorderRadius.circular(12),
                                      alignment: Alignment.center,
                                      minLength:
                                          MediaQuery.of(context).size.width / 2,
                                    )),
                              ),
                              const SizedBox(height: 15),
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                    width: 150,
                                    height: 20,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    alignment: Alignment.center),
                              ),
                            ]),
                      ),
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
                                      .bodySmall!
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
                                  .titleMedium!
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
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ]),
                    ),
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
    required this.isLoading,
    super.key,
  });
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final post = controller.newsOfTheDay;
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.40,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      overlay: true,
      imageUrl: post.image.coverUrl,
      isLoading: isLoading,
      child: Skeleton(
        shimmerGradient: SkeletonColorStyle.ON_SHIMMER_LIGHT,
        darkShimmerGradient: SkeletonColorStyle.DEFAULT_SHIMMER_LIGHT,
        isLoading: isLoading,
        duration: const Duration(seconds: 4),
        skeleton: SkeletonItem(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(
                  style: SkeletonLineStyle(
                      width: 150,
                      height: 30,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                const SizedBox(height: 15),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 3,
                      spacing: 5,
                      padding: const EdgeInsets.all(0),
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 20,
                        borderRadius: BorderRadius.circular(12),
                        minLength: MediaQuery.of(context).size.width / 2,
                      )),
                ),
                const SizedBox(height: 15),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 3,
                      spacing: 5,
                      padding: const EdgeInsets.all(0),
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 10,
                        borderRadius: BorderRadius.circular(8),
                        minLength: MediaQuery.of(context).size.width / 2,
                      )),
                ),
                const SizedBox(height: 15),
                const SkeletonLine(
                  style: SkeletonLineStyle(
                      width: 150,
                      height: 30,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ]),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TagWidget(
                backgroundColor: Colors.grey.withAlpha(150),
                children: [
                  Text(
                    'News of the Day'.tr,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                post.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      height: 1.25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                post.summary,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
      ),
    );
  }
}
