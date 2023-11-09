# Tightly Coupled Architecture
- Đây là một kiến trúc trong đó các thành phần hệ thống liên kết trực tiếp, chặt chẽ với nhau.
- Các thành phần này phụ thuộc lẫn nhau và không thể hoạt động độc lập

# Loosely Coupled Architecture
- Các kiến trúc này thì các thành phần của hệ thống không phụ thuộc lẫn nhau
- Các thành phần có thể hoạt động độc lập và giao tiếp thông qua các dịch vụ

# Compare Tightly Coupling and Loosely Coupling
### Độ phức tạp (Complexity)
- Tightly Coupled Architecture: 
    + Kiến trúc gắn kết chặt chẽ nên thường có cấu trúc phức tạp
    + Các thành phần có thể ảnh hưởng lẫn nhau
    + Manage và scale rất phức tạp
- Loosely Coupled Architecture:
    + Kiến trúc gắn kết thường đơn giản và có tính linh hoạt cao
    + Các thành phần độc lập và không phụ thuộc vào nhau quá nhiều
    + Độ phức tạp thấp hơn Tightly Coupled.
    + Manage và scale từng thành phần bên trong hệ thống riêng rẽ, dễ dàng

### Availability and Reliability
- Tightly Coupled Architecture:
    + Tightly coupled architecture may provide higher availability in some cases
    + Vì các component phục thuộc mạnh mẽ nên việc xử lý lỗi và khắc phục sự cố có thể nhanh chóng và tự ododnjg
    + Tuy nhiên nếu 1 thành phần gặp lỗi thì nó có thể ảnh hưởng đến toàn bộ hệ thống
- Loosely Coupled Architecture:
    + Loosely coupled architecture may provide higher availability in some cases
    + Vì các component độc lập nên lỗi xảy ra với 1 thành phần không ảnh hưởng tới các thành phần khác. Tuy nhiên khó debug
    + Khả năng maintain và scale các component dễ dàng

### Management and Scalability:
- Tightly Coupled Architecture: 
    + Tightly coupled architecture can be more complex to manage and scale. When modifying or upgrading one component, it may be necessary to consider and adjust other components in the system. 
    + This requires careful management and can cause disruptions in the system's operation.
- Loosely Coupled Architecture: 
    + Loosely coupled architecture is simpler and easier to scale. 
    + Independent components can be replaced or expanded without affecting other components. 
    + This increases flexibility and scalability of the system.

### Cost:
- Tightly Coupled Architecture: 
    + Tightly coupled architecture may require more resources and effort to deploy and maintain. 
    + This can increase the operational and management costs of the system.
- Loosely Coupled Architecture: 
    + Loosely coupled architecture generally has lower deployment and management costs. 
    + Due to the independence and potential for reuse of components, deploying and scaling the system can be more flexible and cost-effective.