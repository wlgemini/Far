# Far

Make **F**unction **A**s **R**equest


## 快速上手

```swift
import Far


/* 定义login接口 */
let login = POST<Account, UserInfo>(url: "https://www.exmple.com/login")

/* 定义friends接口 */
let friends = POST<Page, [Friend]>(url: "https://www.exmple.com/friends")


/* 调用login接口 */
let account = Account(name: "Jack", password: "*******")
let response = await login.request(account)
let userInfo: UserInfo = response.value

/* 调用friends接口 */
let page = Page(offset: 0, count: 20)
let response = await friends.request(page)
let someFriends: [Friend] = response.value
```

## 使用

### `0x0`. 设置`Session`(可选):

`Session`有默认值, 所以这一步是可选的

```swift
Far.session = Alamofire.Session()
```

> ⚠️: 在网络请求开始后, 对`Session`的设置将不再生效.
> 
> 若要检查`Session`是否可以修改, 使用`Far.isSessionFinalized`, 为`false`表示可以修改.

### `0x1`. 设置`Base URL`:

```swift
/* 设置Base URL (定义的API将继承这个domain) */
Far.api.dataRequest.base("https://www.exmple.com/")
```

### `0x2`. 其他可选设置

- `DataRequest`
    - Headers
    - `Encoding`/`Encoder`
    - Authentication
    - Redirect
- `DataResponse`
    - Validation
        - `acceptableStatusCodes`
        - `acceptableContentTypes`
        - `validations`
    - `CachedResponseHandler`
    - `DispatchQueue`
    - Serialize
        - `serializeData`
        - `serializeString`
        - `serializeJSON`
        - `serializeDecodable`

### `0x3`. 定义API:

```swift
/* 定义login接口 (base url继承自Far.api.dataRequest.base) */
let login = POST<Account, UserInfo>("login")

/* 定义friends接口, 并设置超时时间 */
let friends = POST<Page, [Friend]>("friends")
```

### `0x4`. 请求API:

```swift
let account = Account(name: "Jack", password: "*******")

/* 
对当前API使用mock modifier修饰, login api变为mock请求. (mock modifier只在DEBUG环境生效) 
*/
let mockedLogin = login.mock("http://www.mocking.com/login")   

let response = await mockedLogin.request(account)
```

### `0x5`. 其他可选`Modifier`

- `.base(_:)`
- `.appendPath(_:)`
- `.mock(_:)`
- `.header(name:, value:)`
- `.headers(_:)`
- `.encoding(_:)`
- `.encoder(_:)`
- `.timeoutInterval(_:)`
- `.authenticate(username:, password:, persistence:)`
- `.authenticate(credential:)`
- `.redirect(using:)`
- `.validate(statusCode:)`
- `.validate(contentType:)`
- `.validate(identifier:, validation:)`
- `.cacheResponse(using:)`
- `.queue(_:)`
- `.serialize(dataPreprocessor:, emptyResponseCodes:, emptyRequestMethods:)`
- `.serialize(dataPreprocessor:, encoding:, emptyResponseCodes:, emptyRequestMethods:)`
- `.serialize(dataPreprocessor:, emptyResponseCodes:, emptyRequestMethods:, options:)`, deprecated and will be removed in next major release.
- `.serialize(dataPreprocessor:, decoder:, emptyResponseCodes:, emptyRequestMethods:)`

### `0x6`. 使用`@AutoCancelRequest`:

`AutoCancelRequest`是一个`@propertyWrapper`, 可用于:

- 在网络请求开始后, 获取`Alamofire.DataRequest`
- 当`ViewController.deinit`时, 自动取消网络请求

```swift
class ViewController: UIViewController {

    /* 自动取消login请求 */
    @AutoCancelRequest(login)
    var userLogin

    override func viewDidLoad(_ view: UIView) {
        let response = await userLogin.request(account)
        let userInfo = response.value
    }
}
```

## Requirements

- iOS 10.0+, macOS 10.15+, tvOS 12.0+, watchOS 4.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/wlgemini/Far.git", .upToNextMajor(from: "5.8.0"))
]
```

### Cocoapods

```
pod 'Far', '~> 5.8.0'
```

## License

Far is available under the MIT license. See the LICENSE file for more info.
