import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_clone/data/logic/cubits/user_state.dart';
import 'package:my_clone/data/model/users_model.dart';
import 'package:my_clone/data/repository/users_repo.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoadingState()) {
    fetchUser();
  }

  UsersRepo usersRepo = UsersRepo();

  void fetchUser() async {
    try {
      List<UserModel> users = await usersRepo.fetchUserData();
      emit(UserLoadedState(users: users));
    } catch (ex) {
      emit(UserErrorState(error: ex.toString()));
    }
  }
}
