package message

type CommonResult = string
type LoginResult = string
type LogoutResult = string
type RegisterResult = string
type BookResult = string

const (
	RequestSucceed CommonResult = "请求成功"
)

const (
	LoginSucceed    LoginResult = "登录成功!"
	NonExistentUser LoginResult = "不存在的用户!"
	WrongPassword   LoginResult = "密码错误!"
	AlreadyLogin    LoginResult = "已经登录，请勿重复登录！"
)

const (
	LogoutSucceed      LogoutResult = "登出成功!"
	UserHasNotLoginYet LoginResult  = "非法操作!用户未登录！"
)

const (
	RegisterSucceed RegisterResult = "注册成功!"
	UserExists      RegisterResult = "用户名已存在!"
	InvalidEmail    RegisterResult = "非法邮箱!"
	InvalidUsername RegisterResult = "非法用户名！"
	InvalidNickname RegisterResult = "非法昵称！"
	InvalidPassword RegisterResult = "非法密码！"
)

const (
	NoSuchBook BookResult = "无对应书籍"
)

func New(success bool, message, err string) *Response {
	return &Response{
		Success: success,
		Message: message,
		Err:     err,
	}
}

func Success(message string) *Response {
	return &Response{
		Success: true,
		Message: message,
	}
}

func Fail(error string) *Response {
	return &Response{
		Success: false,
		Err:     error,
	}
}

type Response struct {
	Success bool        `json:"success"`
	Message string      `json:"message"`
	Err     string      `json:"err"`
	Payload interface{} `json:"payload"`
}

func (r *Response) WithPayload(payload interface{}) *Response {
	r.Payload = payload
	return r
}
