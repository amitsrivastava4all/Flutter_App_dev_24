import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_brainmentors/modules/user/cubit/user_state.dart';
import 'package:todoapp_brainmentors/modules/user/services/oauth.dart';

// Calling --> Fn Call (Push)
// Pull - Event
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  void login() async {
    // Firebase auth talk , data bring
    // data will be store in state (UserState)
    // UserState will be link to Widget (Render)
    OAuth oauth = OAuth();
    final userCred = await oauth.signInWithGoogle();
    String email = userCred!.user!.email.toString();
    String name = userCred!.user!.displayName.toString();
    String image = userCred!.user!.photoURL.toString();
    emit(UserState.fillUserInfo(email, name, image));
  }
}
