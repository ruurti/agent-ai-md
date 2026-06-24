# PHP Development Guidelines

## Core Principles

* Tuân thủ PSR standards.
* Tuân thủ Clean Code.
* Ưu tiên readability.
* Ưu tiên maintainability.
* Ưu tiên consistency với codebase hiện có.
* Ưu tiên giải pháp đơn giản nhất hoạt động được.

Không viết code theo phong cách PHP cũ nếu project đang dùng PHP hiện đại.

Ưu tiên:

* PHP 8+
* Strict typing
* Constructor promotion
* Enum
* Readonly
* Modern language features

## Existing Codebase First

Khi làm việc trong codebase hiện có:

* Hiểu kiến trúc hiện tại trước khi sửa.
* Tuân thủ convention hiện có.
* Tuân thủ framework conventions.
* Tuân thủ dependency boundaries hiện có.

Không được:

* Tự ý đổi kiến trúc.
* Tự ý refactor ngoài phạm vi task.
* Tự ý đổi public API.
* Tự ý đổi framework pattern.

Ưu tiên:

* Existing patterns.
* Existing conventions.

## Strict Types

Mọi file mới:

```php
declare(strict_types=1);
```

Ưu tiên type declarations đầy đủ.

Không dùng mixed nếu có thể xác định kiểu.

## Naming

* Tên class rõ ràng.
* Tên method rõ ràng.
* Tên biến rõ ràng.

Không dùng:

* data
* value
* temp
* item
* result

trừ khi ngữ cảnh thực sự rõ ràng.

## Class Design

* Mỗi class có một trách nhiệm chính.
* Tránh God Class.
* Tránh Utility Class khổng lồ.
* Tránh Service làm mọi thứ.

Ưu tiên:

* Cohesion cao.
* Trách nhiệm rõ ràng.

## Dependency Injection

Ưu tiên Dependency Injection.

Không:

* new object sâu trong business logic.
* service locator tùy tiện.
* dependency ẩn.

Dependency phải rõ ràng qua constructor.

## Interfaces

Chỉ tạo interface khi:

* Có nhiều implementation.
* Có nhu cầu abstraction thực tế.
* Kiến trúc hiện có yêu cầu.

Không tạo interface chỉ để tạo interface.

## Controllers

Controller phải mỏng.

Controller chỉ nên:

* Validate request.
* Gọi service/use case.
* Trả response.

Không:

* Chứa business logic lớn.
* Chứa query phức tạp.
* Chứa workflow nghiệp vụ.

## Business Logic

Business logic không nằm trong:

* Controller
* Middleware
* Command
* Job

Business logic nên nằm trong:

* Service
* Use Case
* Domain Layer

theo kiến trúc hiện có của project.

## Database

Không:

* Query trong loop.
* N+1 query.
* Duplicate query.

Luôn cân nhắc:

* Eager loading.
* Query optimization.
* Transaction.

Validation không thay thế database constraints.

## Eloquent / ORM

Ưu tiên:

* Relationships.
* Scopes.
* Query Builder.

Không:

* Raw SQL khi ORM đã giải quyết tốt.
* Business logic trong model.

Tránh biến model thành God Object.

## Laravel Specific

Tuân thủ convention của Laravel.

Ưu tiên:

* Form Request
* Service Layer (nếu project đang dùng)
* Resource
* Events
* Jobs

Không lạm dụng:

* Facades
* Global helpers
* Static methods

## Configuration

Không hardcode:

* URL
* API keys
* Tokens
* Credentials
* Feature flags
* Business configuration

Ưu tiên:

* config files
* environment variables

## Paths

Không hardcode:

* Absolute paths
* Machine-specific paths
* Local development paths

Sử dụng framework helpers hoặc configuration.

## Error Handling

Không swallow exception.

Không:

```php
catch (\Exception $e) {
}
```

Luôn:

* Log phù hợp.
* Preserve context.
* Xử lý rõ ràng.

## Logging

* Log đủ context.
* Không log secrets.
* Không log tokens.
* Không log passwords.

Ưu tiên structured logging nếu project hỗ trợ.

## Validation

Validation phải rõ ràng.

Không duplicate validation ở nhiều nơi.

Ưu tiên:

* Request validation
* DTO validation
* Domain validation

theo kiến trúc hiện có.

## Testing

Ưu tiên:

* PHPUnit
* Pest (nếu project dùng)

Test:

* Business behavior
* Business rules
* Edge cases
* Error cases

Không test implementation detail.

## Performance

* Đo đạc trước khi tối ưu.
* Profile trước khi tối ưu.
* Kiểm tra query count.
* Kiểm tra memory usage.

Không tối ưu theo cảm tính.

## Module Boundaries

Tôn trọng module boundaries hiện có.

Không:

* Import xuyên tầng.
* Truy cập internal implementation.
* Tạo dependency không cần thiết.

Ưu tiên:

* Public contracts.
* Public APIs.

## AI Safety Rules

Trước khi viết code:

* Tìm implementation hiện có.
* Tìm service tương tự.
* Tìm controller tương tự.
* Tìm repository tương tự.
* Tìm pattern hiện có.

Ưu tiên tái sử dụng.

Không được:

* Hardcode dữ liệu.
* Hardcode config.
* Hardcode business rules.
* Hardcode permissions.
* Hardcode feature flags.
* Copy-paste logic giữa modules.

Luôn ưu tiên:

* Root cause fix.
* Reusable solution.
* Maintainable solution.

## Large Repository Safety

Khi làm việc trong codebase lớn:

* Hiểu dependency graph trước khi sửa.
* Chỉ sửa phạm vi liên quan đến task.
* Không refactor ngoài phạm vi yêu cầu.
* Không đổi public API nếu không được yêu cầu.
* Cảnh báo nếu thay đổi có thể ảnh hưởng module khác.

## Completion Checklist

Trước khi hoàn thành task:

* Tuân thủ PSR standards.
* Có strict_types.
* Không hardcode.
* Không duplicate logic.
* Không có N+1 query.
* Không query trong loop.
* Không vi phạm module boundaries.
* Error được xử lý phù hợp.
* Có đánh giá edge cases.
* Tuân thủ pattern hiện có của project.

## Laravel Architecture Preservation

Do not introduce:

* Repository Pattern
* Service Layer
* DTO Layer
* CQRS
* DDD

unless the existing project already uses them
or the task explicitly requires them.
