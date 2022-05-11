# Far

make *Function as Request*

## 接入

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/wlgemini/Far.git", .upToNextMajor(from: "XX.XX.XX"))
]
```

## 简单上手

```swift
import Far


// 定义login接口
let login = POST<Account, UserInfo>(url: "https://www.exmple.com/login")

// 定义friends接口
let friends = POST<Page, [Friend]>(url: "https://www.exmple.com/friends")


// 调用login接口
let account = ...
login.request(account) { response in
    let userInfo = response.value
    
    // save `userInfo`
    ...
}

// 调用friends接口
let page = ...
friends.request(page) { response in
    let someFriends = response.value
}
```

## 相关概念

`Far`将各种网络功能作为*配置项*来存储, 根据*配置项*用途不同，做了如下分层:

- 定义API时产生的*配置项*
- 默认的API*配置项*
- `Session`的*配置项*

并且, 根据*配置项*的影响范围，定义了不同的优先级:

`定义API时产生的配置项 > 默认的API配置项 > Session的配置项`

当不同层次中出现冲突的*配置项*时，优先使用高优先级的配置项

## 使用

### `0x00`, 修改`Session`的配置项 (可选):

`Session`都有默认值, 所以这一步是可选的

```swift
// URLSessionConfiguration
Far.session.configuration(URLSessionConfiguration.af.default)

// Event monitors
Far.session.eventMonitors([Alamofire.ClosureEventMonitor()])
  
...
```

> ⚠️: 在网络请求开始后, 对`Session`的设置将不再生效.

### `0x01`, 修改默认`API`的配置项 (可选):

```swift
// 设置base URL
Far.default.base("https://www.exmple.com/")

// 设置请求头
Far.default.headers([
    "key1": "value1",
    "key2": "value2"
]) 

... 
```

### `0x10`, 定义请求接口:

```swift
// 定义login接口
let login = POST<Account, UserInfo>("login")

// 定义friends接口
let friends = POST<Page, [Friend]>("friends")
```

### `0x11`, 给定义的API增加配置项 (可选):

```swift
let account = Account(name: "Jack", password: "*******")
  
login
    .timeoutInterval(2)
    .mock("http://www.mocking.com/login")
    .request(account) { response in
        // some logic here
    }
```
