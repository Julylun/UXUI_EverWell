import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import 'presentation/pages/medication_pages.dart';

List<RouteBase> buildMedicationRoutes() {
  return [
    GoRoute(
      path: AppRoutes.medicationConfirmTaken,
      builder: (context, state) => const ConfirmTakenPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationAdherenceHistory,
      builder: (context, state) => const AdherenceHistoryPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationReminderSettings,
      builder: (context, state) => const ReminderSettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationReminderSchedule,
      builder: (context, state) => const ReminderSchedulePage(),
    ),
    GoRoute(
      path: AppRoutes.medicationEditMedicine,
      builder: (context, state) => const EditMedicinePage(),
    ),
    GoRoute(
      path: AppRoutes.medicationMedicineDetail,
      builder: (context, state) => const MedicineDetailPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationInputMedicine,
      builder: (context, state) => const InputMedicinePage(),
    ),
    GoRoute(
      path: AppRoutes.medicationChooseAddMethod,
      builder: (context, state) => const ChooseAddMethodPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationCabinet,
      builder: (context, state) => const CabinetPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationAddToCabinet,
      builder: (context, state) => const AddToCabinetPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationCreateReminder,
      builder: (context, state) => const CreateReminderPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationAddPrescription,
      builder: (context, state) => const AddPrescriptionPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationPrescriptionDetail,
      builder: (context, state) => const PrescriptionDetailPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationPrescriptionsCompleted,
      builder: (context, state) => const PrescriptionCompletedPage(),
    ),
    GoRoute(
      path: AppRoutes.medicationPrescriptions,
      builder: (context, state) => const PrescriptionListPage(),
    ),
  ];
}
