# ⚛️ Hướng Dẫn React — Dành Cho Culi

> File này đặt tại thư mục gốc của project React, đặt tên là `CLAUDE.md`
> Hoặc import vào global bằng cách thêm `@CLAUDE-react.md` trong `~/.claude/CLAUDE.md`

---

## Triết Lý Code React

- **Component nhỏ, tập trung** — mỗi component chỉ làm một việc, dễ test, dễ tái sử dụng
- **Logic ra ngoài UI** — business logic nằm trong custom hooks, không nằm trong JSX
- **Tránh over-engineering** — không dùng Redux/Zustand nếu `useState` + `useContext` là đủ
- **Performance sau, correctness trước** — đừng tối ưu sớm, đo trước khi dùng `memo`/`useMemo`

---

## Cấu Trúc Project

```
src/
├── components/         # UI components tái sử dụng (Button, Modal, Input...)
│   └── Button/
│       ├── Button.tsx
│       ├── Button.test.tsx
│       └── index.ts    # Re-export
├── features/           # Tính năng cụ thể (Auth, Dashboard, Orders...)
│   └── auth/
│       ├── components/ # Component chỉ dùng trong feature này
│       ├── hooks/      # Custom hooks của feature
│       ├── api.ts      # API calls của feature
│       └── types.ts    # Types của feature
├── hooks/              # Custom hooks dùng chung toàn app
├── lib/                # Helpers, utils, config
├── types/              # Global TypeScript types
└── app/                # Routes (Next.js App Router hoặc React Router)
```

---

## Quy Tắc Viết Component

### TypeScript — Bắt Buộc
```tsx
// ✅ Đúng — Props được định nghĩa rõ ràng
interface NutBamProps {
  nhan: string
  onClick: () => void
  dangTai?: boolean
  bien_the?: 'chinh' | 'phu' | 'nguy_hiem'
}

export function NutBam({ nhan, onClick, dangTai = false, bien_the = 'chinh' }: NutBamProps) {
  return (
    <button onClick={onClick} disabled={dangTai}>
      {dangTai ? 'Đang xử lý...' : nhan}
    </button>
  )
}

// ❌ Sai — any, không có type
export function NutBam({ nhan, onClick }: any) { ... }
```

### Custom Hook — Tách Logic Khỏi UI
```tsx
// ✅ Đúng — logic trong hook, component chỉ lo render
function useDanhSachSanPham(danh_muc: string) {
  const [san_pham, setSanPham] = useState<SanPham[]>([])
  const [dang_tai, setDangTai] = useState(false)
  const [loi, setLoi] = useState<string | null>(null)

  useEffect(() => {
    setDangTai(true)
    laySanPham(danh_muc)
      .then(setSanPham)
      .catch((e) => setLoi(e.message))
      .finally(() => setDangTai(false))
  }, [danh_muc])

  return { san_pham, dang_tai, loi }
}

// Trong component — gọn, dễ đọc
function DanhSachSanPham({ danh_muc }: { danh_muc: string }) {
  const { san_pham, dang_tai, loi } = useDanhSachSanPham(danh_muc)

  if (dang_tai) return <Skeleton />
  if (loi) return <ThongBaoLoi loi={loi} />
  return <ul>{san_pham.map((sp) => <ItemSanPham key={sp.id} {...sp} />)}</ul>
}
```

### Xử Lý Trạng Thái Loading/Error — Không Bỏ Sót
```tsx
// ✅ Luôn xử lý đủ 3 trạng thái
if (dang_tai) return <TrangThaiTai />
if (loi) return <TrangThaiLoi loi={loi} thu_lai={refetch} />
if (!du_lieu?.length) return <TrangThaiRong />

return <DanhSach items={du_lieu} />
```

---

## Quản Lý State

| Tình huống | Giải pháp |
|---|---|
| State cục bộ của component | `useState` |
| State chia sẻ trong một feature | `useContext` + `useReducer` |
| State server (API data) | `TanStack Query` (React Query) |
| State toàn app phức tạp | `Zustand` (nhẹ) hoặc `Redux Toolkit` |
| Form | `React Hook Form` + `Zod` |

**Quy tắc:** Bắt đầu với `useState`, chỉ nâng lên khi thực sự cần.

---

## API Calls — Dùng TanStack Query

```tsx
// ✅ Đúng — tận dụng cache, retry, loading state tự động
function useDonHang(order_id: string) {
  return useQuery({
    queryKey: ['don-hang', order_id],
    queryFn: () => layDonHang(order_id),
    staleTime: 5 * 60 * 1000, // Cache 5 phút
  })
}

// ✅ Mutation có optimistic update
function useCapNhatDonHang() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: capNhatDonHang,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['don-hang'] })
    },
  })
}

// ❌ Sai — fetch thủ công trong useEffect, không có cache
useEffect(() => {
  fetch('/api/don-hang').then(r => r.json()).then(setDonHang)
}, [])
```

---

## Performance — Đo Trước, Tối Ưu Sau

```tsx
// Chỉ dùng memo khi component re-render không cần thiết đã được xác nhận
const ItemSanPham = memo(function ItemSanPham({ san_pham }: { san_pham: SanPham }) {
  return <div>{san_pham.ten}</div>
})

// useMemo chỉ cho tính toán nặng (filter/sort list lớn)
const san_pham_da_loc = useMemo(
  () => danh_sach.filter((sp) => sp.danh_muc === danh_muc_hien_tai),
  [danh_sach, danh_muc_hien_tai]
)

// useCallback chỉ khi truyền function vào memo component
const xu_ly_xoa = useCallback((id: string) => {
  xoaSanPham(id)
}, [xoaSanPham])
```

---

## Accessibility — Không Bỏ Qua

```tsx
// ✅ Luôn có aria-label cho icon button
<button aria-label="Đóng hộp thoại" onClick={onClose}>
  <XIcon />
</button>

// ✅ Role và aria cho component tự làm
<div role="dialog" aria-modal="true" aria-labelledby="tieu-de-hop-thoai">
  <h2 id="tieu-de-hop-thoai">Xác nhận xóa</h2>
</div>

// ✅ Ảnh luôn có alt text có nghĩa
<img src={anh_san_pham} alt={`Ảnh sản phẩm: ${ten_san_pham}`} />
```

---

## Checklist Trước Khi Commit

- [ ] Chạy `tsc --noEmit` — không có lỗi TypeScript
- [ ] Chạy `eslint .` — không có warning
- [ ] Chạy test — tất cả pass
- [ ] Không có `console.log` nào còn sót
- [ ] Loading state + Error state đã được xử lý
- [ ] Không có hardcode string (dùng biến hoặc i18n nếu cần)
- [ ] Component mới đã có test cơ bản
