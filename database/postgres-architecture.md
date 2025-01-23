# Shared memory
- Là bộ nhớ dành riêng cho lữu trữ cơ sở dữ liệu và nhật ký giao dịch.
- Các thành phần quan trọng của shared memory như là:
  + Shared Buffer
  + WAL Buffer
  + CLOG Buffer
  + Temp Buffer
  + Work Memory
  + Vacuum Buffer

### Shared Buffer
- Thao tác đọc và ghi trong bộ nhớ luôn nhanh hơn bất kỳ thao tác nào khác vậy nên cơ sở dữ liệu luôn cần bộ nhớ để truy cập nhanh dữ liệu
- Shared buffer được điều khiển bởi tham số `shared_buffers`
- Dung lượng RAM được cấp cho shared buffer sẽ là cố định trong suốt thời gian chạy Postgresql
- Shared buffer có thể được truy cập bởi tất cả tiến trình server và client kết nôi đến db
- Dữ liệu được ghi hay chỉnh sửa trong shared buffer được gọi là `dirty data` và các đơn vị thao tác trong csdl block(hay page) thay đổi được gọi là `dirty block` hay `dirty page`
- Dirty data sẽ được ghi vào file vật lý liên tục trên ổ đĩa, các file này được gọi là `file dữ liệu (data file)`
- Mục đích của shared buffer là để giảm thiểu các tác vụ I/O disk. Để đạt được mục đích này thì phải đáp ứng các yêu cầu sau:
  + Phải truy cập bộ nhớ đệm lớn (hàng chục, hàng trăm gigabites) nhanh chóng
  + Tôi thiểu hóa xung đột khi nhiều người dùng truy cập cùng lúc
  + Các blocks được sử dụng thường xuyên phải ở trong bộ nhớ đệm càng lâu càng tốt


### WAL Buffer
- WAL buffer hay còn được gọi là `transaction log buffers`
- WAL Buffer là bộ nhớ đệm để lưu trữ dữ liệu WAL
- Dữ liệu WAL là thông tin về những thay đổi đối với dữ liệu thực tế và dùng để tạo lại dữ liệu trong quá trình sao lưu và phục hồi cơ sở dữ liệu
- Dữ liệu WAL được ghi trong file vật lý ở các vị trí liên tục gọi là `WAL Segments` hoặc `checkpoint segments`
- WAL buffer được điều khiển bởi tham số  `wal_buffers`, nó được cấp phát bởi RAM của hệ điều hành
- WAL Buffer có thể được truy cập bởi tất cả tiến trình server và client nhưng nó không phải là một phần của `shared buffer`
- WAL Buffer nằ ngoài shared buffer và rất nhỏ so với shared buffer. Default `wal_buffers = 1/6 shared_buffers`
- Dữ liệu WAL lần đầu tiên sửa đổi sẽ được ghi vào WAL Buffer trước khi được ghi vào WAL Segments trên ổ đĩa

### CLOG Buffer
- CLOG Buffer là viết tắt của `commit log`
- CLOG Buffer là bộ đệm dành riêng cho lưu trữ các trang commit log được cấp phát bởi RAM của hệ thống
- Các trang commit log chứa nhật ký về giao dịch và các thông tin khác từ dữ liệu WAL
- Các commit log chứa trạng thái commit của tất cả giao dịch và cho biết một giao dịch đã thành công hay chưa
- Không có tham số cụ thể để kiểm soát vùng nhớ này. Sẽ có công cụ cơ sở dữ liệu tụ động quản lý với số lượng rất nhỏ.
- Đây là thành phần nhớ dùng chung, có thể truy cập bởi tất cả tiến trình server và client access

### Memory for Lock
- Được sử dụng để lưu trữ tất cả các khóa `lock` nặng được sử đụng bởi Postgres.
- Các khóa này được chia sẻ trên tất cả các tiến trình server hay user kết nối đến csdl
- Một thiết lập (not default) giữa hai tham số là `max_locks_per_transaction` và `max_pred_locks_per_transaction` sẽ ảnh hưởng theo một cách nào đo đến kích thước của bộ nhớ này

### Vacuum Buffer
- Đây là lượng bộ nhớ tối đa được sử dụng cho mỗi tiến trình autovacuum worker, được điều khiển bởi tham số `autovacuum_work_mem`
- Bộ nhớ được cấp phát bởi RAM của hệ điều hành
- Tất cả thiết lập tham số chỉ có hiệu quả khi tiến trình auto vacuum được bật, nếu không các thiết lập này sẽ không ảnh hưởng đến VACUUM đang chạy ở ngữ cảnh khác
- Thành phần nhớ này không được chia sẻ bởi bất kỳ tiến trình máy chủ hay người dùng nào

### Work Memory
- Đây là bộ nhớ dành riêng cho một thao tác sắp xếp hoặc bảng băm cho một truy vấn nào đó
- Được điều khiển bởi tham số  `work_mem`
- Thao tác sắp xếp có thể là `ORDER BY`, `DISTINCT` hay `MERRGE JOIN`
- Thao tác trên bảng băm có thể là `hash-join` hoặc truy vấn `IN`
- Các câu truy vấn phức tạp hơn như nhiều thao tác sắp xếp hoặc nhiều bảng băm có thể được cấp phát bởi tham số `work_mem`. Vì lý do đo không nên khai báo `work_mem` với giá trị quá lớn, vì nó có thể dẫn đến việc sử dụng vùng nhớ của hệ điều hành chỉ cho một câu truy vấn lớn, khiến hệ điều hành thiếu RAM cho các process cần thiết

### Maintenance Work Memory
- Đây là lượng nhớ tối đa mà RAM sử dụng cho các hoạt động bảo trì `maintenance`
- Các hoạt động bảo trì có thể là: `VACUUM`, `CREATE INDEX` hay `FFOREIGN KEY` và được kiểm soát bởi tham số `maintenance_work_mem`
- Một phiên cơ sở dữ liệu chỉ có thể thực hiện bất kỳ hoạt động bảo trì nào đã đề cập ở trên tại một thời điểm và Postgres thường không thực hiện đồng thời nhiều hoạt động bảo trì 1 lúc. Do đó tham số này có thể thiết lập lớn hơn nhiều so với tham số `work_mem`
```
Lưu ý: Không thiết lập giá trị cho tham số này quá cao, giá trị này sẽ phân bổ nhiều phần cấp phát bộ nhớ như được xác định bởi tham số `autovacuum_max_workers` trong trường hợp không định cấu hình tham số `autovacuum_work_mem`
```

### Temp Buffer
- Các cơ sở dữ liệu cần một hay nhiều bảng mẫu và các block(page) của bảng mẫu này cần nơi để lưu trữ
- Temp buffer sinh ra nhằm mục địch này, bằng cách sử dụng một phần RAM, được xác định bởi tham số `temp_buffer`
- Temp buffer chỉ được sử dụng để truy cập bảng tạm thời trong phiên người dùng.
- Không có liên hệ gì giữa temp buffer với các file mẫu được tạo trong thư mục `pgsql_tmp` để thực hiện sắp xếp lớn hay bẳng băm

# Các loại tiến trình trong POSTGRESQL
- PostgreSQL có bốn loại tiến trinhf:
  + Postmaster(Daemeon) Process
  + Backgound process
  + Backend process
  + Client process

### Postmaster Process
- Là tiến trình đầu tiên khởi tạo sau khi postgresql khỏi động. 
- Tiến trình này đảm nhiệm việc khởi động hoặc dừng các tiến trình khác nêu cần hoặc có yêu cầu
- Sau khi postmaster khởi động nó sẽ khởi động các background process
- Sử dụng `pstree -p postgre_process_id` sẽ thấy postmaster là tiến trình cha của các thằng còn lại

### Background process
- `logger`: Tiến trình này đảm nhận việc ghi log của postgresql
- `checkpointer`: Tiến trình này chủ yếu giữ vai trò thực hiện checkpoint (đồng bộ dữ liệu từ bộ nhớ đệm xuống vùng lưu trữ) khi cần thiết
- `writer`: Tiến trình này kết hợp với `checkpointer` để  đảm bảo việc ghi dữ liệu từ bộ đệm xuống vùng lưu trữ. Thông thường khi checkpoint không hoạt động, tiến trình này sẽ ghi từng chút một dữ liệu xuống vùng lưu trữ
- `wal writer`: Đảm nhiệm việc đồng bộ WAL từ bộ nhớ đệm xuống vùng lưu trữ
- `autovacuum launcher`: Tiến trình này hoạt động khi tham số `autovacuum = on`. Nó thực hiện chức năng tự động lấy vùng dữ liệu dư thừa sau khi DELETE hoặc UPDATE dữ liệu. Tiến trình này khởi động các VACUUM worker process sau mỗi `autovacuum_naptime`. Các VACUUM worker processes sẽ thực hiện việc VACUUM dữ liệu trên các database
- `stats collector`: Tiến trình này thực hiện vai trò lưu trữ các thông tin thống kê hoạt động của Postgres và cập nhật vào các system catalog (thông tin nội bộ của postgres hiện diện bởi các bảng `pg_stat_all_tables` hoặc `pg__stat_activity`)

### Backend Process
- Số lượng tối đa backend process được thiết lập bởi tham số `max_connections` có giá trị default là 100.
- Backend process thực hiện yêu cầu truy vấn của user process, sau đó truyền kết quả. Một số cấu trúc bộ nhớ được yêu cầu để thực thi truy vấn, được gọi là bộ nhớ cục bộ (local memory)
- Các tham số chính liên quan đến bộ nhớ cục bộ là:
  + `work_mem`: được sử dụng cho điều chỉnh work memory. Thiết lập mặc định là 4MB
  + `maintenance_work_mem`: được sử dụng cho điều chỉnh maintenance work memory. Thiết lập mặc định là 64MB
  + `temp_buffers`: được sử dụng cho điều chỉnh Temp Buffer. Default config is 8MB

### Client Process
- Client process đề cập đến background process được chỉ định cho một kết nôi với người dùng. Thông thường, postmaster process sẽ phân ra một tiến trình con dành riêng phục vụ cho client connect

# Cấu trúc database
- Database Cluster gồm:
  + Users/Group
  + Tablespaces
  + Database gồm:
    + System catalogs
    + Extentions
    + Schema gồm:
      + Table
      + View
      + Sequence
      + Function
      + Trigger.....

## Database cluster
- Là đơn vị lưu trữ lớn nhất của một postgresql database server
- Database cluster được tạo bằng câu lệnh: `initdb()`
- DB cluster bao gồm các file config: postgresql.conf, pg_hba.conf.... và các đối tượng lưu trữ đều nằm trong database cluster

## Databases
- Là đơn vị lớn thứ 2 sau database cluster
- Để thực hiện câu lệnh truy vấn, bạn cần phải truy cập vào một databases nào đó. 
- Khi `initdb()` thực thi, mặc định postgresql sẽ tạo ra 3 csdl là template0, template1 và postgres

### template0
- Là cơ sở dữ liệu mẫu
- Không thể truy nhập và chỉnh sửa các đối tượng trọng đo
- Người dùng có thể tạo database mới dựa trên template0 này bằng cách chỉ định template trong câu lệnh `create database`

### template1
- Là cơ sở dữ liệu mẫu
- Người dùng có thể truy cập và chỉnh sửa các đối tượng trong đó
- Khi thực hiện câu lệnh `create database`, postgresql sẽ copy template1 này để tạo database mới

### postgres
- Cở sở dữ liệu mặc định của Postgresql khi tạo database cluster

## Tablespace
- Là đơn vị lưu trữ dữ liệu về phương diện vật lý bên dưới database
- Thông thường dữ liệu vật lý được lưu trữ tại thư mục dữ liệu (nơi chỉ định lúc initdb())
- Nhưng có một phương pháp lưu trữ dữ liệu ngoài phân vùng này, nhờ sử dụng chức năng TABLESPACE
- Khi tạo một TABLESPACE tức là ta đã tạo ra một vùng lưu trữ dữ liệu mới đọc lập với dữ liệu bên dưới thư mục. Điều này giảm thiểu được disk I/O cho phân vùng thư mục dữ liệu( nếu trong các hệ thống cấu hình RAID, hay hệ thống có 1 đĩa cứng thì không có hiệu quả)

## Schema
- Là đơn vị lưu trữ bên dưới database, quản lý dữ liệu dưới dạng logic
- Mặc định mỗi database sẽ có một schema cho người dùng, đo là schema public
- Ta có thể tạo schema bằng câu lệnh `CREATE SCHEMA`
- Đặc điểm của 1 schema như sau:
  + Có thể sử dụng tên trùng với schema ở database khác nhưng không trùng tên trên cùng database
  + Ngoài TABLESPACE và user ra, schema có thể chứa hầu hết các đối tượng còn lại như: table, index, sequence, constraint....
  + Để truy cập schema ta có thể thêm tên schema vào phía trước đối tượng muốn truy cập hoặc sử dụng tham số `search_path` để thay đổi schema truy cập hiện tại
  + Schema có thể sử dụng với các mục đích như tăng cường bảo mật, quản lý dữ liệu dễ dàng hơn

## Table
- Table là đối tượng lưu dữ liệu từ người dùng
- Một bảng bao gồm 0 hoặc nhiều column tương ứng với từng kiểu dữ liệu khác nhau của postgres
- Tổng quan có 3 kiểu tables mà postgres hỗ trợ:
  + `unlogged table`: là kiểu table mà các thao tác đối với bảng dữ liệu này không được lưu trữ vào WAL. Tức là không có khả năng phục hồi nếu bị corrupt
  + `temporary table`: là kiểu table chỉ được tạo trong phiên làm việc đó. Khi connection bị ngắt, nó sẽ tự động mất đi
  + `default table`: Khác với 2 kiểu table trên, là loại table thông thường để lưu trữ dữ liệu. Có khả năng phục hồi khi bị corrupt và tồn tại vĩnh viễn nêu không có thao tác xóa bỏ nào

# Cấu trúc thư mục
- Trên Linux và Unix được cài tại thư mục `/usr/local/pgsql` hoặc `/var/lib/pgsql`
- Các file cấu hình và database được tổ chức ngay trong thư mục data, thể hiện qua biến môi trường `$PGDATA`
- Ta có bảng ý nghĩa các file:
  + `PG_VERSION`: File chưa phiên bản hiện tại của postgres
  + `base`: thư mục con chứa cơ sở dữ liệu, trong thư mục này chứa các thư mục con nữa cho mỗi database
  + `current_logfile`: File ghi các file log được ghi bởi logging collector
  + `global`: Thư mục con chứa các bảng nội bộ, chẳng hạn như pg_database
  + `pg_commit_ts`: Thư mục con chứa thông tin về trạng thái commit của dữ liệu timestamp
  + `pg_dynshmem`: Thư mục con chứa các file sử dụng dynamic shared memory
  + `pg_logical`: Thư mục con chứa trạng thái dữ liệu sử dụng trong chức năng logical decoding
  + `pg_multixact`: Thư mục con chứa dữ liệu trạng thái multitransaction (sử dụng cho locks mức độ dòng dữ liệu)
  + `pg_notify`: Thư mục con chứa dữ liệu về chức năng LISTEN/NOTIFY
  + `pg_replslot`: Thư mục con chứa dữ liệu về replication slot
  + `pg_serial`: Thư mục con chứa thông tin về các transaction commited ở mức độ phân li serializable
  + `pg_snapshots`: Thư mục con chứa thông tin về các snapshots đã xuất.
  + `pg_stat`: Thư mục con chứa các files thông tin thống kê về postgres đang được sử dụng hiện tại
  + `pg_stat_tmp`: Thư mục con chứa các files thông tin thống kê về postgres tạm thời
  + `pg_subtrans`: Thư mục con chứa dữ liệu về các subtransaction 
  + `pg_tablspc`: Thư mục con chứa thông tin symbolic links tới các tablespaces
  + `pg_twophase`: Thư mục con chứa các tập tin trạng thái cho các prepared transactions
  + `pg_wal`: Thư mục con chứa các file WAL(Write Ahead Log)
  + `pg_xact`: Thư mục con chứa thông tin về trạng thái commit của dữ liệu
  + `postgresql.auto.conf`: File lưu trữ các thông số cấu hình được thiết lập bởi ALTER SYSTEM
  + `postmaster.opts`: File này chứa thông tin về các tùy chọn lần cuối của lệnh khởi động PostgreSQL
  + `postmaster.pid`: File này tạo khi khởi động postgresql và mất đi khi shutdown Postgresql. File chứa thông tin về PID của postmaster process, đường dẫn thư mục dữ liệu, thời gian khởi động, port, đường dẫn Unix-domain socket. Giá trị hiệu lực đầu tiên chỉ định trong tham số  `listen_address` và segment ID shared memory (Tạo lúc khởi động Postgresql)

# Vacuum
- Khác với các RDBMS khác như MYSQL, khi dùng chạy lệnh DELETE hay UPDATE, Postgresql không xóa dữ liệu cũ đi luôn mà chỉ `đánh dấu đó là dữ liệu đã bị xóa`. Nên nếu liên tục `insert/delete` hoặc `update` dữ liệu mà không có cơ chế xóa dữ liệu dư thừa thì dung lượng ổ cứng tăng dẫn đến full
- Postgres sử dụng 32bit Transaction ID(XID) để quản lý transaction. Mỗi một record dữ liệu đều có thông tin về XID. Khi dữ liệu này được tham chiếu postgresql sử dụng thông tin XID này so sánh với XID hiện tại để dánh giá dữ liệu này có hữu hiệu không. Dữ liệu đang tham chiêu có XID lớn hơn XID hiện tại là dữ liệu không hữu hiệu. Khi sử dụng hết 32 bit XID (khoảng 4 tỷ transactions), để sử dụng tiếp XID sẽ được reset về ban đầu(0). Nêu không có cơ chế chỉnh lại XID trong data thì mỗi lần reset XID, dữ liệu hiện tại sẽ trống trơn (dữ liệu hiện tại luôn có XID lớn hơn XID đã reset (0))
- Như vậy vacuum được sử dụng để giải quyết những vấn đề :
  + Lấy lại dữ liệu dư thừa để tái sử dụng
  + Cập nhật thông tin thống kê (statistics)
  + Giải quyết vấn đề dữ liệu bị vô hiệu khi Wraparound Transaction ID

### Lấy lại dữ liệu thừa
- Như đã biết, postgres chưa xóa dữ liệu cũ khi thực hiện thao tác DELETE/UPDATE. Khi vacuum, những dữ liệu dư thừa đo sẽ được lấy lại và vị trí dư thừa sẽ được cập nhật lại trong bảng vị trí trống (Free Space Map(FSM)).
- Ngoài ra những block dữ liệu đã được VACUUM sẽ được đánh dấu là đã VACUUM trên bảng khả thị (Visiblity Map(VM)), khi UPDATE/DELETE dữ liệu bảng khả thị sẽ cấp lại trạng thái là cần VACUUM
```
Free space map (FSM): Mỗi bảng dữ liệu (hoặc index) tồn tại tương ứng một FSM. FSM chứ thông tin các vị trí trống trong file dữ liệu. Khi dữ liệu mới được ghi postgres sẽ nhìn vị trí trống từ FSM trước, việc này giảm thiểu truy cập trực tiếp (sinh I/O disk) vào file dữ liệu. File FSM nằm cùng vị trí với file dữ liệu và có tên là file_du_lieu_fsm
```

```
Visibility Map(VM): Mỗi bảng dữ liệu tồn tại tương ứng một visibility map(VM). Một block dữ liệu tương ứng với 1 bit trên VM. VACUUM xem trước thông tin VM của bảng dữ liệu và chỉ thực hiện trên những block cần được vacuum. File VM nằm cùng vị trí với file dữ liệu và có tên = file_du_lieu_vm
```


