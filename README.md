# Far

make *Function as Request*

## 接入

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

## 相关概念

`Far`将各种网络功能作为*配置项*来存储, 根据*配置项*用途不同，做了如下分层:

- 定义API时产生的*配置项*
- 默认的API*配置项*

并且, 根据*配置项*的影响范围，定义了不同的优先级:

`定义API时产生的配置项 > 默认的API配置项`

当不同层次中出现冲突的*配置项*时，优先使用高优先级的配置项

## 使用

### `0x00`, 设置`Session`(可选):

`Session`有默认值, 所以这一步是可选的

```swift
Far.session = Alamofire.Session()
```

> ⚠️: 在网络请求开始后, 对`Session`的设置将不再生效.
> 
> 若要检查`Session`是否可以修改, 使用`Far.isSessionFinalized`, 为`false`表示可以修改.

### `0x01`, 修改默认的`API`配置项(可选):

```swift
// MARK: DataRequest
/* 设置base URL (如果app中只有一个domain, 随后定义的API则继承这个domain) */
Far.api.dataRequest.base("https://www.exmple.com/")

/* 设置请求头 */
Far.api.dataRequest.headers([
    "key1": "value1",
    "key2": "value2"
]) 

/*
- Encoding/Encoder
- Authentication
- Redirect
*/
...


// MARK: DataResponse
/*
- Validate
- Cache
- Serialize
*/
...
```

### `0x02`, 定义请求接口, 并增加配置项(可选):

```swift
/* 定义login接口 (base url继承自Far.api.dataRequest.base) */
let login = POST<Account, UserInfo>("login")
    .headers(...)           /* 添加额外的headers */
    .timeoutInterval(...)   /* 设置timeout */

/* 定义friends接口, 并设置超时时间 */
let friends = POST<Page, [Friend]>("friends")
    .timeoutInterval(...)
```

### `0x03`, 增加配置项(可选), 并请求API:

```swift
let account = Account(name: "Jack", password: "*******")

let mockedLogin = login.mock("http://www.mocking.com/login")    /* 对当前API使用mock请求, DEBUG环境生效 */

let response = await mockedLogin.request(account)

let userInfo = response.value
```

### `0x04`, 使用`@AccessingRequest`(可选):

`AccessingRequest`是一个`@propertyWrapper`, 可用于:

- 在网络请求开始后, 获取`Alamofire.DataRequest`.
- 当`ViewController.deinit`时, 自动取消网络请求.

```swift
class ViewController: UIViewController {

    @AutoCancelRequest(friends)
    var getFriends

    override func viewDidLoad(_ view: UIView) {
    
        /* getFriends.request() */
        ...
        
        /* 在网络请求开始后，获取`Alamofire.DataRequest` */
        self.$getFriends.request
        
        /* deinit时, 自动取消请求 */
        self.$getFriends.isCancelRequestWhenDeinit = true
    }
}
```
