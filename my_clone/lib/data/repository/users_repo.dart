import 'package:dio/dio.dart';
import 'package:my_clone/data/model/users_model.dart';
import 'package:my_clone/data/repository/api/api.dart';

class UsersRepo {
  Api api = Api();

  Future<List<UserModel>> fetchUserData() async {
    try {
      Response response = await api.sendRequest.get('/user.json');
      // print(response.data.toString());
      List<dynamic> usersInfo = response.data;
      return usersInfo.map((user) => UserModel.fromJson(user)).toList();
    } catch (ex) {
      throw ex;
    }
  }
}
