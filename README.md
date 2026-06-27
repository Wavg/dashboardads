# Dashboard Ads — Tuyến Demand (30Shine Tỉnh · camp Khánh)

Báo cáo tuần các tuyến **Demand** trên Meta Ads (tài khoản *Adsplus 5 - 30shine - Tỉnh*), chỉ campaign của Khánh.

## Nội dung
- KPI tổng (chi tiêu, lượt mua, CPA, impressions, reach) + so sánh tuần trước
- Bảng tổng quan 5 tuyến Demand + nhãn tín hiệu (🔴/🟠/🟢)
- Biểu đồ CPA tuần này vs tuần trước
- Mục **Tín hiệu & Đề xuất**: nên scale 🟢 / nên tắt 🔴
- Top 5 creative win theo từng tuyến (xếp theo lượt mua → CPA rẻ)

## Cách dùng
Mở `index.html` bằng trình duyệt — file tự chạy, không cần internet hay cài đặt gì.

## Cập nhật hàng tuần
Toàn bộ số liệu nằm trong block `DỮ LIỆU TUẦN` ở đầu thẻ `<script>` (các biến `META`, `TUYEN`, `CREATIVE`). Mỗi tuần chỉ cần thay block đó, giao diện tự vẽ lại.

| Tuần | File |
|---|---|
| 15–21/06/2026 | `dashboard-demand-15-21-06-2026.html` |

> Số liệu nguồn: Meta Ads API. Lượt mua = purchase (omni_purchase). CPA = Chi tiêu ÷ Lượt mua.
