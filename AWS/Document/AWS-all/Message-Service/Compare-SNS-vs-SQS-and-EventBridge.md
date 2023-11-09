# Feature
- Amazon SNS(Publisher/Subscriber)
- Amazon SQS(Producer/Consumer)
- Amazon EventBridge

### Producer/consumer
- SNS: `Publis/subscribe`
- SQS: `Send/receive`
- EventBridge: `Publish/subscribe`

### Delivery mechanism
- SNS: `Push` (passive)
- SQS: `Poll` (active)
- EventBridge: `Push`

### Distribution model
- SNS: `Many to many`
- SQS: `One to one`
- EventBridge: `One to Many`

### Message persistence
- SNS: `No`
- SQS: `Yes`
- EventBridge: `No`