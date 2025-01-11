import 'package:app_painel_hortifruti_pratico/app/data/models/user.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_profile_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class UserProfileRepository {
  final Api _api;

  UserProfileRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> putUser(UserProfileRequestModel userProfileRequest) =>
      _api.putUser(userProfileRequest);
}
