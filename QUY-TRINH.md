# 🔄 Quy trình làm báo cáo hàng tuần

> Mục tiêu: mỗi sáng **Thứ 2**, ra 1 dashboard cho tuần **T2→CN liền trước**, chỉ các tuyến **Demand** của **Khánh** trong tài khoản *Adsplus 5 - 30shine - Tỉnh*.

## 🗂️ Cấu trúc thư mục
```
dashboardads/
├── index.html              ← LUÔN là bản mới nhất — mở file này để xem
├── tao-bao-cao.ps1         ← script sinh dashboard
├── template/
│   └── dashboard-template.html   ← khung giao diện (ít khi sửa)
├── data/                   ← NƠI LÀM VIỆC CHÍNH: mỗi tuần 1 file JSON số liệu
│   └── 2026-06-15_2026-06-21.json
└── reports/                ← kho lưu dashboard từng tuần (tự sinh)
    └── dashboard_2026-06-15_2026-06-21.html
```
**Nguyên tắc:** chỉ sửa **số liệu trong `data/`**. Giao diện nằm ở `template/` — không cần đụng.

---

## ⭐ Cách nhanh nhất: nhờ Claude
Mỗi sáng T2, mở chat và gõ:
> **"Chạy báo cáo tuần Demand tuần trước"**

Claude sẽ tự: kéo số Meta → tạo file `data/<tuần>.json` → chạy script → commit & push. Bạn chỉ việc mở `index.html` hoặc link GitHub Pages.

---

## ✋ Cách tự làm tay (khi không có Claude)

**Bước 1 — Tạo file dữ liệu tuần mới**
- Copy file JSON tuần gần nhất trong `data/`, đổi tên theo kỳ mới: `data/YYYY-MM-DD_YYYY-MM-DD.json` (ngày T2 _ ngày CN).
- Điền số (xem giải thích field bên dưới).

**Bước 2 — Sinh dashboard**
Mở PowerShell tại thư mục này, chạy:
```powershell
.\tao-bao-cao.ps1
```
(Script tự lấy file JSON mới nhất trong `data/`. Muốn chỉ định: `.\tao-bao-cao.ps1 -DataFile data\2026-06-22_2026-06-28.json`)

**Bước 3 — Kiểm tra**
Mở `index.html` bằng trình duyệt, soát lại số.

**Bước 4 — Đưa lên GitHub**
```powershell
git add .
git commit -m "Bao cao tuan YYYY-MM-DD"
git push
```

---

## 📋 Giải thích file dữ liệu JSON

```jsonc
{
  "meta": {
    "account": "Adsplus 5 - 30shine - Tỉnh",
    "week":    "22/06 (T2) → 28/06 (CN) /2026",  // hiển thị trên tiêu đề
    "prev":    "15–21/06",                        // tuần so sánh
    "generated":"Tạo ngày 29/06/2026"
  },
  "tuyen": [        // 5 tuyến Demand — số ở cấp CAMPAIGN
    {
      "ten":"Du lịch thư giãn 45 phút",
      "spend": 60092527,   // chi tiêu tuần này (VND)
      "mua":   450,        // lượt mua = omni_purchase
      "impr":  5254948,
      "reach": 2083651,
      "ctr":   0.88,       // %
      "pSpend":23904578,   // chi tiêu TUẦN TRƯỚC (để tính ΔCPA)
      "pMua":  676         // lượt mua tuần trước
    }
  ],
  "creative": {     // top 5 ad mỗi tuyến — key = đúng tên tuyến ở trên
    "Du lịch thư giãn 45 phút": [
      { "n":"Tên creative", "mua":142, "cpa":71209, "spend":10111692, "ctr":2.26,
        "win":true,   // ⭐ đánh dấu nên scale (CPA rẻ nhất tuyến)
        "cut":true }  // 🔴 đánh dấu đốt tiền nên tắt (CPA cao + CTR thấp)
    ]
  }
}
```
- **CPA tự tính** = `spend ÷ mua` (không cần điền).
- **Tín hiệu tuyến** tự gắn theo mức tăng CPA so với tuần trước: >300% 🔴 / >150% 🟠 / còn lại 🟢.
- **win/cut** là cờ tuỳ chọn cho mục "Tín hiệu & Đề xuất". Mỗi tuyến nên đặt 1 `win` (creative rẻ-tốt nhất) và 1 `cut` (creative tệ nhất).

---

## 📥 Lấy số liệu từ Meta (tham khảo)
Nguồn: tài khoản `act_671545627449956`, lọc 5 campaign tên `All . Demand . … . Khánh`.
- **Cấp campaign** (cho bảng tuyến): spend, omni_purchase, impressions, reach, ctr — 2 lần: tuần này & tuần trước.
- **Cấp ad** (cho top creative): mỗi campaign lấy 5 ad, sắp theo omni_purchase giảm dần; với mỗi ad lấy spend, omni_purchase (→ CPA), ctr.

> Toàn bộ bước này Claude làm tự động khi bạn gõ "chạy báo cáo tuần".
