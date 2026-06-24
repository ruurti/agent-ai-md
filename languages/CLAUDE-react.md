# React Development Guidelines

## Core Principles

* Tuân thủ code style hiện có của project.
* Ưu tiên readability.
* Ưu tiên maintainability.
* Ưu tiên consistency.
* Ưu tiên giải pháp đơn giản nhất hoạt động được.
* Không tối ưu sớm.
* Không over-engineering.

## Existing Codebase First

Khi làm việc trong codebase hiện có:

* Hiểu pattern hiện tại trước khi sửa.
* Tuân thủ convention hiện có.
* Tuân thủ cấu trúc thư mục hiện có.
* Tuân thủ state management hiện có.
* Tuân thủ data fetching pattern hiện có.

Không được:

* Tự ý đổi kiến trúc.
* Tự ý đổi state management.
* Tự ý đổi UI framework.
* Tự ý refactor ngoài phạm vi task.

Ưu tiên:

* Consistency hơn sở thích cá nhân.
* Existing pattern hơn pattern mới.

## Component Design

* Một component chỉ nên có một trách nhiệm chính.
* Component phải dễ đọc.
* Component phải dễ test.
* Component phải dễ tái sử dụng.

Tránh:

* God Component.
* Component quá dài.
* Component xử lý quá nhiều business logic.

Nếu component trở nên phức tạp:

* Tách thành component nhỏ hơn.
* Hoặc tách logic thành custom hook.

## State Management

Ưu tiên:

1. Local State
2. Lift State Up
3. Context
4. Global State

Không đưa state lên global nếu local state là đủ.

Không tạo global state chỉ để chia sẻ cho một vài component.

## State Ownership

State nên nằm gần nơi sử dụng nhất.

Không:

* Duplicate state.
* Mirror state không cần thiết.
* Copy props vào state nếu không có lý do rõ ràng.

## Hooks

Tuân thủ Rules of Hooks.

Không:

* Gọi hook trong condition.
* Gọi hook trong loop.
* Gọi hook trong nested function.

## useEffect Rules

Không dùng useEffect cho:

* Derived state.
* Data transformation đơn giản.
* Computation đơn giản.
* Đồng bộ state không cần thiết.

Trước khi viết useEffect:

Hỏi:

* Có thực sự là side effect không?
* Có thể giải quyết bằng state hoặc props không?

Ưu tiên loại bỏ useEffect nếu không cần.

## Custom Hooks

Chỉ tạo custom hook khi:

* Logic được tái sử dụng.
* Logic đủ phức tạp.

Không tạo custom hook cho logic quá nhỏ.

Không tạo hook chỉ để bọc vài dòng code.

## Data Fetching

Ưu tiên data fetching solution hiện có trong project.

Nếu project sử dụng:

* TanStack Query
* React Query
* SWR

Thì tiếp tục sử dụng.

Không tự viết:

* Cache layer
* Retry mechanism
* Loading manager

Nếu framework đã hỗ trợ.

## API Layer

Không gọi API trực tiếp trong nhiều component.

Ưu tiên:

* API client
* Service layer
* Query layer

Tách biệt:

* UI
* Fetching
* Business logic

## Business Logic

Không nhúng business logic phức tạp vào component.

Ưu tiên:

* Services
* Utilities
* Custom hooks

Component nên tập trung vào rendering.

## Forms

Ưu tiên pattern hiện có của project.

Không:

* Tự viết form framework.
* Duplicate validation logic.

Validation nên có:

* Client side
* Server side

## Performance

Không dùng:

* useMemo
* useCallback
* memo

Theo mặc định.

Chỉ sử dụng khi:

* Có vấn đề thực tế.
* Có profiling chứng minh.

Không memo hóa mọi thứ.

## Rendering

Tránh:

* Re-render không cần thiết.
* Computation nặng trong render.
* Inline object phức tạp.
* Inline function phức tạp.

Ưu tiên code dễ đọc trước.

## Component Communication

Ưu tiên:

* Props
* Context
* State Management

Không:

* Event bus tùy tiện.
* Shared mutable state.
* Global singleton không cần thiết.

## Module Boundaries

Tôn trọng module boundaries hiện có.

Không:

* Import xuyên tầng.
* Import internal implementation.
* Truy cập private modules.

Ưu tiên:

* Public API.
* Shared contracts.

## Imports

* Tuân thủ convention hiện có.
* Không tạo dependency vòng.
* Không import từ deep internal path nếu project đã có public export.

Ví dụ tránh:

import "../../../../../feature/internal/component"

Ưu tiên:

import { UserCard } from "@/features/user"

## Styling

Tuân thủ giải pháp hiện có:

* Tailwind
* CSS Modules
* Styled Components
* Emotion

Không trộn nhiều styling strategy.

Không tạo strategy mới nếu không cần.

## Error Handling

Mọi async operation phải có:

* Error handling
* Loading state

Không:

* Ignore error
* Silent failure

## UX Rules

Mọi màn hình nên xử lý:

* Loading state
* Error state
* Empty state

Không giả định dữ liệu luôn tồn tại.

## Accessibility

Ưu tiên:

* Semantic HTML
* Accessible form labels
* Keyboard navigation

Không hy sinh accessibility vì tốc độ phát triển.

## Testing

Test:

* User behavior
* Business behavior
* User interaction

Không test:

* Internal implementation
* Hook internals
* State internals

Ưu tiên:

* React Testing Library

## AI Safety Rules

Trước khi sửa code:

* Tìm pattern hiện có.
* Tìm component tương tự.
* Tìm hook tương tự.
* Tìm service tương tự.

Ưu tiên tái sử dụng.

Không được:

* Hardcode dữ liệu.
* Hardcode API response.
* Hardcode business rule.
* Hardcode role permission.
* Hardcode feature flag.
* Copy-paste logic giữa các component.

## Large Repository Safety

Khi làm việc trong monorepo hoặc codebase lớn:

* Hiểu dependency graph trước khi sửa.
* Chỉ sửa phạm vi liên quan đến task.
* Không refactor ngoài phạm vi yêu cầu.
* Không đổi public API nếu không được yêu cầu.
* Cảnh báo nếu thay đổi có thể ảnh hưởng module khác.

## Completion Checklist

Trước khi hoàn thành task:

* Không có state dư thừa.
* Không có useEffect không cần thiết.
* Không có duplicate logic.
* Không có hardcode.
* Không có dependency vòng.
* Không vi phạm module boundary.
* Có loading state phù hợp.
* Có error state phù hợp.
* Có đánh giá edge cases.
* Tuân thủ pattern hiện có của project.

## Framework Features First

Before introducing custom solutions:

* Check whether React already provides it.
* Check whether Next.js already provides it.
* Check whether the existing project already provides it.

Prefer framework-native solutions over custom abstractions.
