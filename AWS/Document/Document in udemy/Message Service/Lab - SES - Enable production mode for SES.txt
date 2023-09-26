//Lab - enable production mode for SES
Để có thể gửi email tới bất kì đâu, AWS yêu cầu SES cần được enable production mode. Nếu chưa được bật production mode, bạn chỉ có thể gửi mail trong sand-box mode tức là gửi tới một danh sách email đã đăng ký sẵn

*Để enable production mode, AWS yêu cầu cung cấp 1 số thông tin:
- Nguồn của email lấy từ đâu?
- Email được gửi tong các use case nào? (marketing, email hướng dẫn thông thường). Có thể gửi sample email để AWS duyệt
- Làm sao để user un-subscribe việc nhận email?
- bạn làm sao để hạn chế gửi bounce email (gửi email dến địa chỉ vô định)

=> Sau khi xem xét các yếu tố trên, AWS sẽ cân nhắc có enable production mode cho user của bạn hay không.

**Lưu ý sau khi đã enable production mode cho SES
- Liên tục monitorr chỉ số bounce Rate(chỉ số gửi đến những email không tồn tại), Claim rate (spam quá nhiều và client claim thì chỉ số này sẽ cao) và có alert kịp thời để xử lý
- Theo dõi limit của SES để có action kịp thời yêu cầu nâng limit khi giới hạn gửi mail trong ngày/tuần/tháng bị chạm ngưỡng
