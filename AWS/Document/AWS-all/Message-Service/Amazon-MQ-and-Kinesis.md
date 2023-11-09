# Amazon MQ
- Managed message broker duoc xay dung dua tren Apache ActiveMQ
- Don gian hoa message migration to cloud
- Tuong thich voi cac chuan API va giao thuc danh cho message queue: `JMS, NMS, AMQP, STOMP, MQTT, WebSockets`

# Amazon MQ Usecase
```
Message producer is on-premises(On-premise message producer ---> On-premise ActiveMQ Broker) ----> AWS Cloud (Amazon MQ  ---> Cloud-based message consumer)
```
- Trong do:
    + Message produces is on-premises: Corporate data center
    + Message consumer is cloud-based: AWS Cloud

# Compare MQ vs SQS,SNS
### Amazon MQ
- For application migration
- Protocal: JMS, NMS, AMQP, STOMP,MQTT, WebSocket
- Feature-rich
- Pay per hour and pay per GB
### Amazon SQS & SNS
- For born-in-the-cloud application
- Protocals: HTTPS
- Nearly unlimited throughput
- Pay per request

# Amazon Kinesis
- Mot nhom service phuc vu cho bai toan data streaming
- Cung cap kha nang realtime intergrate hang Gigabyte data from multiple source
- Kinesis services:
    + Kinesis Video Streaming
    + Kinesis Data Stream
    + Kinesis Data Firehose

### Kinesis Video Stream
### Case study
- Smart home:
    + Monitor children
    + Camera an ninh
    + Smart lightning
- Smart city:
    + Camera giao thong
    + Ngan chan toi pham
- Industrial automation:
    + Predictive maintenance
### Topology
```
Input ----> Kinesis Video Streams ----> Output[Amazon Rekognition Video, Amazon SageMaker, MxNet/TensorFlow, HLS-based media playback, Custom media processing]
```
- Trong do:
    + Input: Stream media from camera devices to AWS using the Kinesis Video Streams SDKs
    + Kinesis Video Streams: Ingest, durably store, encrypt, and index media streams for real-time playback, analytics, and machine learning
    + Output: Real-time and batch-driven machine learning applications, media processing and playback services use Kinesis Video Stream API to access and retrieve indexed media

### Kinesis Data Stream
>Receive data and ship to different service process the data

### Case Study
1. Stream log & event data
2. Run real-time analytics
3. Event-driven applications

### Topology
```
Input[AWS services, Microservices, Logs, Mobile apps and sensors] ---> Kinesis Data Streams ---> Output[AWS Lambda, Kinesis Data Analytics, Kinesis Data Firehose, Containers]
```
- In there:
    + Input: Capture and send data from multiple sources into Amazon Kinesis Data Streams
    + Kinesis Data Streams: Easily stream data at any scale
    + Output: Build streaming data applications using AWS services, open source framework, and custom applications

### Kinesis Data Firehose
>Receive data, then process the data and return ouput to dashboard

### Case Study
1. Stream into data lakes & data warehouse
2. Boost security
3. Build ML streaming applications

### Topology
```
Input --> Ingest ---> Amazon Kinesis Data Firehose -----> Load ---> Output
                                |
                                v
                        Transform - Optional
```
- In there:
    + Input: Logs, clickstreams, IOT, financial data, sales, orders and more
    + Ingest: AWS SDK, Amazon Kinesis Data Streams, Amazon Kinesis Agent, 20+ AWS Services, Open Source Agent
    + Kinesis Data Firehose: Fully managed ingest, transform, load (ITL) solution with no code required
    + Tranform(This is optional): AWS Lambda custom tranformations, Built-in transformations
    + Load: S3, Amazon Redshift, Opensearch Service, Amazon API Gateway, Splunk, 6+ HTTP endoint partners
    + Output: Analyze streaming data using interactive query services(Amazon Athena, Amazon Redshift Spectrum) or analytics tools

### Compare Kinesis vs SQS
```
________________________________________________________________________________________
|        Service          | Transforms data |  Maximum retention |        Model         |
|         SQS             |      No         |       14 days      | Producer - Consumer  |
| Kinesis Video Stream    |      No         |       7 days       | Producer - Consumer  |
| Kinesis Data Streams    |      No         |       7 days       | Producer - Consumer  |
| Kinesis Data Firehose   |      Yes        |      14 days       | Source - Destination |
|_______________________________________________________________________________________|
```
>SQS danh cho message queue
>Kinesis danh cho data stream
