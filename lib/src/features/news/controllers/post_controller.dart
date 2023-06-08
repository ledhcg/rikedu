import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/news/models/category_model.dart';
import 'package:rikedu/src/features/news/models/post_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';

class PostController extends GetxController {
  final ApiService _apiService = Get.find();

  final Rx<List<Post>> _listNews = Rx<List<Post>>(<Post>[
    Post.defaultPost(),
    Post.defaultPost(),
    Post.defaultPost(),
    Post.defaultPost(),
    Post.defaultPost(),
    Post.defaultPost(),
  ]);
  final Rx<Post> _newsOfTheDay = Post.defaultPost().obs;
  final Rx<List<Post>> _breakingNews = Rx<List<Post>>(<Post>[
    Post.defaultPost(),
    Post.defaultPost(),
    Post.defaultPost(),
  ]);
  final Rx<List<PostCategory>> _categories =
      Rx<List<PostCategory>>(<PostCategory>[
    PostCategory.defaultPostCategory(),
    PostCategory.defaultPostCategory(),
    PostCategory.defaultPostCategory()
  ]);

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

  final Rx<User> _admin = User.defaultUser().obs;
  User get admin => _admin.value;

  @override
  void onInit() async {
    super.onInit();
    await fetchData();
    _isLoading.value = false;
  }

  Future<void> fetchData() async {
    try {
      await Future.wait([
        fetchPost(),
        fetchCategory(),
        fetchSuperAdmin(),
      ]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchPost() async {
    await _apiService
        .get("${ApiConst.POSTS_ENDPOINT}?per_page=50")
        .then((response) {
      print(response.body['success']);
      if (response.body['success']) {
        List<dynamic> posts =
            List<dynamic>.from(response.body['data']['posts']);
        _listNews.value = posts.map((post) => Post.fromJson(post)).toList();

        _newsOfTheDay.value = listNews[0];
        _breakingNews.value = listNews.sublist(1, 10).toList();
      }
    });
  }

  Future<void> fetchCategory() async {
    await _apiService.get(ApiConst.CATEGORIES_ENDPOINT).then((response) {
      if (response.body['success']) {
        List<dynamic> listCategories =
            List<dynamic>.from(response.body['data']);
        _categories.value = listCategories
            .map((category) => PostCategory.fromJson(category))
            .toList();
      }
    });
  }

  Future<void> fetchSuperAdmin() async {
    await _apiService.get(ApiConst.USER_SUPER_ADMIN_ENDPOINT).then((response) {
      if (response.body['success']) {
        _admin.value = User.fromJson(response.body['data']['user']);
      }
    });
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
