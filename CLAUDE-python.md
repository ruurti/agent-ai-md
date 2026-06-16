# Python Development Guidelines

## Core Principles

* Tuân thủ PEP8.
* Tuân thủ Clean Code.
* Ưu tiên readability hơn clever code.
* Ưu tiên maintainability hơn tối ưu hóa sớm.
* Ưu tiên giải pháp đơn giản nhất đáp ứng yêu cầu.
* Tính đúng đắn quan trọng hơn hiệu năng.
* Hiệu năng chỉ được tối ưu khi có bằng chứng hoặc yêu cầu rõ ràng.

## Existing Codebase First

Khi làm việc trong codebase hiện có:

* Hiểu kiến trúc hiện tại trước khi sửa.
* Tuân thủ pattern đang được sử dụng.
* Tuân thủ convention hiện có của project.
* Tuân thủ dependency boundaries hiện có.
* Ưu tiên consistency hơn sở thích cá nhân.

Không được:

* Tự ý thay đổi kiến trúc.
* Tự ý đổi naming convention.
* Tự ý refactor ngoài phạm vi task.
* Tự ý thay đổi public API.

## Code Structure

* Mỗi module chỉ nên có một trách nhiệm chính.
* Mỗi function chỉ nên có một trách nhiệm rõ ràng.
* Tránh function quá dài.
* Tránh class quá lớn.
* Ưu tiên composition hơn inheritance.
* Tránh abstraction sớm.
* Tránh tạo helper chỉ dùng một lần.
* Tránh tạo class khi function là đủ.

## Naming

* Tên phải mô tả đúng mục đích.
* Không dùng tên mơ hồ như:

  * data
  * obj
  * item
  * temp
  * result
  * value

Trừ khi ngữ cảnh thực sự rõ ràng.

## Clean Code

* Ưu tiên early return.
* Tránh nested condition quá sâu.
* Tránh duplicate logic.
* Tránh side effects không rõ ràng.
* Tránh hàm làm nhiều việc.
* Tránh boolean flag làm thay đổi nhiều hành vi trong cùng một function.

## Imports

* Import phải ở đầu file.
* Không import bên trong function.

Chỉ ngoại lệ khi:

* Lazy loading là cần thiết.
* Dependency rất nặng.
* Đã xác nhận nguyên nhân circular dependency.

Không dùng import trong function để che giấu lỗi kiến trúc.

## Dependency Management

* Tránh circular import.
* Tránh dependency ngược chiều giữa các layer.
* Ưu tiên dependency một chiều.
* Nếu phát hiện circular dependency:

  * Phân tích nguyên nhân kiến trúc.
  * Refactor dependency graph.
  * Không giải quyết bằng workaround tạm thời.

## Module Boundaries

* Tôn trọng ranh giới module.
* Không truy cập internal implementation của module khác.
* Chỉ sử dụng public API.
* Không tạo dependency mới giữa các module độc lập nếu không thực sự cần.
* Không kéo business logic xuyên nhiều module.

## Layer Separation

Tách biệt rõ:

* API Layer
* Service Layer
* Business Logic
* Repository Layer
* Infrastructure Layer

Không để:

* API xử lý business logic.
* Repository chứa business logic.
* Infrastructure điều khiển flow nghiệp vụ.

## Paths And Files

* Không hardcode absolute path.
* Không hardcode path phụ thuộc môi trường.
* Ưu tiên pathlib.Path.
* Cấu hình phải lấy từ config hoặc environment variables.

Không được:

* Hardcode đường dẫn local.
* Hardcode username.
* Hardcode machine-specific configuration.

## Configuration

Tất cả giá trị thay đổi theo môi trường phải nằm trong:

* Config file
* Environment variables
* Secret manager

Không hardcode:

* URL
* API key
* Token
* Password
* Hostname
* Port
* Business configuration

## Type Hints

* Sử dụng type hints cho public API.

* Ưu tiên typing hiện đại:

  * list[str]
  * dict[str, Any]
  * tuple[str, int]

* Không tạo type phức tạp làm giảm readability.

* Type phải hỗ trợ maintainability.

## Dataclasses And Models

Ưu tiên:

* dataclass cho DTO đơn giản.
* Pydantic cho validation và schema.

Không tạo class chỉ để chứa dữ liệu đơn giản nếu dataclass đã đủ.

## Error Handling

* Không bỏ qua exception.
* Không dùng bare except.
* Không swallow exception.

Luôn:

* Bắt exception cụ thể.
* Log đầy đủ context cần thiết.
* Preserve stack trace khi phù hợp.

Ưu tiên:

```python
except SpecificError as exc:
```

Tránh:

```python
except:
```

## Logging

* Logging thay vì print trong production code.
* Log đủ context để debug.
* Không log secrets.
* Không log credentials.
* Không log token.

## Async Programming

* Chỉ dùng async khi có lợi ích rõ ràng.
* Không chuyển code sang async chỉ vì xu hướng.
* Không trộn sync và async một cách tùy tiện.
* Quản lý timeout rõ ràng.

## Database

* Tránh N+1 query.
* Tránh query trong loop.
* Sử dụng transaction khi cần.
* Validation không thay thế constraint của database.

## Testing

Ưu tiên pytest.

Test phải:

* Độc lập.
* Dễ đọc.
* Có thể lặp lại.

Test:

* Behavior.
* Business rules.
* Edge cases.

Không test:

* Internal implementation.
* Chi tiết không ảnh hưởng hành vi.

## Performance

* Đo đạc trước khi tối ưu.
* Benchmark trước khi tối ưu.
* Profile trước khi tối ưu.

Không:

* Tối ưu theo cảm tính.
* Hy sinh readability để tối ưu sớm.

## AI Safety Rules

Trước khi viết code:

* Tìm implementation hiện có.
* Tìm utility hiện có.
* Tìm service hiện có.
* Tìm pattern hiện có.

Ưu tiên tái sử dụng.

Không được:

* Hardcode dữ liệu để pass test.
* Hardcode business rules.
* Hardcode config.
* Hardcode response giả.
* Hardcode URL.
* Hardcode credentials.
* Copy-paste logic giữa các module.
* Viết workaround che giấu bug.

Luôn ưu tiên:

* Root cause fix.
* Reusable solution.
* Maintainable solution.

## Large Repository Safety

Khi làm việc trong monorepo hoặc codebase lớn:

* Hiểu dependency graph trước khi sửa.
* Chỉ sửa phạm vi liên quan đến task.
* Không refactor ngoài phạm vi yêu cầu.
* Không đổi tên package nếu không được yêu cầu.
* Không đổi public API nếu không được yêu cầu.
* Cảnh báo nếu thay đổi có thể ảnh hưởng module khác.

## Completion Checklist

Trước khi hoàn thành task:

* Tuân thủ PEP8.
* Không có circular import.
* Không import trong function.
* Không hardcode.
* Không duplicate logic.
* Không vi phạm module boundary.
* Không tạo dependency không cần thiết.
* Có xử lý lỗi phù hợp.
* Có type hints phù hợp.
* Có test impact assessment.
* Có đánh giá edge cases.

When modifying existing code:
Prefer extending existing patterns over introducing new patterns.
