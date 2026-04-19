# Auto Design SOP (MCP Figma -> Flutter)

## Muc dich va pham vi
- Ap dung quy trinh bat buoc cho WS-D truoc, sau do mo rong sang workstream khac.
- Muc tieu: dung code Figma lam nguon su that, app Flutter phai khop text/layout/icon va trang thai UI.

## File bat buoc phai mo khi bat dau
- `plans/feature_plan.md`
- `docs/resources/how_to_download.md`
- `plans/architecture.md`
- `docs/feature/tree.md`
- `lib/features/<domain>/presentation/pages/*.dart` (man hinh can sua)
- `lib/core/presentation/theme/everwell_figma_mcp_raster_assets.dart`
- `tool/figma_mcp_assets/manifest.tsv`

## Nguyen tac bat buoc
1. Bat buoc goi MCP Figma `get_design_context` + `get_screenshot` cho dung `nodeId` truoc khi code.
2. Bat buoc tai asset offline va map vao `Image.asset` (khong dung URL MCP runtime).
3. Bat buoc kiem tra dinh dang file sau khi tai (`file`), neu SVG doi lot `.png` thi convert ve PNG that.
4. Bat buoc compare 2 lop cho tung man:
   - Code parity: code hien tai vs code Figma.
   - Visual parity: screenshot Flutter MCP vs screenshot Figma MCP.
5. Bat buoc chay `flutter analyze` va test lien quan sau moi cum thay doi.

## Quy trinh thao tac chuan cho 1 man hinh
1. Lay context Figma
   - Goi `plugin-figma-figma/get_design_context`.
   - Goi `plugin-figma-figma/get_screenshot`.
2. Chot checklist code parity
   - Text literal: title, label, CTA, status.
   - Typography: font size, weight, line-height.
   - Layout: section order, spacing, radius, elevation, overlay/sheet.
   - Asset: icon/anh dung tu Figma offline.
3. Dong bo asset
   - Them `path<TAB>url` vao `tool/figma_mcp_assets/manifest.tsv`.
   - Download theo `docs/resources/how_to_download.md`.
   - Kiem tra dinh dang bang `file`.
   - Convert SVG -> PNG bang `magick -background none -density 384 ...`.
4. Implement code
   - Sua page/widget trong feature.
   - Cap nhat constants asset neu co.
5. Visual compare
   - Dung Dart MCP di dung state.
   - Chup screenshot app.
   - So voi screenshot Figma cung viewport/cung state.
6. Lap lai fix cho den khi khong con mismatch `Critical/Major`.

## Quy uoc muc do mismatch
- Critical
  - Sai flow, sai component chinh, mat CTA, text chinh sai.
- Major
  - Sai layout ro (spacing/radius/font-size), icon sai loai, crop sai.
- Minor
  - Lech pixel nhe, khong anh huong nhan dien.

## Loi thuong gap va cach xu ly nhanh
- `Invalid image data`
  - Nguyen nhan: file la SVG doi lot `.png`.
  - Cach xu ly: kiem tra `file`, convert ve PNG that bang `magick`.
- Icon nho bat thuong
  - Nguyen nhan: bounding trong suot qua lon.
  - Cach xu ly: `magick <file> -trim +repage <file>`.
- Overflow card/bento
  - Nguyen nhan: typo size/weight/spacing sai.
  - Cach xu ly: doi chieu truc tiep voi code Figma va chot lai constraints.
- Sai state tab/chip/modal
  - Nguyen nhan: capture khac state.
  - Cach xu ly: dat dung state truoc khi screenshot compare.

## Checklist QA cuoi workstream
- [ ] Tat ca man trong scope co `get_design_context` + `get_screenshot`.
- [ ] Tat ca icon/anh trong man da map vao asset offline.
- [ ] Khong con mismatch `Critical/Major` tren visual compare.
- [ ] `flutter analyze` xanh.
- [ ] Test lien quan xanh.
- [ ] Co note tong hop mismatch da xu ly.
