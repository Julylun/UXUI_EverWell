# Cây chức năng — Mobile App (Figma)

Nguồn: file Figma **Mobile App** (`vnowI58w60vDikzzDSaex5`), section **High - fidelity** (`792:7519`), lấy qua MCP `get_metadata`.

## Thống kê

| Khái niệm | Số lượng |
|-----------|----------|
| **Màn hình (frame cấp 1)** | **89** |
| **Nhóm chức năng (domain)** | **12** (xem cây bên dưới) |

> Hai frame tên generic **Frame 301** / **Frame 302** được giữ trong danh sách; nên đối chiếu lại với designer trước khi map sang route Flutter.

## Cây thư mục theo domain

```text
mobile_app/
├── 00_onboarding_auth/          # Chào mừng, đăng nhập, đăng ký, quên mật khẩu, onboarding EMR/NFC
├── 01_home/                     # Trang chủ (dashboard tổng hợp)
├── 02_medical_records/          # Hồ sơ khám, chi tiết, lọc, tài liệu đính kèm
├── 03_medication/               # Đơn thuốc, tủ thuốc, nhập thuốc, nhắc nhở, tuân thủ
├── 04_health_tracking/          # Nhịp tim, giấc ngủ, vận động, nhập nhanh, chi tiết chỉ số
├── 05_device_sync/              # Kết nối thiết bị, danh sách, trạng thái, empty/error đồng bộ
├── 06_telehealth/               # Danh sách BS, tìm kiếm, lọc, hồ sơ BS, cuộc gọi/chat/phòng chờ
├── 07_appointments/             # Lịch hẹn: sắp tới / hoàn thành / đã hủy, chi tiết, hủy lịch
├── 08_payments/                 # Thanh toán, PIN, thẻ, tóm tắt, thành công / thất bại
├── 09_ai_insights/              # AI insights: gợi ý, thói quen, chat, lịch sử chat
├── 10_settings/                 # Cài đặt: ngôn ngữ, tài khoản, quyền riêng tư, thiết bị, mật khẩu
└── 99_misc_wireframes/          # Frame 301, Frame 302 (chưa đặt tên nghiệp vụ)
```

## Chi tiết theo domain (tên màn hình trong Figma)

### `00_onboarding_auth`

- Welcome  
- Login, Login: Ready to use  
- Register: information, Register: OTP, Register: Successful  
- Forget Password: Email, Forget Password: OTP, Forget Password: New passsword  
- Login: New Personal Information, Login: Choose Avatar  
- Login: Import EMRs, Login: Import EMRs successfully  
- Login: New Personal Information by NFC, Login: Scaning NFC, Login: Scan successfully  

### `01_home`

- Trang chủ  

### `02_medical_records`

- Hồ sơ khám bệnh  
- Chi tiết hồ sơ  
- Bộ lọc hồ sơ  
- Tài liệu đính kèm  

### `03_medication`

- Đơn thuốc, Đơn thuốc đã kết thúc, Chi tiết đơn thuốc, Thêm đơn thuốc  
- Tủ thuốc, Thêm vào tủ thuốc  
- Chọn cách thêm, Nhập thông tin thuốc, Chi tiết thuốc, Chỉnh sửa thuốc  
- Tạo lịch nhắc nhở, Lịch nhắc nhở, Cài đặt nhắc nhở  
- Xác nhận uống thuốc, Lịch sử tuân thủ  

### `04_health_tracking`

- Nhịp tim/Nhập nhịp tim, Chi tiết Nhịp tim  
- Giấc ngủ, Giấc ngủ/Nhập giấc ngủ  
- Vận động, Vận động/Nhập vận động  
- Nhập nhanh  

### `05_device_sync`

- Kết nối thiết bị  
- Kết nối thiết bị/Danh sách thiết bị  
- Kết nối thiết bị/Trạng thái  
- Trạng thái trống & Lỗi đồng bộ  

### `06_telehealth`

- List Dr, Search, Filter  
- Profile Dr - Info, Profile Dr - Review, Profile Dr - Appointment  
- Video Call, Waiting room  
- Chat (2 biến thể frame), Upload file, Review, Call ended  

### `07_appointments`

- Appointment upcoming, Appointment completed, Appointment cancelled  
- Appointment detail, Appointment cancel  

### `08_payments`

- Payment, Enter your PIN, Add new card, Review Summary  
- Failed, Congratulations  

### `09_ai_insights`

- AI Insights/Main  
- AI Insight/Health suggestions  
- AI Insight/Habit analysis  
- AI Insight/Chatting  
- AI Insight/Chatting History  

### `10_settings`

- Settings/Main, Settings/Select language  
- Settings/Account, Settings/Account/Change Password, Settings/Account/Confirm Delete Account  
- Settings/Privacy, Settings/Privacy/Remove Data Confirm  
- Settings/Devices, Settings/Device Detail  
- Settings/New Device, Settings/New Device/Enter Pair Code  

### `99_misc_wireframes`

- Frame 301  
- Frame 302  

## Liên kết MCP / Figma (parent section)

Toàn bộ màn hình nằm trong node cha (mở Dev Mode):

`https://www.figma.com/design/vnowI58w60vDikzzDSaex5/Mobile-App?node-id=792-7519&m=dev`

Mỗi màn hình con: thay `node-id` bằng `FILE_NODE` với dấu `:` → `-` (ví dụ `792:7520` → `node-id=792-7520`). Chi tiết đầy đủ từng màn hình nằm trong `plans/feature_plan.md`.
