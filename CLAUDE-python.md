# 🐍 Hướng Dẫn Python — Dành Cho Culi

> File này đặt tại thư mục gốc của project Python, đặt tên là `CLAUDE.md`
> Hoặc import vào global bằng cách thêm `@CLAUDE-python.md` trong `~/.claude/CLAUDE.md`

---

## Triết Lý Code Python

- Tuân thủ **"Pythonic"**: dùng list comprehension, context manager, unpacking đúng chỗ
- Ưu tiên **rõ ràng hơn ngắn gọn** — tên biến phải nói lên được ý nghĩa
- Áp dụng nguyên tắc **"Fail fast"** — raise lỗi sớm, đừng để lỗi âm thầm chạy qua
- Mỗi hàm chỉ làm **một việc duy nhất** — nếu phải dùng "và" để mô tả hàm thì cần tách ra

---

## Cấu Trúc Project

```
project/
├── src/
│   └── module/
│       ├── __init__.py
│       ├── models.py       # Data models / dataclass / pydantic
│       ├── services.py     # Business logic
│       ├── utils.py        # Helper functions
│       └── exceptions.py  # Custom exceptions
├── tests/
│   └── test_*.py
├── .env.example
├── pyproject.toml          # Ưu tiên dùng thay vì setup.py
└── README.md
```

---

## Quy Tắc Viết Code

### Type Hints — Bắt Buộc
```python
# ✅ Đúng
def tinh_tong(a: int, b: int) -> int:
    return a + b

def lay_nguoi_dung(user_id: str) -> dict | None:
    ...

# ❌ Sai — thiếu type hint
def tinh_tong(a, b):
    return a + b
```

### Xử Lý Lỗi — Luôn Cụ Thể
```python
# ✅ Đúng — bắt lỗi cụ thể, log rõ ràng
try:
    ket_qua = goi_api(url)
except httpx.TimeoutException as e:
    logger.error("API timeout sau %s giây: %s", TIMEOUT, e)
    raise ServiceUnavailableError("Dịch vụ tạm thời không khả dụng") from e
except httpx.HTTPStatusError as e:
    logger.error("API trả về lỗi %s: %s", e.response.status_code, e)
    raise

# ❌ Sai — nuốt lỗi, không biết chuyện gì xảy ra
try:
    ket_qua = goi_api(url)
except Exception:
    pass
```

### Dataclass / Pydantic Thay Cho Dict Lồng Nhau
```python
# ✅ Đúng — rõ ràng, có type safety
from dataclasses import dataclass

@dataclass
class NguoiDung:
    id: str
    ten: str
    email: str
    la_admin: bool = False

# ❌ Sai — dict lồng nhau, dễ lỗi, khó đọc
nguoi_dung = {"id": "123", "ten": "Nam", "email": "nam@example.com"}
```

### Async — Dùng Đúng Chỗ
```python
# ✅ Đúng — async khi gọi I/O (API, DB, file)
async def lay_du_lieu(user_id: str) -> NguoiDung:
    async with httpx.AsyncClient() as client:
        response = await client.get(f"/users/{user_id}")
        response.raise_for_status()
        return NguoiDung(**response.json())

# ❌ Sai — dùng async cho logic thuần tính toán
async def cong_hai_so(a: int, b: int) -> int:
    return a + b
```

---

## Logging — Không Dùng print()

```python
import logging

logger = logging.getLogger(__name__)

# ✅ Đúng
logger.info("Bắt đầu xử lý đơn hàng: %s", order_id)
logger.warning("Số lượng tồn kho thấp: còn %d sản phẩm", so_luong)
logger.error("Không thể kết nối DB: %s", error)

# ❌ Sai
print(f"Xử lý đơn hàng {order_id}")
```

---

## Testing — Pytest

- Mỗi function public phải có ít nhất **1 test happy path + 1 test edge case**
- Dùng `pytest.fixture` cho data dùng chung
- Mock external calls bằng `unittest.mock` hoặc `pytest-mock`
- Đặt tên test rõ ràng: `test_<tên_hàm>_<tình_huống>_<kết_quả_mong_đợi>`

```python
def test_tinh_tong_so_am_tra_ve_dung():
    assert tinh_tong(-1, -2) == -3

def test_lay_nguoi_dung_khong_ton_tai_raise_not_found():
    with pytest.raises(NotFoundError):
        lay_nguoi_dung("id-khong-co")
```

---

## Quản Lý Dependencies

- Dùng **`pyproject.toml`** + `uv` hoặc `poetry` (không dùng `pip` thuần cho project thật)
- **Không bao giờ** hardcode secret — dùng `.env` + `python-dotenv` hoặc biến môi trường
- Pin phiên bản dependencies trong production: `httpx==0.27.0` thay vì `httpx>=0.27`

---

## Checklist Trước Khi Commit

- [ ] Chạy `ruff check .` — không có lỗi lint
- [ ] Chạy `mypy .` — không có lỗi type
- [ ] Chạy `pytest` — tất cả test pass
- [ ] Không có `print()` nào còn sót lại
- [ ] Không có secret hay API key trong code
