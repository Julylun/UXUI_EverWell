import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import 'presentation/pages/choose_avatar_page.dart';
import 'presentation/pages/forgot_password_email_page.dart';
import 'presentation/pages/forgot_password_new_password_page.dart';
import 'presentation/pages/forgot_password_otp_page.dart';
import 'presentation/pages/import_emr_page.dart';
import 'presentation/pages/import_emr_success_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/login_ready_page.dart';
import 'presentation/pages/nfc_personal_info_page.dart';
import 'presentation/pages/nfc_scan_success_page.dart';
import 'presentation/pages/nfc_scanning_page.dart';
import 'presentation/pages/personal_info_page.dart';
import 'presentation/pages/register_information_page.dart';
import 'presentation/pages/register_otp_page.dart';
import 'presentation/pages/register_success_page.dart';
import 'presentation/pages/welcome_page.dart';

/// WS-A routes only — merge from [AppRouter].
List<RouteBase> buildOnboardingAuthRoutes() {
  return [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.authLoginReady,
      builder: (context, state) => const LoginReadyPage(),
    ),
    GoRoute(
      path: AppRoutes.authLogin,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.authRegister,
      builder: (context, state) => const RegisterInformationPage(),
    ),
    GoRoute(
      path: AppRoutes.authRegisterOtp,
      builder: (context, state) => const RegisterOtpPage(),
    ),
    GoRoute(
      path: AppRoutes.authRegisterSuccess,
      builder: (context, state) => const RegisterSuccessPage(),
    ),
    GoRoute(
      path: AppRoutes.authForgotEmail,
      builder: (context, state) => const ForgotPasswordEmailPage(),
    ),
    GoRoute(
      path: AppRoutes.authForgotOtp,
      builder: (context, state) => const ForgotPasswordOtpPage(),
    ),
    GoRoute(
      path: AppRoutes.authForgotNewPassword,
      builder: (context, state) => const ForgotPasswordNewPasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingPersonalInfo,
      builder: (context, state) => const PersonalInfoPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingAvatar,
      builder: (context, state) => const ChooseAvatarPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingImportEmr,
      builder: (context, state) => const ImportEmrPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingImportEmrSuccess,
      builder: (context, state) => const ImportEmrSuccessPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingNfcInfo,
      builder: (context, state) => const NfcPersonalInfoPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingNfcScan,
      builder: (context, state) => const NfcScanningPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingNfcSuccess,
      builder: (context, state) => const NfcScanSuccessPage(),
    ),
  ];
}
