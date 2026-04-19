/// Central route paths (WS-A uses `/auth/*` and `/onboarding/*`).
abstract final class AppRoutes {
  static const welcome = '/welcome';

  static const authLoginReady = '/auth/login-ready';
  static const authLogin = '/auth/login';
  static const authRegister = '/auth/register';
  static const authRegisterOtp = '/auth/register/otp';
  static const authRegisterSuccess = '/auth/register/success';
  static const authForgotEmail = '/auth/forgot/email';
  static const authForgotOtp = '/auth/forgot/otp';
  static const authForgotNewPassword = '/auth/forgot/new-password';

  static const onboardingPersonalInfo = '/onboarding/personal-info';
  static const onboardingAvatar = '/onboarding/avatar';
  static const onboardingImportEmr = '/onboarding/import-emr';
  static const onboardingImportEmrSuccess = '/onboarding/import-emr/success';
  static const onboardingNfcInfo = '/onboarding/nfc-info';
  static const onboardingNfcScan = '/onboarding/nfc-scan';
  static const onboardingNfcSuccess = '/onboarding/nfc-success';

  /// WS-B — Home / dashboard ([plans/feature_plan.md] B1, node `806:11044`).
  static const home = '/home';

  /// WS-C — Hồ sơ khám (C1 `806:10937`).
  static const medicalRecordsList = '/medical-records';

  /// WS-C — Chi tiết (C2 `806:10716`).
  static String medicalRecordDetail(String recordId) =>
      '/medical-records/$recordId';

  /// WS-C — Tài liệu đính kèm (C4 `806:10601`).
  static String medicalRecordAttachments(String recordId) =>
      '/medical-records/$recordId/attachments';

  // WS-D — Medication & reminders (D1..D15).
  static const medicationPrescriptions = '/medication/prescriptions';
  static const medicationPrescriptionsCompleted =
      '/medication/prescriptions/completed';
  static const medicationPrescriptionDetail =
      '/medication/prescriptions/detail';
  static const medicationAddPrescription = '/medication/prescriptions/add';
  static const medicationCreateReminder = '/medication/reminders/create';
  static const medicationAddToCabinet = '/medication/cabinet/add-from-rx';
  static const medicationCabinet = '/medication/cabinet';
  static const medicationChooseAddMethod = '/medication/cabinet/choose-add';
  static const medicationInputMedicine = '/medication/cabinet/input';
  static const medicationMedicineDetail = '/medication/cabinet/detail';
  static const medicationEditMedicine = '/medication/cabinet/edit';
  static const medicationReminderSchedule = '/medication/reminders/schedule';
  static const medicationReminderSettings = '/medication/reminders/settings';
  static const medicationAdherenceHistory = '/medication/reminders/adherence';
  static const medicationConfirmTaken = '/medication/reminders/confirm';

  // WS-E — Health tracking (E1..E7, phase 1 starts with E1/E2).
  static const healthHeartInput = '/health/heart/input';
  static const healthHeartDetail = '/health/heart/detail';
}
