# Go Development Guidelines

## Core Principles

* Tuân thủ idiomatic Go.
* Tuân thủ Effective Go.
* Tuân thủ Go Code Review Comments.
* Ưu tiên đơn giản.
* Ưu tiên readability.
* Ưu tiên maintainability.
* Ưu tiên consistency với codebase hiện có.

Không mang pattern từ:

* Java
* Spring
* C#
* Enterprise frameworks

vào Go nếu không thực sự cần.

## Existing Codebase First

Khi làm việc trong codebase hiện có:

* Hiểu kiến trúc hiện tại trước khi sửa.
* Tuân thủ convention hiện có.
* Tuân thủ dependency boundaries hiện có.
* Tuân thủ package structure hiện có.

Không được:

* Tự ý refactor ngoài phạm vi task.
* Tự ý thay đổi public API.
* Tự ý thay đổi package structure.

Ưu tiên:

* Existing patterns.
* Existing conventions.

## Simplicity First

Ưu tiên:

* Function.
* Struct.
* Package.

Trước khi tạo:

* Interface.
* Generic abstraction.
* Framework layer.

Nếu function đơn giản giải quyết được vấn đề:

Không tạo abstraction mới.

## Package Design

* Package phải có trách nhiệm rõ ràng.
* Package nên nhỏ và tập trung.

Tránh:

* utils
* helpers
* common
* misc

trở thành bãi chứa code.

## Interfaces

Nguyên tắc:

Accept Interfaces, Return Structs.

Interface nên:

* Nhỏ.
* Tập trung.
* Đặt gần nơi sử dụng.

Không:

* Tạo interface chỉ để mock.
* Tạo interface chỉ có một implementation.
* Định nghĩa interface ở package implementer.

Ưu tiên:

```go
type UserReader interface {
    GetByID(ctx context.Context, id string) (*User, error)
}
```

Thay vì interface lớn.

## Dependency Management

* Dependency phải một chiều.
* Tránh circular dependency.
* Tránh package phụ thuộc lẫn nhau.

Nếu xuất hiện circular dependency:

* Sửa kiến trúc.
* Không workaround.

## Struct Design

* Struct phải rõ trách nhiệm.
* Tránh struct quá lớn.
* Tránh God Object.

Không nhét toàn bộ hệ thống vào một struct.

## Context

Mọi request-scoped operation phải nhận:

```go
context.Context
```

Context nên là tham số đầu tiên.

Không:

* Lưu context trong struct.
* Tạo context giả không cần thiết.

## Error Handling

Luôn xử lý error.

Không:

```go
_, _ = doSomething()
```

Không:

```go
if err != nil {
    panic(err)
}
```

cho flow bình thường.

Ưu tiên:

```go
if err != nil {
    return fmt.Errorf("create user: %w", err)
}
```

## Error Wrapping

Khi propagate error:

```go
fmt.Errorf("operation failed: %w", err)
```

Giữ nguyên nguyên nhân gốc.

Không mất stack thông tin.

## Logging

* Structured logging nếu project hỗ trợ.
* Log đủ context.
* Không log secrets.
* Không log token.
* Không log password.

## Concurrency

Chỉ dùng goroutine khi có lợi ích thực tế.

Không:

* Goroutine vô tội vạ.
* Fan-out không kiểm soát.
* Spawn goroutine trong loop mà không đánh giá rủi ro.

Luôn xem xét:

* Goroutine leak.
* Deadlock.
* Race condition.

## Channels

Dùng channel cho communication.

Không dùng channel thay mutex chỉ vì sở thích.

Chọn công cụ đơn giản nhất:

* Mutex khi phù hợp.
* Channel khi phù hợp.

## Synchronization

Đánh giá:

* Race condition.
* Deadlock.
* Resource leak.

Trước khi hoàn thành task.

## Database

* Tránh N+1 query.
* Tránh query trong loop.
* Transaction phải rõ ràng.
* Validation không thay thế constraint database.

## HTTP Handlers

Handler nên:

* Mỏng.
* Tập trung vào HTTP concerns.

Không nhét business logic lớn vào handler.

Ưu tiên:

Handler -> Service -> Repository

## Business Logic

Business logic không nằm trong:

* HTTP handler.
* Transport layer.
* Infrastructure layer.

Tách riêng logic nghiệp vụ.

## Configuration

Không hardcode:

* URL
* Host
* Port
* Credentials
* API keys
* Environment-specific values

Ưu tiên:

* Environment variables
* Config files

## Paths

Không hardcode:

* Absolute path
* Machine-specific path
* Local development path

## Generics

Chỉ dùng generics khi:

* Thực sự giảm duplication.
* Tăng readability.

Không dùng generics để thể hiện kỹ thuật.

## Testing

Ưu tiên:

* Table-driven tests.

Ví dụ:

```go
tests := []struct {
    name string
    input string
    expected string
}{
    ...
}
```

Test:

* Business behavior.
* Edge cases.
* Error cases.

Không test implementation detail.

## Benchmarks

Benchmark trước khi tối ưu.

Không tối ưu dựa trên cảm giác.

## AI Safety Rules

Trước khi viết code:

* Tìm package tương tự.
* Tìm service tương tự.
* Tìm repository tương tự.
* Tìm pattern hiện có.

Ưu tiên tái sử dụng.

Không được:

* Hardcode dữ liệu.
* Hardcode config.
* Hardcode business rules.
* Hardcode permissions.
* Hardcode feature flags.
* Copy-paste logic giữa packages.

## Large Repository Safety

Khi làm việc trong monorepo hoặc codebase lớn:

* Hiểu dependency graph trước khi sửa.
* Chỉ sửa phạm vi liên quan đến task.
* Không refactor ngoài phạm vi yêu cầu.
* Không đổi package structure nếu không được yêu cầu.
* Không đổi public API nếu không được yêu cầu.
* Cảnh báo nếu thay đổi có thể ảnh hưởng package khác.

## Completion Checklist

Trước khi hoàn thành task:

* Không có circular dependency.
* Không có hardcode.
* Không có goroutine leak.
* Không có race condition rõ ràng.
* Không có duplicate logic.
* Không vi phạm package boundary.
* Error được xử lý đúng.
* Context được truyền đúng.
* Tuân thủ idiomatic Go.
* Có đánh giá edge cases.

## Architecture Preservation

Do not introduce:

* Service layer
* Repository layer
* Interface abstraction
* Generic abstraction

unless the existing codebase already uses them
or the task explicitly requires them.
