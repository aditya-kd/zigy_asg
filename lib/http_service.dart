import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL as Uri);

    if (res.statusCode == 200) {
      print(res);
      print("Hello World");
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts =  body.map((dynamic item) => Post.fromJson(item),).toList();
      return posts;
    }
    else{
      print("No data retreived");
      throw "Unable to retrieve posts";
    }
  }
  Future fetchData(String url) async {
  Response response = await get(Uri.parse(url));
  return response.body;
}
}


