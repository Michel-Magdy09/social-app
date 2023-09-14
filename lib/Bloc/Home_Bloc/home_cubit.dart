import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/user_model.dart';
import '../../Shared/Network/Local/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where("uId", isEqualTo: CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      userModel = value.docs.map((e) => UserModel.fromSnapshot(e)).single;
      print(userModel?.uId);
      print(userModel?.email);
      print(userModel?.isEmailVerified);
      print(userModel?.name);
      print(userModel?.phone);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }
}
