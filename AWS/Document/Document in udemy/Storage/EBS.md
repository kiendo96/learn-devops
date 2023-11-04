## Latency
- Latency is the time between request to storage and the response recived (Độ trễ là thời gian giữa yêu cầu lưu trữ và thời gian phản hồi của nó)
- Latency is measured in units of time (Độ trễ 'latency' được đo bằng thời gian)
=> Có rất nhiều yếu tố gây ra latency: network, low response

## IOPS( input / output per second)
- IOPS is input output operations per second (Các hoạt động input output mỗi giây)
- IOPS are storage measurement of number of I/O operations per second (IOPS là phép đo lưu trữ số lượng thao tác I/O mỗi giây)
=> IOPS đo lường số lượng hoạt động đầu vào/ra trong một giây

## Throughput (Thông lượng)
- Throughput (còn gọi là tốc độ truyền dữ liệu): được sử dụng để đo lượng dữ liệu được truyền đến và đi từ thiết bị lưu trữ(storage) trên mỗi giây
=> Throughput thường được sử dụng để đánh giá khả năng truyền dữ liệu liên tục trên một khoảng thời gian nhất định

## IOPS vs Throughput
- IOPS measures number of read and write operations per second whereas throughput measures how fast number of bytes read or write per second


## What is EBS volume
- An EBS(Elastic Block Store) volume is a network drive you can attack to your instances while they run
- It allows your instances to persist data, even after their termination
- They can only be mounted to one instance at a time (at the CCP level)
    + CPP - Certified Cloud Practitioner : one EBS can be only mounted to one EC2 instance
    + Asociate Level (Solutions Architect, Developer, Sysops): "multi-attach" feature for  some EBS
- They are bound to a specific availability Zone
- Free tier: 30 GB of free EBS storage of type General Purpose(SSD) or Magnetic per month

## Elastic Block Storage(EBS)
- Đặc trưng:
    + Là một cơ chế lưu trữ dạng block
    + Đơn vị quản lý là các EBS volume
    + Chỉ có thể access data khi được gắn vào 1 EC2 instance (Dùng làm ổ root, C: hoặc ổ data)
    + Một số loại EBS đặc biệt cho phép gắn vào nhiều hơn 1 EC2 Storage(Multi attach)
    + Có thể tăng size một cách dễ dàng ngay cả khi server đang chạy (Nhưng không thể giảm size)
- Tính tiền:
    + Dung lượng của volume ($/GB/Month), không dùng cũng mất tiền
    + IOPS: Tốc độ đọc ghi càng cao, càng phát sinh phí cao
    + Dung lượng của các bản snapshot của ổ cứng ($/GB/Month) tuy nhiên giá rẻ hơn lưu trữ

- Các loại EBS thường dùng:
    + General purpose (default): gp2, gp3 phù hợp cho hầu hết các mục đích
    + IOPS Provisioned: io1, io2 phù hợp cho các ứng dụng đòi hỏi tốc độ đọc ghi cao
    + throughput optimized HDD: Dùng cho các hệ thống về Bigdata, Data warehouse, cần throughput cao
    + Cold HDD: Lưu trữ giá rẻ các file khi ít được access
    + Magnetic: thế hệ trước của HDD (ít được sử dụng)

- Throughput: tốc độ truyền tài (gửi/nhận) thông tin tại một thời điểm của một thiết bị
- IOPS: input/output per second

## EBS volume
- It's a network drive:
    + It uses the network to communicate the instance, which means there might be a bit of latency(có thể có một chút độ trễ)
    + It can be detached from an EC2 instance and attached to another one quickly (có thể detach từ 1 EC2 và attach vào 1 EC2 khác)
- It's locked to an Availability Zone (AZ)
    + An EBS Volume in us-east-1a cannot be attached to us-east-1b
    + To move a volume across, you first need to snapshsot it
- Have a provisioned capacity (size in GBs and IOPS)


## EBS - Delete on Termination attribute
- Controls the EBS behavior when an EC2 instance terminates
    + By default, the root EBS volume is deleted (attribute enabled)        //Mặc định thì root volume sẽ bị xóa khi terminate instance. Nhưng có thể disable option này
    + By default, any other attached EBS volume is not deleted (attribute disable)  //Mặc định thì 1 EBS volume được attach thêm vào sẽ không bị xóa khi terminate EC2 instance
- This can be controlled by the AWS console / AWS CLI
- Use case: preserve(giu nguyen/giu lai) root volume when instance is terminated

## EBS Snapshots
- Make a backup(snapshot) of your EBS volume at a point in time
- Not necessary to detach volume to do snapshot, but recommended
- Can copy snapshots across AZ or Region        //Có thể copy snapshot qua các AZ và region khác

## EBS snapshots features
- EBS snapshot archive
    + Move a Snapshot to an "archive tier" that is 75% cheaper  //Chuyển 1 snapshot vào "archive tier" sẽ giúp tiết kiệm 70% chi phí
    + Takes within 24 to 72 hours for restoring the archive     //Tuy nhiên sau khi chuyển snapshot vào "archive tier(tầng lưu trữ)" sẽ mất từ 24 tới 2 giờ để giải nén
- Recycle Bin for EBS Snapshots
    + Setup rules to retain deleted snapshots so you can recover them after an accidental deletion      //Các file snapshot sau khi bị xóa có thể được khôi phục nếu một số rule được thiết lập (same recycle bin on win 10)
    + Specify retention (from 1 day to 1 year)  //Các chỉ định này thường có thời gian lưu giữ từ 1 days to 1 years
- Fast Snapshot Restore (FSR)
    + Force full initialization of snapshot to have no latency on the first use ($$$)   //Tính năng này cho phép (hay buộc) người dùng phải chi tiền ra để có thể khôi phục snapshot ngày lập tức mà không cần phải chờ đợi

## AMI overview
- AMI = Amazon Machine Image
- AMI are a customization of an EC2 instance
    + You add your own software, configuration, operating system, monitoring....
    + Faster boot / configuration time because all your software is pre-packaged
- AMI are built for a specific region (and can be copied across regions)        //AMI được built trên 1 region xác định nhưng có thể copy qua các region khác để sử dụng
    + A Public AMI: AWS provided            //Sử dụng AMI của AWS cung cấp (phổ biến)
    + Your own AMI: you make and maintain them yourself         //Sử dụng AMI cá nhân: Có thể tự tạo tự maintain
    + An AWS Marketplace AMI: an AMI someone else made (and potentially sells)      //Được các người dùng khác cung cấp (cân nhắc khi sử dụng vì có thể dính mã độc)

## AMI process (from an EC2 íntance)
- Start an eC2 instance and customize it
- Stop the instance (for data integrity)
- Build an AMI - This will also create EBS snapshots
- Launch instances from other AMIs

## EC2 instance Store(ephemeral storage)
- EBS volume are network drives with good but "limited" performance     //EBS volume có hiệu năng (performance) tốt nhưng có nhiều hạn chế
- If you need a high-performance hardware disk, use EC2 instance Store      //Nếu cần 1 ổ cứng high-performance hãy sử dụng EC2 instance store
- Better I/O performance        //Hiệu suất I/O của EC2 instance store tốt hơn EBS volume
- EC2 instance store lose their storage if they're stopped (ephemeral)      //Tuy nhiên thằng EC2 instance store này sẽ bị mất storage khi stop hoặc terminate EC2 instance vì nó là ephemeral (giống pod)
- Good for buffer / cache / scratch data / temporary content
- Risk of data loss if hardware fails           //Nguy cơ mất dữ liệu nếu phần cứng bị lỗi
- Backups and Replication are your responsibility           //Backup and replication là trách nhiệm của người dùng


## EBS Volume Types
- EBS Volumes come in 6 types:
    + gp2 / gp3 (SSD): General purpose SSD volume that balances price and performance for a wide variety of workload        //General Purpose SSD volume cân bằng giữa giá cả và hiệu năng cho nhiều khối lượng công việc khác nhau
    + io1/io2 (SSD): Highest-performance SSD volume for mission-critical low-latency or high-throughput workload    //Dung lượng SSD hiệu suất cao nhất dành cho khối lượng công việc quan trọng có low latency hoặc high throughput
    + st1(HHD): Low cost HDD volume designed for frequently accessed, throughput-intensive workload     //HDD nên chi phí thấp và được thiết kế cho khối lượng công việc cần nhiều throughput, truy cập thường xuyên
    + sc1(HDD): Lowest cost HDD volume designed for less frequently accessed workload   //Dung lượng ổ cứng HDD có chi phí thấp nhất được thiết kế cho khối lượng công việc ít được truy cập thường xuyên hơn
- EBS Volumes are characterized in Size | Throughput | IOPS (I/O Ops Per Sec)
- When in doubt always consult the AWS documentation - it's good!
- Only gp2/gp3 and io1/io2 can be used as boot volumes

*General Purpose SSD
- Const effective storage, low-latency      //Chi phí lưu trữ dữ liệu tương đối vừa phải, độ trễ thấp.
- System boot volume, virtual desktops, development and test environments           
- Disk range: 1GiB to 16 TB

- gp3:
    + Baseline of 3000 IOPS and throughput of 125 Mb/s
    + Can increase IOPS up to 16,000IOPS and throughput up to 1000Mb/s independently

- gp2:
    + Small gp2 volumes can burst IOPS to 3,000
    + Size of the volume and IOPS are linked, max IOPS is 16,000
    + 3 IOPS per GB, means at 5334GB we are at the max IOPS

*Privisioned IOPS (PIOPS) SSD
- Critical business applications with sustained IOPS performance or application that need more then 16,000 IOPS  //Thường được sử dụng cho các ứng dụng đặc biệt cần yêu cầu duy trì hiệu suất đọc ghi cao hoặc các ứng dụng cần nhiều hơn 16000 IOPS
- Loại ổ đĩa này đặc biệt phù hợp cho các ứng dụng cơ sở dữ liệu (database) yêu cầu cao về hiệu suất lưu trữ cũng như tính toàn vẹn dữ liệu.
- io1/io2 (4Gb - 16Tb)
    + Max PIOPS: 64,000(IOPS) đối với Nitro Ec2 instance & 32,000(IOPS) for other
    + Can increase PIOPS independently from storage size    //Có thể tăng PIOPS độc lập riêng lẻ với storage size (kiểu có thể tăng IOPS mà không cần tăng size storage)
    + io2 have more durability(do ben) and more IOPS per GiB (at the same price as io1)

- io2 Block Express (4Gb - 64Tb):
    + Sub-millisecond latency   (độ trễ dưới 1 phần ngìn giây)
    + Max PIOPS: 256,000(IOPS) with an IOPS/GiB ratio of 1000:1

- Supports EBS Multi-attach

*Hard Disk Drives (HDD)
- Cannot be a boot volume   //Không thể trở thành boot volume
- Storage size: 125GiB to 16Tb

- Throughput Optimized HDD (st1)
    + Big Data, Data Warehouses, Log Processing
    + Max throughput 500MB/s - max IOPS is 500

- Cold HDD(sc1):
    + For data that is infrequently accessed
    + Scenarios where lowest cost is important



## EBS Multi-Attach - io1/io2 family
- Attach the same EBS volume to multiple EC2 instances in the same AZ       // (io1/io2 family) có thể attach EBS volume tới nhiều EC2 instance trên cùng 1 volume
- Each instance has full read & write permissions to the high-performance volume    //Mỗi EC2 instance sẽ có full quyền read write to EBS volume
- Use case:
    + Achieve higher application availability in clustered Linux applications (ex: Teradata)
    + Applications must manage concurrent write operations

- Up to 16 EC2 Instance at a time       //EBS volume (io1/io2 family) hỗ trợ lên đến 16 EC2 instance vào 1 thời didmer
- Must use a file system that's cluster-awave (not XFS, EXT4, etc...)


## EBS Encryption
- When you create an encrypted EBS volume, you get the following:
    + Data at is encrypted inside the volume
    + All the data in flight moving between the instance and the volume is encrypted
    + All snapshots are encrypted
    + All volumes created from the snapshot
- Encryption and decryption are handled transparently (you have nothing to do)
- Encryption has a minimal impact on latency
- EBS Encryption leverages keys from KMS (AES-256)
- Copying an unencrypted snapshot allows encryption
- Snapshots of encrypted volumes are encrypted


## Encription: encrypt an unencrypted EBS Volume
- Create an EBS snapshot of the volume
- Encrypt the EBS snapshot (using copy)
- Create new EBS volume from the snapshot (the volume will also be encrypted)
- Now you can attach the encrypted volume to the original instance


## Compare EBS vs EFS
+> Elastic Block Storage: Tru thang io1/io2 thi no chi mount duoc 1-1
    - EBS Volumes:
        + One instance (except multi-attach io1/io2)
        + are locked at the AZ level
        + gp2: IO increases if the disk size increases(IO tang -> disk size tang)
        + io1: can increase IO independently(doc lap)
    - To migrate an EBS volume across AZ:
        + Take a snapshot
        + Restore the snapshot to another AZ
        + EBS backups use IO and you shoudn't run them while your application is handling a lot of traffic
    - Root EBS Volumes of instances get terminated by default if the EC2 instance gets terminated (you can disable that)

+> Elastic File System: giong NFS
    - Mounting 100s of instances across AZ
    - EFS share website files (Wordpress)
    - Only for Linux Instance (POSIX)
    - EFS has a higher price point than EBS (EFS gia cao hon EBS)
    - Can leverage EFS-IA for cost savings


# Take node storage EC2 instances
- Snapshot:
    + Được tạo ra từ volume, hay khi khởi tạo 1 AMI
    + Từ snapshot có thể restore -> volume, AMI
    + Snapshot đầu tiên sẽ snapshot toàn bộ, các snapshot sau đó chỉ là phần được thay đổi  của snapshot đầu tiên
        VD: Đầu tiên có 1 EBS 10GB -> lần đầu snapshot full 10GB
            Lần snapshot thứ 2 có 4GB data thay đổi -> Nó chỉ snapshot 4GB thay đổi và map với 6gb trong snapshot cũ
            -> Nếu delete snapshot đầu tiên đi thì nó sẽ copy 6gb data từ snapshot đầu tiên qua snapshot mới nhất ===> vẫn charge phí như 2 snapshot (tổng 10 Gb)
- AMI:
    + Khi create 1 AMI mới có 1 số option cần chú ý:
        + No reboot: Enable or disable - Cho phép reboot server khi snapshot hay không (để bảo toàn dữ liệu)
        + Có thể change size của volume khi create new AMI
        + Có thể bật tắt volume có delete cùng instance khi terminate ko
        + Có thể add thêm volume khi create AMI
        + Khi move AMI từ region A sang region B thì snapshot sẽ được copy theo
