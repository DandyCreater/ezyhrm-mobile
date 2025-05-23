class AppAssetConstant {
  static const appLogo = 'appLogo';
  static const appLogoIntPath = 'assets/svgs/logo.svg';

  static const vectorSplash = 'vectorSplash';
  static const vectorSplashIntPath = 'assets/images/vectorSplash.png';

  static const notAvailable = 'notAvailable';
  static const notAvailableIntPath = 'assets/images/img_empty.png';

  static const auth = 'auth';
  static const authIntPath = 'assets/images/logo_signup.png';

  static const login = 'login';
  static const loginIntPath = 'assets/images/logo_login.png';
}

enum AppAssetEnum {
  appLogoImg(AppAssetConstant.appLogo, AppAssetConstant.appLogoIntPath),
  vectorSplashImg(
      AppAssetConstant.vectorSplash, AppAssetConstant.vectorSplashIntPath),
  notAvailableImg(
      AppAssetConstant.notAvailable, AppAssetConstant.notAvailableIntPath),
  authImg(AppAssetConstant.auth, AppAssetConstant.authIntPath),
  loginImg(AppAssetConstant.login, AppAssetConstant.loginIntPath);

  final String name;
  final String pathDefault;

  const AppAssetEnum(this.name, this.pathDefault);
}
