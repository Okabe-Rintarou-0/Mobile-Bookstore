const String scheme = "http";
const String host = "47.103.71.157";
// const String host = "10.0.2.2";
const String port = "8080";
const String apiPrefix = "$scheme://$host:$port";

const bookDetailsUrl = "$apiPrefix/books/details";
const bookSnapshotUrl = "$apiPrefix/books/snapshot";
const bookRangedSnapshotsUrl = "$apiPrefix/books/snapshots";
const checkSessionUrl = "$apiPrefix/checkSession";
const registerUrl = "$apiPrefix/register";
const loginUrl = "$apiPrefix/login";
const uploadImageUrl = "$apiPrefix/upload/image";
const logoutUrl = "$apiPrefix/logout";
const userProfileUrl = "$apiPrefix/users/profile";
const staticAssetsUrl = "$apiPrefix/static";
const defaultAvatarUrl = "/static/avatar.png";

// UserExists      RegisterResult = "用户名已存在！"
// InvalidEmail    RegisterResult = "非法邮箱！"
// InvalidUsername RegisterResult = "非法用户名！"
// InvalidNickname RegisterResult = "非法昵称！"
// InvalidPassword RegisterResult = "非法密码！"
class Errors {
  static const String userExists = "用户名已存在！";
  static const String invalidEmail = "非法邮箱!";
  static const String invalidUsername = "非法用户名！";
  static const String invalidNickname = "非法昵称！";
  static const String invalidPassword = "非法密码！";
}
