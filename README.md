# protoc-gen-go-errors

这是一个用于 Kratos 框架的错误处理代码生成工具，可以通过 protobuf 定义自动生成统一的错误处理代码。

## 功能特性

- 支持通过 protobuf enum 定义错误码
- 支持设置默认错误码和错误信息
- 支持国际化（i18n）错误消息
- 支持错误堆栈追踪
- 支持错误格式化
- 支持错误元数据

## 安装

```bash
go install github.com/fzf-labs/protoc-gen-go-errors/v2@latest
```

## 使用方法

### 1. 定义错误码

在 proto 文件中使用 enum 定义错误码：

```protobuf
syntax = "proto3";

package api.example.v1;

import "errors/errors.proto";

option go_package = "example/v1;v1";

enum ErrorReason {
  option (errors.default_code) = 500;
  option (errors.default_message) = "UNKNOWN";
  option (errors.default_i18n) = {
    zh_CN: "未知错误"
    en_US: "Unknown error"
  };

  BAD_REQUEST = 0 [(errors.code) = 400, (errors.message) = "BAD_REQUEST", (errors.i18n) = {
    zh_CN: "错误的请求"
    en_US: "Bad request"
  }];
  UNAUTHORIZED = 1 [(errors.code) = 401, (errors.message) = "UNAUTHORIZED", (errors.i18n) = {
    zh_CN: "未经授权"
    en_US: "Unauthorized"
  }];
}
```

### 2. 生成错误处理代码

运行以下命令生成错误处理代码：

```bash
protoc --proto_path=. \
       --go_out=paths=source_relative:. \
       --go-errors_out=paths=source_relative:. \
       your_error.proto
```

### 3. 使用生成的错误处理代码

```go
// 创建错误
err := ErrorReasonUserNotFound().Error()

// 带有错误原因
err := ErrorReasonUserNotFound(WithError(fmt.Errorf("数据库查询失败"))).Error()

// 格式化错误消息
err := ErrorReasonInvalidUsername(WithFmtMsg("admin")).Error()

// 使用国际化
err := ErrorReasonInvalidUsername(WithI18N("en_US")).Error()

// 包含错误堆栈
err := ErrorReasonUserNotFound(WithLine()).Error()
```

## 错误处理选项

- `WithError(err error)`: 设置错误原因
- `WithFmtMsg(args ...interface{})`: 格式化错误消息
- `WithLine()`: 添加错误堆栈信息
- `WithI18N(lang string)`: 设置错误消息语言

## 支持的语言代码

- zh_CN: 中国大陆简体中文
- zh_TW: 台湾繁体中文
- en_US: 美国英语
- ja_JP: 日本日语
- ko_KR: 韩国韩语
- ... (更多语言支持请参考 errors.proto)

## 注意事项

1. 错误码范围必须在 0-600 之间
2. 建议按照业务模块划分错误码区间
3. 错误消息应该简洁明确

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！