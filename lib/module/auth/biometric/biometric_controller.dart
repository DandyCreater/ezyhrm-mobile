import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_screen.dart';

class BiometricC extends Bindings {
  static const route = '/biometric';
  static final page = GetPage(
    name: route,
    page: () => BiometricScreen(),
    binding: BiometricC(),
  );

  @override
  void dependencies() {
    Get.lazyPut<BiometricController>(() => BiometricController());
  }
}

class BiometricController extends GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;

  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _localAuth.canCheckBiometrics;
    } catch (e) {
      print(e);
      return;
    }
    if (!canCheckBiometrics) {
      return;
    }
    List<BiometricType> availableBiometrics =
        await _localAuth.getAvailableBiometrics();

    print('Available biometrics: $availableBiometrics');
  }

  Future<void> authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      isAuthenticated.value = authenticated;
      if (authenticated) {
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
