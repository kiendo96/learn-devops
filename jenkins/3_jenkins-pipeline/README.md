
# Cú pháp trong Declarative Pipeline

Tất cả các Đường ống Khai báo hợp lệ phải được bao bọc trong một pipelinekhối, ví dụ:

```
pipeline {
    /* insert Declarative Pipeline here */
}
```

Các câu lệnh và biểu thức cơ bản hợp lệ trong Declarative Pipeline tuân theo các quy tắc sau:

- Cấp cao nhất của Đường ống phải là một khối , cụ thể: `pipeline { }`
- Không có dấu chấm phẩy làm dấu phân cách câu lệnh. Mỗi câu lệnh phải nằm trên một dòng riêng của nó.
- Các khối chỉ được bao gồm các phần khai báo, lệnh khai báo, các bước khai báo hoặc câu lệnh gán.

### post

Có thể tách thành một section, `post` xác định các hành động sẽ được chạy khi kết thúc quá trình chạy Pipeline. Các khối này cho phép thực hiện các bước ở cuối quá trình chạy Pipeline, tùy thuộc vào trạng thái của Pipeline.

- always: Chạy bất kể trạng thái hoàn thành của đường ống chạy.
- changed: Chỉ chạy nếu Pipeline chạy hiện tại có trạng thái khác với Pipeline đã hoàn thành trước đó.
- failure: Chỉ chạy nếu Pipeline hiện tại có trạng thái "không thành công", thường được biểu thị trong giao diện người dùng web bằng chỉ báo màu đỏ.
- success: Chỉ chạy nếu Pipeline hiện tại có trạng thái "thành công", thường được biểu thị trong giao diện người dùng web bằng chỉ báo màu xanh lam hoặc xanh lục.
- unstable: Chỉ chạy nếu Pipeline hiện tại có trạng thái "không ổn định", thường do lỗi kiểm tra, vi phạm mã, v.v. Thường được biểu thị trong giao diện người dùng web bằng chỉ báo màu vàng.

Ví dụ: 

```
// Declarative //
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
    post { (1)
        always { (2)
            echo 'I will always say Hello again!'
        }
    }
}
```

(1) Thông thường, phần `post` này nên được đặt ở cuối pipeline. 

(2) Các khối điều kiện đăng bài có thể sử dụng các steps

### stages

`stages` là nơi chứa phần lớn "công việc" được mô tả trong Pipeline. Tối thiểu, pipeline nên chứa ít nhất một chỉ thị `stages` cho mỗi phần rời rạc của quy trình phân phối liên tục, chẳng hạn như Build, Test, và Deploy.

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    stages { (1)
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

(1) `stages` này thường theo sau các chỉ thị, chẳng hạn như `agent`, `options`, ...

### steps

Xác định một loạt các bước, công việc được thực hiện trong một `stage`

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    stages {
        stage('Example') {
            steps { (1)
                echo 'Hello World'
            }
        }
    }
}
```

(1) Phần steps này phải chứa một hoặc nhiều câu lệnh.

### agent

`agent` chỉ định nơi toàn bộ Pipeline hoặc một `stage` cụ thể sẽ thực thi trong môi trường Jenkins tùy thuộc vào vị trí đặt của cú pháp `agent`. Chỉ thị phải được xác định ở cấp cao nhất bên trong khối `pipeline`, nhưng việc sử dụng ở cấp `stage` là tùy chọn.

**Tham số**

- any: Thực hiện Pipeline, hoặc `stage`, trên bất kỳ agent có sẵn nào. Ví dụ: `agent any`
- none: Khi được áp dụng ở cấp cao nhất của `pipeline`, sẽ không có agent toàn cầu nào được cấp phát cho toàn bộ quá trình Pipeline chạy và mỗi `stage` sẽ cần phải xác định riêng của nó agent. Ví dụ: `agent none`
- label: Thực hiện Pipeline, hoặc `stage`, trên một agent có sẵn trong môi trường Jenkins với nhãn được cung cấp. Ví dụ: `agent { label 'my-defined-label' }`
- node:  `agent { node { label 'labelName' } }` hoạt động giống như `agent { label 'labelName' }`, nhưng `node` cho phép các tùy chọn bổ sung (chẳng hạn như `customWorkspace`).
- docker: Thực thi Pipeline hoặc `stage`, với container đã cho sẽ được cung cấp động trên một node được định cấu hình trước để chấp nhận Pipeline dựa trên Docker hoặc trên một node khớp với thông số được xác định tùy chọn label. Docker cũng có thể tùy chọn chấp nhận một tham số `args`, có thể chứa các đối số để truyền trực tiếp container. Ví dụ: 
`agent { docker 'maven:3-alpine' }` hoặc
```
    agent {
        docker {
            image 'maven:3-alpine'
            label 'my-defined-label'
            args  '-v /tmp:/tmp'
        }
    }
```

- dockerfile: Thực thi Pipeline, hoặc `stage`, với một container được xây dựng từ một Dockerfile trong kho lưu trữ mã nguồn. Thông thường Dockerfile nằm trong thư mục gốc của kho lưu trữ mã nguồn: `agent { dockerfile true }`. Nếu xây dựng một Dockerfile từ một thư mục khác, hãy sử dụng tùy chọn dir: `agent { dockerfile { dir 'someSubDir' } }`.

**Một số các tùy chọn khác**

Đây là một vài tùy chọn cho hai hoặc nhiều cách triển khai `agent` trong pipeline.

- label: Nhãn để chạy Pipeline hoặc `stage`. Tùy chọn này hợp lệ cho `node`, `docker` và `dockerfile`, và là bắt buộc đối với `node`.
- customWorkspace: Chạy Pipeline hoặc `stage`, cho phép tùy chỉnh workspace, đường dẫn làm việc/tương tác với các tệp tin được tải xuống và lưu trữ, thay vì mặc định. Nó có thể là một đường dẫn tương đối, hoặc một đường dẫn tuyệt đối. Tùy chọn này hợp lệ cho `node`, `docker` và `dockerfile`. Ví dụ:
```
    agent {
        node {
            label 'my-defined-label'
            customWorkspace '/some/other/path'
        }
    }
```

**`agent` ở cấp độ `stage`**

```
// Declarative //
pipeline {
    agent none (1)
    stages {
        stage('Example Build') {
            agent { docker 'maven:3-alpine' } (2)
            steps {
                echo 'Hello, Maven'
                sh 'mvn --version'
            }
        }
        stage('Example Test') {
            agent { docker 'openjdk:8-jre' } (3)
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
    }
}
```

(1) Việc xác định `agent none` ở cấp cao nhất của Pipeline đảm bảo rằng các trình thực thi sẽ không được tạo ra một cách không cần thiết. Việc sử dụng `agent none` yêu cầu mỗi `stage` phải chứa một xác định `agent` riêng.

(2) Thực hiện các steps có trong giai đoạn này bằng cách sử dụng vùng chứa đã cho.

(3) Thực hiện các lệnh có trong steps này bằng cách sử dụng docker image.

### environment

Lệnh `environment` chỉ định một chuỗi các cặp khóa-giá trị sẽ được xác định làm biến môi trường cho tất cả các bước hoặc các bước cụ thể theo từng `stage`, tùy thuộc vào vị trí của lệnh trong Pipeline.

Chỉ thị này hỗ trợ một phương thức trợ giúp đặc biệt `credentials()` có thể được sử dụng để truy cập các thông tin đã được tạo trước trong Credentials. Đối với các secret, `credentials()` sẽ đảm bảo rằng biến môi trường được chỉ định chứa nội dung và không làm bộ thông tin trong log của pipeline.

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    environment { (1)
        CC = 'clang'
    }
    stages {
        stage('Example') {
            environment { (2)
                AN_ACCESS_KEY = credentials('my-prefined-secret-text') (3)
            }
            steps {
                sh 'printenv'
            }
        }
    }
}
```

(1)	Một `environment` được sử dụng trong khối cấp cao nhất pipelinesẽ áp dụng cho tất cả các bước trong Pipeline.
(2)	Một `environment` được xác định trong `stage` sẽ chỉ áp dụng các biến môi trường đã cho cho các steps bên trong stage.
(3)	Khối `environment` có một phương thức trợ giúp `credentials()` được xác định có thể được sử dụng để truy cập các secret được xác định trước trong Credential bằng mã định danh của chúng trong môi trường Jenkins.

### options

Lệnh `options` cho phép định cấu hình các tùy chọn dành riêng cho Pipeline từ bên trong chính Pipeline. Pipeline cung cấp một số tùy chọn này, chẳng hạn như buildDiscarder, nhưng chúng cũng có thể được cung cấp bởi các plugin, chẳng hạn như timestamps.

**Các `options` có sẵn**

- buildDiscarde: Lưu trữ artifact và console output cho số lần chạy Pipeline cụ thể gần đây. Ví dụ: `options { buildDiscarder(logRotator(numToKeepStr: '1')) }`
- disableConcurrentBuild: Không cho phép thực thi đồng thời Pipeline. Có thể hữu ích để ngăn truy cập đồng thời vào tài nguyên được chia sẻ,... Ví dụ: `options { disableConcurrentBuilds() }`
- skipDefaultCheckout: Bỏ qua việc tải về mã nguồn theo mặc định. Ví dụ: `options { skipDefaultCheckout() }`
- timeout: Đặt khoảng thời gian chờ cho Pipeline chạy, sau khoảng thời gian này nếu Pipeline vẫn không thành công, Jenkins sẽ hủy bỏ Pipeline. Ví dụ: `options { timeout(time: 1, unit: 'HOURS') }`
- retry: Nếu không thành công, thử lại toàn bộ Pipeline với số lần đã chỉ định. Ví dụ: `options { retry(3) }`
- timestamps: Thêm vào trước tất cả log của console output được tạo bởi Pipeline với dấu thời gian. Ví dụ: `options { timestamps() }`

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') (1)
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

(1) Chỉ định thời gian chờ thực thi toàn cầu là một giờ, sau đó Jenkins sẽ hủy bỏ quá trình chạy Pipeline.
	
### parameters

Lệnh `parameters` cung cấp danh sách các tham số mà người dùng nên cung cấp khi kích hoạt Pipeline. Các giá trị cho các tham số do người dùng chỉ định này được cung cấp cho các bước của Pipeline thông qua đối tượng `params`. Trước khi thực hiện build, người dùng cần cung cấp các giá trị hoặc pipeline sẽ sử dụng giá trị mặc định. Hãy xem ví dụ để biết cách sử dụng cụ thể của nó

**Các `parameters` có sẵn**

- string: Một tham số string, ví dụ: `parameters { string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: '') }`
- booleanParam: Một tham số boolean, ví dụ: `parameters { booleanParam(name: 'DEBUG_BUILD', defaultValue: true, description: '') }`

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    }
    stages {
        stage('Example') {
            steps {
                echo "Hello ${params.PERSON}"
            }
        }
    }
}
```

### triggers

Chỉ thị `triggers` xác định các cách tự động để kích hoạt lại Pipeline. Đối với Pipeline được tích hợp với một nguồn như GitHub hoặc Bitbucket, `triggers` có thể không cần thiết vì có thể đã có tích hợp dựa trên webhooks. Hiện tại chỉ có hai trình kích hoạt khả dụng là `cron` và `pollSCM`.

- cron: Chấp nhận một chuỗi kiểu cron để xác định một khoảng thời gian đều đặn mà tại đó Pipeline sẽ được kích hoạt lại, ví dụ: `triggers { cron('H 4/* 0 0 1-5') }`
- pollSCM: Chấp nhận một chuỗi kiểu cron để xác định một khoảng thời gian đều đặn mà tại đó Jenkins nên kiểm tra các thay đổi trong source. Nếu các thay đổi mới xuất hiện, Pipeline sẽ được kích hoạt lại. Ví dụ: `triggers { pollSCM('H 4/* 0 0 1-5') }`. Trình pollSCM kích hoạt chỉ có sẵn trong Jenkins 2.22 trở lên.

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    triggers {
        cron('H 4/* 0 0 1-5')
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

### stage

Chỉ thị `stage` đi sau `stages` và phải chứa chỉ thị `steps`. Có thể có chỉ thị `agent` hoặc các chỉ thị khác dành riêng cho từng `stage`. Nói một cách thực tế, tất cả các công việc thực sự được thực hiện bởi một Pipeline sẽ được gói gọn trong một hoặc nhiều `stage`.

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

### tools

Một phần xác định các công cụ để tự động cài đặt và đưa vào `PATH`. Tools sẽ không có nghĩa nếu `agent none` được chỉ định.

**Các công cụ được hỗ trợ**

- maven
- jdk
- gradle

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    tools {
        maven 'apache-maven-3.0.1' (1)
    }
    stages {
        stage('Example') {
            steps {
                sh 'mvn --version'
            }
        }
    }
}
```

(1)	Tên công cụ phải được định cấu hình trước trong Jenkins, trong **Manage Jenkins** → **Global Tool Configuration**.

### when

Lệnh when cho phép Pipeline xác định xem stage có nên được thực thi hay không tùy thuộc vào điều kiện đã cho.

**Các điều kiện có sẵn**

- branch: Thực thi stage khi nhánh được tạo khớp với pattern đã cho, ví dụ: `when { branch 'default' }`
- environment: Thực thi stage khi biến môi trường được chỉ định được thiết lập bằng giá trị đã cho, ví dụ: `when { environment name: 'DEPLOY_TO', value: 'production' }`
- expression: Thực thi stage khi biểu thức Groovy được chỉ định có kết quả là true, ví dụ: `when { expression { return params.DEBUG_BUILD } }`

Ví dụ:

```
// Declarative //
pipeline {
    agent any
    stages {
        stage('Example Build') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Example Deploy') {
            when {
                branch 'production'
            }
                echo 'Deploying'
            }
        }
    }
}
```

### script

`script` này thực hiện một khối scripted pipeline và thực thi điều đó trong declarative pipeline. Đối với hầu hết các trường hợp sử dụng, `script` này sẽ không cần thiết trong declarative pipeline, nhưng nó có thể cung cấp một "lối thoát" hữu ích. Thay vì sử dụng `script`, các khối có kích thước không nhỏ và / hoặc độ phức tạp sẽ được chuyển vào Thư viện được chia sẻ.

```
// Declarative //
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'

                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser"
                    }
                }
            }
        }
    }
}
```
