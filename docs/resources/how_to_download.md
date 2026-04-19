# Cách tải ảnh từ Figma MCP và đưa vào repo (EverWell Flutter)

Tài liệu mô tả quy trình dùng trong dự án: lấy URL asset từ MCP Figma trong Cursor, tải về máy, tối ưu kích thước (nếu cần), khai báo Flutter `assets`, và dùng `Image.asset` trong code.

## 1. Lấy URL ảnh từ Figma (MCP)

1. Xác định **file** và **node** trong Figma (ví dụ từ link design):
   - URL dạng: `https://www.figma.com/design/<fileKey>/...?node-id=806-4719`
   - **`fileKey`**: đoạn sau `/design/` (ví dụ `vnowI58w60vDikzzDSaex5`).
   - **`nodeId`**: đổi `806-4719` thành `806:4719` (dấu `:` thay cho `-`).

2. Trong Cursor, gọi MCP **Figma** với tool **`get_design_context`**:
   - **Server** (đúng tên trong môi trường Cursor): `plugin-figma-figma` (không phải `figma` nếu client báo không tồn tại server).
   - **Tham số**:
     - `fileKey`: key file ở trên.
     - `nodeId`: id node dạng `806:4719`.
     - `clientLanguages`: ví dụ `dart`.
     - `clientFrameworks`: ví dụ `flutter`.

3. Trong phản hồi, tìm các hằng URL dạng:

   ```text
   https://www.figma.com/api/mcp/asset/<uuid>
   ```

   Code sinh ra thường có dạng `const imgFrame7 = "https://..."` — mỗi URL là một raster (PNG/JPEG tùy server) có **thời hạn** (Figma ghi chú khoảng 7 ngày cho URL MCP), nên **luôn** tải về repo để dùng offline.

## 2. Tải file về workspace (chỉ CLI, không dùng script `.sh`)

API asset đôi khi trả **404** nếu gửi giống bot (không có header trình duyệt). Luôn dùng `curl` với **User-Agent trình duyệt**. Nếu vẫn 404, thử thêm **Personal Access Token** Figma (`figd_...`) qua header (tùy môi trường / URL đã hết hạn).

Chạy mọi lệnh dưới đây từ **thư mục gốc repo** (`EverWell_Flutter/`, nơi có `pubspec.yaml`).

### 2a. Một file cụ thể

Thay `ASSET_UUID` và đường đích:

```bash
mkdir -p assets/images/<thư_mục_con>

curl -sSL \
  -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36' \
  -o "assets/images/<thư_mục_con>/<tên_file>.png" \
  "https://www.figma.com/api/mcp/asset/ASSET_UUID"
```

Kiểm tra file thật sự là ảnh:

```bash
file "assets/images/<thư_mục_con>/<tên_file>.png"
```

### 2b. Hàng loạt từ manifest (B1 + C1–C4)

Repo có `tool/figma_mcp_assets/manifest.tsv`: mỗi dòng `đường_dẫn<TAB>url` (bỏ qua dòng bắt đầu bằng `#`).

```bash
cd /path/to/EverWell_Flutter

UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'

# Tuỳ chọn nếu chỉ User-Agent vẫn 404:
# export FIGMA_ACCESS_TOKEN='figd_...'

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${line//[$'\t' ]/}" ]] && continue
  IFS=$'\t' read -r relpath url <<<"$line"
  [[ -z "${relpath:-}" || -z "${url:-}" ]] && continue
  mkdir -p "$(dirname "$relpath")"
  tmp="${relpath}.part"
  args=( -sSL -A "$UA" -o "$tmp" "$url" )
  if [[ -n "${FIGMA_ACCESS_TOKEN:-}" ]]; then
    args=( -sSL -A "$UA" \
      -H "Authorization: Bearer ${FIGMA_ACCESS_TOKEN}" \
      -H "X-Figma-Token: ${FIGMA_ACCESS_TOKEN}" \
      -o "$tmp" "$url" )
  fi
  if curl "${args[@]}" && [[ -s "$tmp" ]]; then
    mv -f "$tmp" "$relpath" && echo "OK  $relpath"
  else
    echo "FAIL $relpath" >&2
    rm -f "$tmp"
  fi
done < tool/figma_mcp_assets/manifest.tsv
```

Sau đó: `flutter pub get` và (tuỳ chọn) kiểm tra vài file: `file assets/images/figma_mcp/tab/home.png`.

### 2c. Placeholder PNG tối thiểu (khi thiếu file cho build)

Chỉ dùng khi chưa tải được ảnh thật; ghi đè sau khi chạy §2b thành công.

```bash
B64='iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${line//[$'\t' ]/}" ]] && continue
  IFS=$'\t' read -r relpath _ <<<"$line"
  [[ -z "${relpath:-}" ]] && continue
  mkdir -p "$(dirname "$relpath")"
  printf '%s' "$B64" | base64 -d >"$relpath"
done < tool/figma_mcp_assets/manifest.tsv
```

Nếu vẫn 404 sau khi làm đúng §2a/2b: lấy lại URL từ `get_design_context` mới nhất (UUID hết hạn ~7 ngày), cập nhật `manifest.tsv`, rồi chạy lại vòng `while`.

## 3. Tối ưu dung lượng (khuyến nghị)

Ảnh export từ MCP có thể rất lớn. Có thể thu nhỏ bằng ImageMagick (giữ tỷ lệ, chỉ thu khi vượt ngưỡng):

```bash
magick "assets/images/<thư_mục_con>/<tên_file>.png" \
  -resize '1440x>' \
  -strip \
  "assets/images/<thư_mục_con>/<tên_file>.png"
```

Điều chỉnh `1440` theo nhu cầu (icon ô nhỏ có thể dùng `256x>`).

## 4. Khai báo asset trong Flutter

Trong `pubspec.yaml`, mục `flutter` > `assets`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/auth/
    - assets/images/import_emr/
    - assets/images/figma_mcp/home/
    - assets/images/figma_mcp/tab/
    - assets/images/figma_mcp/medical_records/
```

Có thể khai báo **thư mục** (mọi file con được bundle) hoặc từng file cụ thể.

Sau đó:

```bash
flutter pub get
```

## 5. Mã Dart: hằng số đường dẫn và `Image.asset`

1. Tạo (hoặc cập nhật) file constants, ví dụ `lib/core/presentation/theme/import_emr_assets.dart`:

   ```dart
   abstract final class ImportEmrAssets {
     static const vneidTile = 'assets/images/import_emr/vneid_tile.png';
   }
   ```

2. Trong widget, dùng **`Image.asset`**, không dùng `Image.network` cho URL MCP trong production:

   ```dart
   Image.asset(
     ImportEmrAssets.vneidTile,
     fit: BoxFit.cover,
     errorBuilder: (context, error, stackTrace) => /* placeholder */,
   )
   ```

3. Ghi chú trong code hoặc trong file constants: **node Figma** + **fileKey** (để sau này tái xuất từ MCP).

## 6. Checklist nhanh

- [ ] `get_design_context` đúng `fileKey` / `nodeId`.
- [ ] Copy đủ URL `api/mcp/asset/...` cần dùng.
- [ ] `curl` + User-Agent (§2a hoặc vòng `while` §2b), kiểm tra `file`.
- [ ] Resize nếu file quá lớn.
- [ ] Thêm đường dẫn vào `pubspec.yaml` > `assets`.
- [ ] Hằng số Dart + `Image.asset` (và `pub get` / analyze / chạy thử).

## Tham chiếu trong repo

| Nội dung | Vị trí |
|----------|--------|
| Nền auth (welcome hero) | `assets/images/auth/welcome_hero_background.png`, `lib/core/presentation/theme/figma_mcp_auth_assets.dart` |
| Logo nhập bệnh án (VNEID / GOV / Chợ Rẫy) | `assets/images/import_emr/`, `lib/core/presentation/theme/import_emr_assets.dart` |
| Raster MCP (Trang chủ B1 + hồ sơ C1–C4) | `tool/figma_mcp_assets/manifest.tsv`, `assets/images/figma_mcp/**`, `lib/core/presentation/theme/everwell_figma_mcp_raster_assets.dart` |
| Widget nền | `lib/core/presentation/widgets/everwell_auth_background.dart` |
| Màn nhập EMR | `lib/features/onboarding_auth/presentation/pages/import_emr_page.dart` |
