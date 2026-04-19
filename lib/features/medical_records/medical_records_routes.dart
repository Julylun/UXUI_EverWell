import 'package:go_router/go_router.dart';

import '../../app/router/routes.dart';
import 'presentation/pages/medical_record_attachments_page.dart';
import 'presentation/pages/medical_record_detail_page.dart';
import 'presentation/pages/medical_records_list_page.dart';

/// WS-C routes — C3 bộ lọc dùng bottom sheet trong [MedicalRecordsListPage].
List<RouteBase> buildMedicalRecordsRoutes() {
  return [
    GoRoute(
      path: '/medical-records/:recordId/attachments',
      builder: (context, state) {
        final id = state.pathParameters['recordId']!;
        return MedicalRecordAttachmentsPage(recordId: id);
      },
    ),
    GoRoute(
      path: '/medical-records/:recordId',
      builder: (context, state) {
        final id = state.pathParameters['recordId']!;
        return MedicalRecordDetailPage(recordId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.medicalRecordsList,
      builder: (context, state) => const MedicalRecordsListPage(),
    ),
  ];
}
