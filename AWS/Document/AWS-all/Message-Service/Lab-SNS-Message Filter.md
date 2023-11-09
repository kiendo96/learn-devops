# Lab - Thao tác cơ bản với SNS
1. Tạo SNS topic
2. Subscribe một email vào
3. Vào email và confirm subscription
4. Thử push một message lên SNS
5. Kiểm tra email
### Steps:
```
-> Create a topic SNS
    -> Create a subscription with protocol "email"
        -> Access email and subscribe SNS
            -> Back to SNS choose "public message" -> Type subject and message body (Có thể đưa thêm 1 số message attribute Type: String, Name: env, Value: dev) -> publish message
```

# Lab - Message filter
- Ta có 1 topic với 2 subscriber, một là lambda function và một là SQS. Setting mesage filter theo rule nếu có attribute sendTo=Lambda thì gửi sang lambda, nêu sentTo=SQS thì gửi qua SQS

```
publisher ----publish message---> SNS topic ---(1)----> Lambda
                                            |--(2)----> SQS
```

### Steps:
1. Tạo một SNS Topic với setting cơ bản
2. Tạo một Lambda function Python có chức năng in ra message đã notify tới nó
3. Subscribe lambda function vào SNS topic
4. Tạo một SQS với setting cơ bản (có thể sd lại queue ở bài lab trước)
5. Subscribe SQS vào SNS topic
6. Setting message filter tương tứng như đề bài yêu cầu
7. Send message với 2 thuộc tính khác nhau và kiểm tra kết quả