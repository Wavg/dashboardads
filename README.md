# Dashboard Ads — Tuyến Demand (30Shine Tỉnh · camp Khánh)

Báo cáo tuần các tuyến **Demand** trên Meta Ads (tài khoản *Adsplus 5 - 30shine - Tỉnh*), chỉ campaign của Khánh.
Mỗi sáng Thứ 2 ra 1 dashboard cho tuần **T2→CN liền trước**.

## 🚀 Mở xem
Mở **`index.html`** bằng trình duyệt — luôn là bản mới nhất, tự chạy, không cần internet.
(Nếu bật GitHub Pages: xem online tại `https://wavg.github.io/dashboardads/`.)

## 🗂️ Cấu trúc
| Thư mục/File | Vai trò |
|---|---|
| `index.html` | Báo cáo mới nhất (mở để xem) |
| `data/*.json` | **Số liệu từng tuần** — nơi làm việc chính |
| `template/dashboard-template.html` | Khung giao diện dùng chung |
| `tao-bao-cao.ps1` | Script: JSON + template → HTML |
| `reports/*.html` | Kho lưu dashboard các tuần |
| `QUY-TRINH.md` | **Luồng làm việc hàng tuần** (đọc file này) |

## 🔄 Cập nhật 1 tuần mới (tóm tắt)
```powershell
# 1. tạo data\YYYY-MM-DD_YYYY-MM-DD.json (copy tuần trước, điền số)
# 2. sinh dashboard:
.\tao-bao-cao.ps1
# 3. đẩy lên GitHub:
git add .; git commit -m "Bao cao tuan YYYY-MM-DD"; git push
```
Hoặc nhanh hơn: nhờ Claude — gõ **"chạy báo cáo tuần Demand tuần trước"**.

## 📊 Dashboard gồm
- KPI tổng + so sánh tuần trước (chi tiêu, lượt mua, CPA, impressions, reach)
- Bảng 5 tuyến Demand + ΔCPA + nhãn tín hiệu 🔴/🟠/🟢
- Biểu đồ CPA tuần này vs tuần trước
- **Tín hiệu & Đề xuất**: nên scale 🟢 / nên tắt 🔴
- Top 5 creative theo tuyến (xếp lượt mua → CPA rẻ)

> Lượt mua = purchase (omni_purchase). CPA = Chi tiêu ÷ Lượt mua. Nguồn: Meta Ads API.
> ⚠️ Repo không chứa secret. Tuyệt đối không commit `.env`, token, hay khoá API.

## 📅 Lịch sử
| Tuần | File |
|---|---|
| 15–21/06/2026 | `reports/dashboard_2026-06-15_2026-06-21.html` |
