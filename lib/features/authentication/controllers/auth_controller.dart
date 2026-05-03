import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petzy_optimized/routes/app_routes.dart';
import '../data/models/user_model.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  // ── Country codes ──
  static const List<Map<String, String>> countryCodes = [
    {'flag': '🇺🇸', 'code': '+1', 'name': 'United States'},
    {'flag': '🇬🇧', 'code': '+44', 'name': 'United Kingdom'},
    {'flag': '🇰🇷', 'code': '+82', 'name': 'South Korea'},
    {'flag': '🇯🇵', 'code': '+81', 'name': 'Japan'},
    {'flag': '🇨🇳', 'code': '+86', 'name': 'China'},
    {'flag': '🇮🇳', 'code': '+91', 'name': 'India'},
    {'flag': '🇧🇩', 'code': '+880', 'name': 'Bangladesh'},
    {'flag': '🇦🇺', 'code': '+61', 'name': 'Australia'},
    {'flag': '🇨🇦', 'code': '+1', 'name': 'Canada'},
    {'flag': '🇩🇪', 'code': '+49', 'name': 'Germany'},
    {'flag': '🇫🇷', 'code': '+33', 'name': 'France'},
    {'flag': '🇧🇷', 'code': '+55', 'name': 'Brazil'},
    {'flag': '🇸🇦', 'code': '+966', 'name': 'Saudi Arabia'},
    {'flag': '🇦🇪', 'code': '+971', 'name': 'UAE'},
  ];

  final selectedCountryCode = '+1'.obs;
  final selectedCountryFlag = '🇺🇸'.obs;

  // ── Login ──
  final phoneController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final isLoginLoading = false.obs;

  // ── OTP ──
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());
  final isOtpLoading = false.obs;

  // ── Signup ──
  final fullNameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final signupPhoneController = TextEditingController();
  final locationController = TextEditingController();
  final postalCodeController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();
  final isSignupLoading = false.obs;
  final profileImagePath = Rxn<String>();
  final coverImagePath = Rxn<String>();

  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  // ── Country picker ──
  void showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView.builder(
        itemCount: countryCodes.length,
        itemBuilder: (_, i) {
          final c = countryCodes[i];
          return ListTile(
            leading: Text(c['flag']!, style: const TextStyle(fontSize: 24)),
            title: Text(c['name']!),
            trailing: Text(
              c['code']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              selectedCountryCode.value = c['code']!;
              selectedCountryFlag.value = c['flag']!;
              Get.back();
            },
          );
        },
      ),
    );
  }

  // ── OTP ──
  void onOtpDigitChanged(String value, int index, BuildContext context) {
    if (value.length == 1 && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  String get fullOtp => otpControllers.map((c) => c.text).join();

  // ── Actions ──
  void login() {
    if (!loginFormKey.currentState!.validate()) return;
    isLoginLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoginLoading.value = false;
      Get.toNamed(AppRoute.verificationScreen);
    });
  }

  void verifyOtp() {
    if (fullOtp.length < 4) {
      Get.snackbar(
        'Error',
        'Please enter all 4 digits',
        backgroundColor: const Color(0xFFFFE0E0),
      );
      return;
    }
    isOtpLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isOtpLoading.value = false;
      Get.toNamed(AppRoute.signupScreen);
    });
  }

  void resendOtp() {
    for (final c in otpControllers) {
      c.clear();
    }
    otpFocusNodes[0].requestFocus();
    Get.snackbar('Sent', 'A new code has been sent to your phone number');
  }

  void continueSignup() {
    if (!signupFormKey.currentState!.validate()) return;
    isSignupLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isSignupLoading.value = false;
      Get.offAllNamed(AppRoute.bottomNavScreen);
    });
  }

  void loginWithKakao() {}
  void loginWithNaver() {}
  void loginWithGoogle() {}

  @override
  void onClose() {
    phoneController.dispose();
    fullNameController.dispose();
    bioController.dispose();
    emailController.dispose();
    signupPhoneController.dispose();
    locationController.dispose();
    postalCodeController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in otpFocusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}
