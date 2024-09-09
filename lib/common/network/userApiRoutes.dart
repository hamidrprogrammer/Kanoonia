import 'package:kanooniha/common/network/NetworkConsts.dart';

class UserApiRoutes {
  static const register = '${NetworkConsts.BasePath}/RegisterUser';
  static const login = '${NetworkConsts.BasePath}/LoginUser';
  static const validateUser = '${NetworkConsts.BasePath}/ValidateUser';
  static const forgetPassword = '${NetworkConsts.BasePath}/ForgetPassword';
  static const getVersion = '${NetworkConsts.BasePath}/GetVersion';
  static const getPopupMessages = '${NetworkConsts.BasePath}/GetPopupMessages';
  static const setPopupSeen = '${NetworkConsts.BasePath}/SetPopupSeen';
  static const getUserData = '/api/data/UserData';
}
