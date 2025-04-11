import 'package:my_clone/data/model/users_model.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState({required this.users});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({required this.error});
}
