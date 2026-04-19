# Kiến trúc & hướng dẫn chung — EverWell (Flutter)

Tài liệu này là **nguồn chuẩn** trước khi mở rộng code app. Nó bám `docs/feature/tree.md` (cây domain Figma) và `plans/feature_plan.md` (workstream song song, node-id, MCP Figma).

**Chuẩn tham chiếu thêm:** skill `.agents/skills/flutter-architecting-apps/SKILL.md` (tách lớp UI / Logic / Data, ViewModel, Repository + Service). **Mục 12** dưới đây phân tích khớp/lệch và hàm ý cho EverWell.

---

## 1. Mục tiêu & phạm vi

| Mục | Quyết định |
|-----|------------|
| **Nền tảng** | Flutter đa nền tảng; **ưu tiên Android** (thiết bị thật, kích thước màn hình, gesture, performance). |
| **Giai đoạn hiện tại** | **Chỉ logic giao diện**: layout, điều hướng, trạng thái UI cục bộ, **dữ liệu mock** trong app hoặc fixture — **không** tích hợp backend/API thật. |
| **Nguồn UI** | Figma *Mobile App* — High fidelity; chi tiết màn hình và `node-id` trong `feature_plan.md`. |
| **Làm việc song song** | Chia theo **domain** để nhiều người/agent ít đụng file; quy tắc cụ thể ở mục 7. |

---

## 2. Nguyên tắc kiến trúc (giai đoạn UI-only)

Căn chỉnh với skill **flutter-architecting-apps**: *Separation of Concerns*, **SSOT** cho dữ liệu nghiệp vụ ở tầng Data (Repository), **luồng dữ liệu một chiều** (sự kiện từ UI → ViewModel → Repository/Service; state từ Repository/ViewModel xuống View), và coi **UI là hàm của state** (ưu tiên object state bất biến hoặc ít nhất snapshot rõ ràng cho `build`).

1. **Feature theo domain** — Mỗi nhánh Figma (`00_onboarding_auth` … `10_settings`, `99_misc_wireframes`) map 1 module `lib/features/<tên_snake>/`.
2. **Phụ thuộc một chiều** — `features` → `core` / `app`; **không** import ngược feature này sang feature kia. Giao tiếp giữa domain qua **router**, **callback/interface nhỏ**, hoặc **event bus** chỉ khi thật cần (mặc định tránh).
3. **Tách lớp trong feature** (khớp skill; làm dần nhưng **hướng về** cấu trúc này):
   - **`presentation/`** — **View** (widget “nhẹ”: layout, điều hướng cục bộ, animation) tách khỏi **ViewModel** (trạng thái màn hình, lệnh user, gọi repository). *Không* nhét fetch/mock phức tạp trực tiếp trong cây widget.
   - **`domain/`** — Model bất biến (`User`, `Prescription`, …); **Use case / Interactor** *chỉ khi* luồng nghiệp vụ client phức tạp (nhiều repository). App CRUD/đơn giản: ViewModel có thể gọi Repository trực tiếp (theo skill).
   - **`data/`** — **Service**: một class **stateless** / **một nguồn** (HTTP sau này, DB, plugin); hiện tại dùng `MockXxxService` hoặc đọc fixture. **Repository**: SSOT + cache/retry sau này; map raw → domain model; ViewModel chỉ thấy Repository (hoặc Use case), không thấy HTTP trần.
4. **`app/`** — `MaterialApp` / router, theme, localization bootstrap; **một** chỗ cấu hình điều hướng gốc.
5. **`core/`** — Theme extension, spacing, typography helpers, widget dùng chung (button, app bar, empty state), `AppRoutes` / tên route hằng số, `Result`/error type nếu cần.

**Giai đoạn UI-only:** vẫn nên có **`domain/` (model)** + **`data/` (mock Service + Repository)** sớm cho feature “có danh sách / form”, để đổi sang API thật không đụng ViewModel contract. Màn hình static đơn giản có thể tạm chỉ có View + ViewModel tối thiểu, nhưng tránh để logic lan ra Widget không có ViewModel.

---

## 3. Cấu trúc thư mục `lib/` (đề xuất)

Ánh xạ **12 domain** từ `tree.md` sang tên thư mục **snake_case** (bỏ tiền tố số Figma trong tên folder để code sạch; giữ mapping trong bảng dưới).

```text
lib/
├── main.dart
├── app/
│   ├── everwell_app.dart          # MaterialApp.router hoặc MaterialApp
│   ├── router/
│   │   ├── app_router.dart        # go_router (hoặc Navigator 2.0) — merge có kiểm soát
│   │   └── routes.dart            # hằng số path, tránh string rải rác
│   └── theme/
│       └── app_theme.dart
├── core/
│   ├── constants/
│   ├── presentation/              # widget dùng chung toàn app
│   └── extensions/
└── features/
    ├── onboarding_auth/           # 00_onboarding_auth
    ├── home/                      # 01_home
    ├── medical_records/           # 02_medical_records
    ├── medication/                # 03_medication
    ├── health_tracking/           # 04_health_tracking
    ├── device_sync/               # 05_device_sync
    ├── telehealth/                # 06_telehealth
    ├── appointments/              # 07_appointments
    ├── payments/                  # 08_payments
    ├── ai_insights/               # 09_ai_insights
    ├── settings/                  # 10_settings
    └── misc_wireframes/           # 99_misc_wireframes
```

Trong mỗi `features/<domain>/`:

```text
presentation/
├── pages/              # màn hình full-page (map frame Figma → route)
├── view_models/        # trạng thái + lệnh; bind View (ChangeNotifier / Notifier / Cubit…)
└── widgets/            # widget chỉ dùng trong domain (không chứa nghiệp vụ nặng)
domain/
└── models/             # (và use_cases/ nếu cần) — Dart thuần, không import flutter
data/
├── services/           # 1 service / nguồn dữ liệu; mock = implementation giả
└── repositories/       # SSOT domain trong feature; gọi Service(s)
```

**Quy ước đặt tên file Dart:** `snake_case.dart`; class `PascalCase`; màn hình có thể hậu tố `*_page.dart`.

---

## 4. Điều hướng & route

- Khuyến nghị **`go_router`**: dễ chia **sub-route theo domain** (`ShellRoute` cho bottom bar sau này).
- **Một PR/agent chủ** merge khung router trước; domain khác chỉ **thêm** `GoRoute` trong namespace path riêng (ví dụ `/medication/...`) để giảm conflict.
- Mỗi màn hình Figma trong `feature_plan.md` sau khi implement nên có **comment** hoặc **tên route** tham chiếu `node-id` (vd. `806:11044`) để đối chiếu Dev Mode.

---

## 5. Thiết kế UI từ Figma (MCP)

Tham số và tool xem `feature_plan.md`. Tóm tắt:

- **`get_design_context`**: `fileKey`, `nodeId`, `clientLanguages=dart`, `clientFrameworks=flutter`.
- **Link browser**: `node-id` dùng dấu `-` thay `:`.

Trước khi code một màn hình: gọi đúng `nodeId` trong bảng workstream tương ứng.

**Frame 301 / Frame 302** (`99_misc_wireframes`): coi là *chưa rõ nghiệp vụ* — không map route production cho đến khi design xác nhận.

---

## 6. Phát triển trên điện thoại (Android-first)

1. Bật **USB debugging**; cài driver nếu cần; `flutter devices` phải thấy máy.
2. Chạy: `flutter run -d <device_id>` — ưu tiên **profile** hoặc **release** khi đo hiệu năng: `flutter run --profile`.
3. **Wireless debugging** (Android 11+): `adb pair` / `adb connect` rồi `flutter run` như thiết bị mạng.
4. Giữ **minSdk / targetSdk** cập nhật theo `android/app/build.gradle.kts` khi team thống nhất.
5. Kiểm tra **safe area**, notch, **keyboard insets**, và cỡ chữ hệ thống (accessibility) trên máy thật.

iOS vẫn có thể build để đảm bảo không gãy compile đa nền tảng; **QA chính** theo Android.

---

## 7. Làm việc song song (agent / dev nhiều nhánh)

Trích từ `feature_plan.md`, củng cố tại đây:

1. **Một agent (hoặc một dev) = một domain** (hoặc nhánh con nếu domain quá lớn, ví dụ chỉ `telehealth`).
2. **Shared UI** (design system, nút, app bar, bottom nav): **một** luồng merge trước; các nhánh khác dùng placeholder có **contract** rõ (tên widget + tham số) nếu chưa có asset.
3. **Router**: một chủ merge khung; các domain chỉ thêm route trong vùng được phân.
4. Sau khi có thay đổi theme/spacing chung: **rebase** và đồng bộ lại feature.

---

## 8. Trạng thái & dữ liệu (không backend)

- **ViewModel** (hoặc tương đương: `Notifier`, `Cubit`, `AsyncNotifier`…) nắm trạng thái *presentation* (loading, lỗi, selection); **Repository** nắm SSOT *dữ liệu nghiệp vụ* đã chuẩn hoá (theo skill). Tránh để cả hai trộn vào Widget lớn.
- **`ChangeNotifier` + `ListenableBuilder`** hoặc **Riverpod / Bloc** — thống nhất **một** stack khi bắt đầu code nghiêm túc; skill minh hoạ `ChangeNotifier` nhưng không bắt buộc.
- **Mock theo đúng tầng Data:** `MockMedicationService` (implements abstract service hoặc thay thế inject) trả JSON/fixture; `MedicationRepository` vẫn map → `domain` model như bản production. Có thể thêm `data/mock/` cho fixture dùng chung.
- **Không** hardcode URL API hay secret trong repo.

---

## 9. Kiểm thử & chất lượng

- **Unit test** cho Service (mock HTTP), Repository (map + cache behavior), ViewModel (state transitions) — đúng vòng lặp skill: sửa logic → chạy lại test.
- **Widget test** cho View (bind ViewModel giả / snapshot state).
- **`flutter analyze`** và rule trong `analysis_options.yaml` phải xanh trên CI khi có.
- **Golden test** (tuỳ chọn) cho component cố định sau khi design system ổn định.

---

## 10. Tài liệu liên quan trong repo

| File | Vai trò |
|------|---------|
| `docs/feature/tree.md` | Cây domain + tên màn hình Figma theo domain. |
| `plans/feature_plan.md` | Workstream, `node-id`, link Dev Mode, checklist agent. |
| `plans/architecture.md` | **Bản này** — kiến trúc, folder, quy trình, Android-first, UI-only. |

---

## 11. Thứ tự triển khai gợi ý (khi bắt đầu code app)

Theo vòng **feature** trong `feature_plan.md`, lồng workflow skill (rút gọn khi màn hình chỉ static):

1. Khởi tạo / chỉnh `pubspec`, `analysis_options`, theme tối thiểu trong `app/theme/`.
2. Cài **`go_router`**, `routes.dart` + `app_router.dart` với ít route (splash → shell/home).
3. **`core/presentation`**: design system tối thiểu (spacing, nút, app bar).
4. Với **mỗi** màn hình / luồng có dữ liệu hoặc validation:
   - Định nghĩa **domain model** (bất biến) nếu chưa có.
   - **Service** mock (hoặc service đọc asset) → **Repository** → **ViewModel** → **View (page)**.
5. Màn hình **chỉ layout**: vẫn có ViewModel mỏng hoặc stateless page + widget tách file để đồng nhất cấu trúc.
6. **Test:** unit (Repository/ViewModel) + widget (View); `flutter analyze` xanh.
7. **Khi có backend:** thêm `XxxApiService` thật, giữ interface Repository; đổi DI wiring, hạn chế đổi ViewModel.

---

## 12. Đối chiếu skill `flutter-architecting-apps`

### 12.1 Điểm khớp (nên giữ)

| Skill | EverWell (`architecture.md`) |
|--------|-------------------------------|
| Tách UI vs logic điều phối | `presentation` = View + ViewModel; widget không ôm nghiệp vụ nặng. |
| Data = Repository (SSOT) + Service (nguồn ngoài, stateless) | `data/repositories` + `data/services`; mock = service giả. |
| Logic layer tuỳ độ phức tạp | `domain/use_cases` khi cần; không bắt buộc mọi feature. |
| Luồng một chiều, UI phụ thuộc state | ViewModel/Repository đẩy state xuống View; sự kiện đi lên. |
| Quy trình: model → data → VM → view → test | Mục 11; mục 9 bổ sung unit test đúng skill. |

### 12.2 Ưu / nhược khi áp dụng skill cho EverWell

**Ưu điểm**

- **Đổi mock → API** chủ yếu ở Service (+ mapper nhỏ), ViewModel ổn định → phù hợp giai đoạn “UI trước, backend sau”.
- **Test tách lớp** rõ: Repository/ViewModel không cần `WidgetTester` nặng.
- **Song song domain** vẫn ổn: mỗi feature bọc Service/Repository riêng, ít đụng `core` nếu contract rõ.

**Nhược điểm / chi phí**

- Nhiều file hơn cho màn hình đơn giản (đúng trade-off skill).
- Team phải thống nhất **một** kiểu ViewModel/state; nếu không, một số màn hình sẽ “rò” logic vào `StatefulWidget`.
- Skill ví dụ `ChangeNotifier` + field mutable; với immutable state + codegen (freezed, v.v.) cần quy ước thêm ngoài skill — ghi ở repo khi chốt.

### 12.3 Chênh lệch trước đây (đã chỉnh trong bản này)

- Trước: gợi ý “chỉ `presentation` + mock” có thể hiểu nhầm là mock trong widget. **Đã** chuyển sang mock tại **Service**, Repository làm SSOT domain.
- Trước: chưa tách **ViewModel** vs **page/widget**; **đã** tách rõ trong mục 2–3.
- Trước: mục 9 nhấn widget test; **đã** bổ sung unit test theo skill.

### 12.4 Đề xuất tiếp (ngoài file này, khi code)

- Thêm `doc` hoặc `README` ngắn trong repo: **package state** đã chọn + mẫu 1 feature hoàn chỉnh (medication hoặc home) làm “golden sample”.
- Abstract `*Service` / `*Repository` bằng `abstract class` hoặc typedef inject để test và mock dễ swap.

---

*Tài liệu kiến trúc chung; căn skill `.agents/skills/flutter-architecting-apps/SKILL.md`; cập nhật khi team chốt stack state management và chiến lược iOS release.*
