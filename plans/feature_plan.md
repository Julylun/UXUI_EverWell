# Kế hoạch feature & màn hình — song song agent

Mục tiêu: chia việc theo **domain độc lập** để nhiều agent/code parallel ít đụng file; mỗi task gắn **link Figma (Dev Mode)** dùng được với MCP Figma trong Cursor.

## Ngữ cảnh MCP Figma

| Tham số | Giá trị |
|---------|---------|
| **File key** | `vnowI58w60vDikzzDSaex5` |
| **Section thiết kế (cha)** | Node `792:7519` — *High - fidelity* |
| **Server MCP (Cursor)** | `plugin-figma-figma` |
| **Tool khuyến nghị khi code UI** | `get_design_context` — tham số `fileKey`, `nodeId` (dạng `792:7520` hoặc `792-7520` tùy schema), `clientLanguages=dart`, `clientFrameworks=flutter` |
| **Tool tổng quan cấu trúc** | `get_metadata` — cùng `fileKey` + `nodeId` |

**Quy ước link (mở browser / copy cho agent):**  
`https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=<ID>&m=dev`  
Trong đó `<ID>` = node Figma với **`:` thay bằng `-`** (ví dụ `792:7520` → `792-7520`).

**Link section cha (toàn bộ board):**  
https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7519&m=dev

---

## Tổng quan

- **89 màn hình** (frame cấp 1) trong section trên.  
- **12 workstream** đề xuất bên dưới; agent nhận 1 workstream + gọi MCP theo từng `node-id` tương ứng.

---

## Quy tắc làm việc song song

1. **Một agent = một domain** (hoặc một nhánh con nếu domain quá lớn: ví dụ chỉ `03_medication` hoặc chỉ `06_telehealth`).  
2. Trước khi implement UI: gọi **`get_design_context`** với đúng `nodeId` của màn hình trong bảng dưới.  
3. **Shared UI** (header, tab bar, button system): thống nhất 1 agent hoặc 1 PR đầu tiên; các agent khác chờ hoặc dùng placeholder có contract rõ.  
4. **Điều hướng / route**: một agent chủ `go_router` (hoặc router hiện tại) merge trước; các agent khác chỉ thêm route theo namespace domain.  
5. Hai frame **Frame 301** / **Frame 302**: gắn nhãn *chưa rõ nghiệp vụ* — ưu tiên hỏi design trước khi code.

---

## Bảng plan theo workstream

### WS-A — Onboarding & Auth (`00_onboarding_auth`)

| # | Màn hình (Figma) | `nodeId` | Link MCP / Figma |
|---|------------------|----------|------------------|
| A1 | Welcome | `806:4609` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4609&m=dev |
| A2 | Login: Ready to use | `806:4620` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4620&m=dev |
| A3 | Login | `806:4631` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4631&m=dev |
| A4 | Forget Password: New passsword | `806:4642` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4642&m=dev |
| A5 | Login: New Personal Information | `806:4652` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4652&m=dev |
| A6 | Login: Choose Avatar | `806:4669` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4669&m=dev |
| A7 | Login: Import EMRs successfully | `806:4679` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4679&m=dev |
| A8 | Login: New Personal Information by NFC | `806:4689` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4689&m=dev |
| A9 | Login: Scan successfully | `806:4699` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4699&m=dev |
| A10 | Login: Scaning NFC | `806:4709` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4709&m=dev |
| A11 | Login: Import EMRs | `806:4719` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4719&m=dev |
| A12 | Forget Password: Email | `806:4730` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4730&m=dev |
| A13 | Register: Successful | `806:4740` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4740&m=dev |
| A14 | Register: information | `806:4748` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4748&m=dev |
| A15 | Register: OTP | `806:4761` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4761&m=dev |
| A16 | Forget Password: OTP | `806:4768` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-4768&m=dev |

**Gợi ý deliverable:** luồng auth + onboarding + import EMR/NFC; test widget từng bước; không chồng lên `10_settings`.

---

### WS-B — Home (`01_home`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| B1 | Trang chủ | `806:11044` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-11044&m=dev |

**Gợi ý deliverable:** dashboard, quick access, section lịch thuốc / hồ sơ gần đây; phụ thuộc navigation chung.

---

### WS-C — Hồ sơ khám (`02_medical_records`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| C1 | Hồ sơ khám bệnh | `806:10937` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10937&m=dev |
| C2 | Chi tiết hồ sơ | `806:10716` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10716&m=dev |
| C3 | Bộ lọc hồ sơ | `806:10811` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10811&m=dev |
| C4 | Tài liệu đính kèm | `806:10601` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10601&m=dev |

---

### WS-D — Thuốc & nhắc nhở (`03_medication`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| D1 | Đơn thuốc | `806:10493` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10493&m=dev |
| D2 | Đơn thuốc đã kết thúc | `806:10419` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10419&m=dev |
| D3 | Chi tiết đơn thuốc | `806:10278` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10278&m=dev |
| D4 | Thêm đơn thuốc | `806:10237` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10237&m=dev |
| D5 | Tạo lịch nhắc nhở | `806:10075` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-10075&m=dev |
| D6 | Thêm vào tủ thuốc | `806:9913` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9913&m=dev |
| D7 | Tủ thuốc | `806:9817` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9817&m=dev |
| D8 | Chọn cách thêm | `806:9760` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9760&m=dev |
| D9 | Nhập thông tin thuốc | `806:9665` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9665&m=dev |
| D10 | Chi tiết thuốc | `806:9591` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9591&m=dev |
| D11 | Chỉnh sửa thuốc | `806:9506` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9506&m=dev |
| D12 | Lịch nhắc nhở | `806:9390` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9390&m=dev |
| D13 | Cài đặt nhắc nhở | `806:9232` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9232&m=dev |
| D14 | Lịch sử tuân thủ | `806:9062` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9062&m=dev |
| D15 | Xác nhận uống thuốc | `806:9031` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-9031&m=dev |

---

### WS-E — Theo dõi sức khỏe (`04_health_tracking`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| E1 | Nhịp tim/Nhập nhịp tim | `806:6741` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-6741&m=dev |
| E2 | Chi tiết Nhịp tim | `806:7695` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7695&m=dev |
| E3 | Giấc ngủ | `806:6861` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-6861&m=dev |
| E4 | Giấc ngủ/Nhập giấc ngủ | `806:7050` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7050&m=dev |
| E5 | Vận động | `806:7211` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7211&m=dev |
| E6 | Vận động/Nhập vận động | `806:7406` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7406&m=dev |
| E7 | Nhập nhanh | `806:7545` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7545&m=dev |

---

### WS-F — Đồng bộ thiết bị (`05_device_sync`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| F1 | Kết nối thiết bị | `806:7876` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7876&m=dev |
| F2 | Kết nối thiết bị/Danh sách thiết bị | `806:8120` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-8120&m=dev |
| F3 | Kết nối thiết bị/Trạng thái | `806:7984` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-7984&m=dev |
| F4 | Trạng thái trống & Lỗi đồng bộ | `806:8273` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=806-8273&m=dev |

---

### WS-G — Telehealth & BS (`06_telehealth`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| G1 | List Dr | `792:7532` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7532&m=dev |
| G2 | Search | `792:7894` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7894&m=dev |
| G3 | Filter | `792:8175` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8175&m=dev |
| G4 | Profile Dr - Info | `792:7922` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7922&m=dev |
| G5 | Profile Dr - Review | `792:7988` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7988&m=dev |
| G6 | Profile Dr - Appointment | `792:8079` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8079&m=dev |
| G7 | Video Call | `792:7520` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7520&m=dev |
| G8 | Waiting room | `792:7748` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7748&m=dev |
| G9 | Chat | `792:7850` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7850&m=dev |
| G10 | Chat (variant) | `792:8421` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8421&m=dev |
| G11 | Upload file | `792:8356` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8356&m=dev |
| G12 | Review | `792:7806` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7806&m=dev |
| G13 | Call ended | `792:8508` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8508&m=dev |

---

### WS-H — Lịch hẹn (`07_appointments`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| H1 | Appointment upcoming | `792:7579` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7579&m=dev |
| H2 | Appointment completed | `792:7562` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7562&m=dev |
| H3 | Appointment cancelled | `792:7544` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7544&m=dev |
| H4 | Appointment detail | `792:7597` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7597&m=dev |
| H5 | Appointment cancel | `792:8305` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8305&m=dev |

---

### WS-I — Thanh toán (`08_payments`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| I1 | Payment | `792:7640` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7640&m=dev |
| I2 | Enter your PIN | `792:7664` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7664&m=dev |
| I3 | Add new card | `792:7682` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7682&m=dev |
| I4 | Review Summary | `792:7713` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7713&m=dev |
| I5 | Failed | `792:8214` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8214&m=dev |
| I6 | Congratulations | `792:8256` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-8256&m=dev |

---

### WS-J — AI Insights (`09_ai_insights`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| J1 | AI Insights/Main | `791:4568` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4568&m=dev |
| J2 | AI Insight/Health suggestions | `791:4639` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4639&m=dev |
| J3 | AI Insight/Habit analysis | `791:4701` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4701&m=dev |
| J4 | AI Insight/Chatting | `791:4801` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4801&m=dev |
| J5 | AI Insight/Chatting History | `791:4811` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4811&m=dev |

---

### WS-K — Settings (`10_settings`)

| # | Màn hình | `nodeId` | Link |
|---|----------|----------|------|
| K1 | Settings/Main | `791:4840` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4840&m=dev |
| K2 | Settings/Select language | `791:4856` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4856&m=dev |
| K3 | Settings/Account | `791:4877` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4877&m=dev |
| K4 | Settings/Account/Confirm Delete Account | `791:4921` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4921&m=dev |
| K5 | Settings/Privacy | `791:4966` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4966&m=dev |
| K6 | Settings/Privacy/Remove Data Confirm | `791:4979` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-4979&m=dev |
| K7 | Settings/Devices | `791:5001` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-5001&m=dev |
| K8 | Settings/New Device | `791:5011` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-5011&m=dev |
| K9 | Settings/Device Detail | `791:5020` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-5020&m=dev |
| K10 | Settings/New Device/Enter Pair Code | `791:5038` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-5038&m=dev |
| K11 | Settings/Account/Change Password | `791:5048` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=791-5048&m=dev |

---

### WS-L — Misc / Wireframe (`99_misc_wireframes`)

| # | Màn hình | `nodeId` | Link | Ghi chú |
|---|----------|----------|------|---------|
| L1 | Frame 301 | `816:4057` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=816-4057&m=dev | Chưa đặt tên nghiệp vụ |
| L2 | Frame 302 | `816:4058` | https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=816-4058&m=dev | Chưa đặt tên nghiệp vụ |

---

## Checklist nhanh cho agent

- [ ] Lấy design: `get_design_context` với `fileKey=vnowI58w60vDikzzDSaex5` và `nodeId` đúng cột bảng.  
- [ ] Đối chiếu tên frame Figma với route / tên file Dart trong module domain.  
- [ ] Sau khi merge shared components, rebase và đồng bộ theme/spacing.

---

*Tài liệu sinh tự động từ metadata Figma (MCP `get_metadata`), node gốc `792:7519`, ngày cập nhật theo phiên làm việc repo.*
