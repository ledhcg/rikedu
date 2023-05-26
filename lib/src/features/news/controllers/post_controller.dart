import 'package:get/get.dart';
import 'package:rikedu/src/features/news/models/category_model.dart';
import 'package:rikedu/src/features/news/models/post_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';

class PostController extends GetxController {
  final ApiService _apiService = Get.find();

  final Rx<List<Post>> _listNews = Rx<List<Post>>(<Post>[]);
  final Rx<Post> _newsOfTheDay = Post.defaultPost().obs;
  final Rx<List<Post>> _breakingNews = Rx<List<Post>>(<Post>[]);
  final Rx<List<PostCategory>> _categories =
      Rx<List<PostCategory>>(<PostCategory>[]);

  final RxBool _responseStatus = false.obs;
  final RxString _responseMessage = ''.obs;
  bool get responseStatus => _responseStatus.value;
  String get responseMessage => _responseMessage.value;

  List<Post> get listNews => _listNews.value;
  Post get newsOfTheDay => _newsOfTheDay.value;
  List<Post> get breakingNews => _breakingNews.value;
  List<PostCategory> get categories => _categories.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    await fetchData();
    _isLoading.value = false;
  }

  Future<void> fetchData() async {
    try {
      final response =
          await _apiService.get("${ApiConst.POSTS_ENDPOINT}?per_page=50");
      final responseCategory =
          await _apiService.get(ApiConst.CATEGORIES_ENDPOINT);
      if (responseCategory.body['success']) {
        List<dynamic> listCategories =
            List<dynamic>.from(responseCategory.body['data']);
        _categories.value = listCategories
            .map((category) => PostCategory.fromJson(category))
            .toList();
      } else {}
      if (response.body['success']) {
        List<dynamic> posts =
            List<dynamic>.from(response.body['data']['posts']);
        _listNews.value = posts.map((post) => Post.fromJson(post)).toList();

        _newsOfTheDay.value = listNews[0];
        _breakingNews.value = listNews.take(6).toList();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  List<Post> getPostsByCategory(String categoryName) {
    return listNews.where((post) => post.category == categoryName).toList();
  }

  void responseSuccess(String message) {
    _responseStatus.value = true;
    _responseMessage.value = message;
  }

  void responseFail(String message) {
    _responseStatus.value = false;
    _responseMessage.value = message;
  }
}
