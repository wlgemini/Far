//
//  SettingAPITests.swift
//

import XCTest
@testable import Alamofire
@testable import Far


class SettingAPITests {
    
    struct Bin: Codable, Equatable {
        let foo: String
        let bar: String
        let baz: String
    }
    
    enum APIs {
        
        static let echoGet = GET<Bin, Bin>("echo")
        static let echoDelete = DELETE<Bin, Bin>("echo")
        static let echoPatch = PATCH<Bin, Bin>("echo")
        static let echoPost = POST<Bin, Bin>("echo")
        static let echoPut = PUT<Bin, Bin>("echo")
        
        static let echoJSONGet = GET<[String: Any], Any>("echo")
        static let echoJSONDelete = DELETE<[String: Any], Any>("echo")
        static let echoJSONPatch = PATCH<[String: Any], Any>("echo")
        static let echoJSONPost = POST<[String: Any], Any>("echo")
        static let echoJSONPut = PUT<[String: Any], Any>("echo")
        
        static let redirectFrom = POST<Bin, Bin>("redirectFrom")
        static let redirectTo = POST<Bin, Bin>("redirectTo")
    }
    
    @AccessingRequest(APIs.echoGet.base("http://www.xyz.com/"))
    var dataRequestEchoGet
    
    func requestMethod() {
        let contextEchoGet = APIs.echoGet._context(file: #fileID, line: #line)
        XCTAssert(contextEchoGet._method() == .get)
        
        let contextEchoDelete = APIs.echoDelete._context(file: #fileID, line: #line)
        XCTAssert(contextEchoDelete._method() == .delete)
        
        let contextEchoPatch = APIs.echoPatch._context(file: #fileID, line: #line)
        XCTAssert(contextEchoPatch._method() == .patch)
        
        let contextEchoPost = APIs.echoPost._context(file: #fileID, line: #line)
        XCTAssert(contextEchoPost._method() == .post)
        
        let contextEchoPut = APIs.echoPut._context(file: #fileID, line: #line)
        XCTAssert(contextEchoPut._method() == .put)
    }
    
    func requestURL() {
        let BaseURL0 = "http://www.xyz.com/"
        let Path = "echo/"
        let FullURL = BaseURL0 + Path
        let AppendPath0 = "foo/"
        let AppendPath1 = "bar/"
        let AbsURL0 = BaseURL0 + Path + AppendPath0 + AppendPath1
        let MockURL = "http://www.mocking.com/mock/"
        
        do {
            // URL = FullURL + AppendPath
            let api0 = GET<Bin, Bin>(url: FullURL)
                .appendPath(AppendPath0)
                .appendPath(AppendPath1)
            let url0 = api0._context(file: #fileID, line: #line)._url()
            
            // URL = BaseURL + Path + AppendPath
            let api1 = GET<Bin, Bin>(Path)
                .base(BaseURL0)
                .appendPath(AppendPath0)
                .appendPath(AppendPath1)
            let url1 = api1._context(file: #fileID, line: #line)._url()
            
            XCTAssert(AbsURL0 == url0)
            XCTAssert(AbsURL0 == url1)
            
            // Mock
            let api2 = api0
                .mock(MockURL)
            let url2 = api2._context(file: #fileID, line: #line)._url()
            XCTAssert(MockURL == url2)
            
            let api3 = api1
                .mock(MockURL)
            let url3 = api3._context(file: #fileID, line: #line)._url()
            XCTAssert(MockURL == url3)
        }
        
        do {
            // Path + AppendPath
            let api0 = GET<Bin, Bin>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url0 = api0._context(file: #fileID, line: #line)._url()
            XCTAssert(url0 == nil)
            
            // Mock
            let api1 = api0
                .mock(MockURL)
            let url1 = api1._context(file: #fileID, line: #line)._url()
            XCTAssert(nil == url1)
        }
        
        do {
            // URL = BaseURL + Path + AppendPath
            let BaseURL1 = "http://www.abc.com/"
            let AbsURL1 = BaseURL1 + Path + AppendPath0 + AppendPath1
            Far.default.dataRequest.base(BaseURL1)
            let api0 = GET<Bin, Bin>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url0 = api0._context(file: #fileID, line: #line)._url()
            XCTAssert(AbsURL1 == url0)
            
            // Mock
            let api1 = api0
                .mock(MockURL)
            let url1 = api1._context(file: #fileID, line: #line)._url()
            XCTAssert(MockURL == url1)
            
            // Path + AppendPath
            Far.default.dataRequest.base(nil)
            let api2 = GET<Bin, Bin>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url2 = api2._context(file: #fileID, line: #line)._url()
            XCTAssert(nil == url2)
            
            // Mock
            let api3 = api2
                .mock(MockURL)
            let url3 = api3._context(file: #fileID, line: #line)._url()
            XCTAssert(nil == url3)
            
            // Clear
            Far.default.dataRequest.base(nil)
        }
    }
    
    func requestHeaders() {
        let BaseURL = "http://www.xyz.com/"
        let Path = "echo/"
        let FullURL = BaseURL + Path
  
        let kv0 = ("X", "y")
        
        let kv1 = ["a": "0",
                   "b": "1",
                   "c": "2"]
        
        let kv2 = ["a": "3",
                   "b": "4",
                   "c": "5",
                   "d": "6",
                   "e": "7"]

        do {
            // Headers: []
            let api0 = GET<Bin, Bin>(url: FullURL).header(name: kv0.0, value: kv0.1)
            let header0 = api0._context(file: #file, line: #line)._headers()
            
            XCTAssert(header0.count == 1)
            XCTAssert(header0[kv0.0] == kv0.1)
            
            // Headers: kv1
            let api1 = api0.headers(kv1)
            let header1 = api1._context(file: #file, line: #line)._headers()
            
            XCTAssert(header1.count == kv1.count + 1)
            XCTAssert(header1[kv0.0] == kv0.1)
            
            for h in kv1 {
                XCTAssert(header1[h.key] == h.value)
            }
            
            // Headers: kv2
            let api2 = api1.headers(kv2)
            let header2 = api2._context(file: #file, line: #line)._headers()
            
            XCTAssert(header2.count == kv2.count + 1)
            XCTAssert(header2[kv0.0] == kv0.1)
            
            for h in kv2 {
                XCTAssert(header2[h.key] == h.value)
            }
        }
    }

    func requestEncoding() {
        // Default
        let get0 = APIs.echoJSONGet._context(file: #fileID, line: #line)._encoding()
        let delete0 = APIs.echoJSONDelete._context(file: #fileID, line: #line)._encoding()
        let patch0 = APIs.echoJSONPatch._context(file: #fileID, line: #line)._encoding()
        let post0 = APIs.echoJSONPost._context(file: #fileID, line: #line)._encoding()
        let put0 = APIs.echoJSONPut._context(file: #fileID, line: #line)._encoding()
        
        XCTAssert(get0 is Alamofire.URLEncoding)
        XCTAssert(delete0 is Alamofire.URLEncoding)
        XCTAssert(patch0 is Alamofire.JSONEncoding)
        XCTAssert(post0 is Alamofire.JSONEncoding)
        XCTAssert(put0 is Alamofire.JSONEncoding)
        
        // Modify
        let get1 = APIs.echoJSONGet.encoding(Alamofire.JSONEncoding.default)._context(file: #fileID, line: #line)._encoding()
        let delete1 = APIs.echoJSONDelete.encoding(Alamofire.JSONEncoding.default)._context(file: #fileID, line: #line)._encoding()
        let patch1 = APIs.echoJSONPatch.encoding(Alamofire.URLEncoding.default)._context(file: #fileID, line: #line)._encoding()
        let post1 = APIs.echoJSONPost.encoding(Alamofire.URLEncoding.default)._context(file: #fileID, line: #line)._encoding()
        let put1 = APIs.echoJSONPut.encoding(Alamofire.URLEncoding.default)._context(file: #fileID, line: #line)._encoding()
        
        XCTAssert(get1 is Alamofire.JSONEncoding)
        XCTAssert(delete1 is Alamofire.JSONEncoding)
        XCTAssert(patch1 is Alamofire.URLEncoding)
        XCTAssert(post1 is Alamofire.URLEncoding)
        XCTAssert(put1 is Alamofire.URLEncoding)
    }
    
    func requestEncoder() {
        // Default
        let get0 = APIs.echoGet._context(file: #fileID, line: #line)._encoder()
        let delete0 = APIs.echoDelete._context(file: #fileID, line: #line)._encoder()
        let patch0 = APIs.echoPatch._context(file: #fileID, line: #line)._encoder()
        let post0 = APIs.echoPost._context(file: #fileID, line: #line)._encoder()
        let put0 = APIs.echoPut._context(file: #fileID, line: #line)._encoder()
        
        XCTAssert(get0 is Alamofire.URLEncodedFormParameterEncoder)
        XCTAssert(delete0 is Alamofire.URLEncodedFormParameterEncoder)
        XCTAssert(patch0 is Alamofire.JSONParameterEncoder)
        XCTAssert(post0 is Alamofire.JSONParameterEncoder)
        XCTAssert(put0 is Alamofire.JSONParameterEncoder)
        
        // Modify
        let get1 = APIs.echoGet.encoder(Alamofire.JSONParameterEncoder.default)._context(file: #fileID, line: #line)._encoder()
        let delete1 = APIs.echoDelete.encoder(Alamofire.JSONParameterEncoder.default)._context(file: #fileID, line: #line)._encoder()
        let patch1 = APIs.echoPatch.encoder(Alamofire.URLEncodedFormParameterEncoder.default)._context(file: #fileID, line: #line)._encoder()
        let post1 = APIs.echoPost.encoder(Alamofire.URLEncodedFormParameterEncoder.default)._context(file: #fileID, line: #line)._encoder()
        let put1 = APIs.echoPut.encoder(Alamofire.URLEncodedFormParameterEncoder.default)._context(file: #fileID, line: #line)._encoder()
        
        XCTAssert(get1 is Alamofire.JSONParameterEncoder)
        XCTAssert(delete1 is Alamofire.JSONParameterEncoder)
        XCTAssert(patch1 is Alamofire.URLEncodedFormParameterEncoder)
        XCTAssert(post1 is Alamofire.URLEncodedFormParameterEncoder)
        XCTAssert(put1 is Alamofire.URLEncodedFormParameterEncoder)
    }
    
    func requestModifier() {
        let BaseURL = "http://www.xyz.com/"
        let Path = "echo/"
        let FullURL = BaseURL + Path
        
        let expPost = XCTestExpectation()
        let timeoutInterval: TimeInterval = 2
        let api0 = GET<Bin, Bin>(url: FullURL).timeoutInterval(timeoutInterval)
        api0.request(nil) { resp in
            XCTAssert(resp.request?.timeoutInterval == timeoutInterval)
            expPost.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expPost], timeout: timeoutInterval * 2)
    }
    
    func requestModify() {
        // Authentication
        let auth0 = APIs.echoGet._context(file: #file, line: #line)._authenticate()
        XCTAssert(auth0 == nil)
        
        let username = "xyz"
        let password = "123"
        let auth1 = APIs.echoGet.authenticate(username: username, password: password)._context(file: #file, line: #line)._authenticate()
        XCTAssert(auth1?.user == username)
        XCTAssert(auth1?.password == password)
        
        // Redirect
        let redir0 = APIs.echoGet._context(file: #file, line: #line)._redirectHandler()
        XCTAssert(redir0 == nil)
        
        Far.default.dataRequest.redirect(Alamofire.Redirector.doNotFollow)
        let redir1 = APIs.echoGet._context(file: #file, line: #line)._redirectHandler()
        XCTAssert(redir1 is Alamofire.Redirector)
        
        Far.default.dataRequest.redirect(nil)
        let redir2 = APIs.echoGet._context(file: #file, line: #line)._redirectHandler()
        XCTAssert(redir2 == nil)
        
        let redir3 = APIs.echoGet.redirect(using: Alamofire.Redirector.follow)._context(file: #file, line: #line)._redirectHandler()
        XCTAssert(redir3 is Alamofire.Redirector)
        
        // Clear
        Far.default.dataRequest.redirect(nil)
    }
    
    func responseModify() {
        // validation
        let statusCode0: Range<Int> = 2000 ..< 3000
        let contentType0: [String] = ["type0"]
        let custom0: [String: Alamofire.DataRequest.Validation] = [
            "custom0": { _, _, _ in .success(()) },
        ]
        
        let statusCode1: Range<Int> = 3000 ..< 4000
        let contentType1: [String] = ["type1"]
        let custom1: (String, Alamofire.DataRequest.Validation) = ("custom1", { _, _, _ in .success(()) })
        let custom2: (String, Alamofire.DataRequest.Validation) = ("custom2", { _, _, _ in .success(()) })
        
        let valid0 = APIs.echoGet._context(file: #file, line: #line)._validation()
        XCTAssert(valid0.0 == nil ) // nil
        XCTAssert(valid0.1 == nil) // nil
        XCTAssert(valid0.2.isEmpty == true) // empty
        
        Far.default.dataResponse.acceptableStatusCodes(statusCode0)
        Far.default.dataResponse.acceptableContentTypes(contentType0)
        Far.default.dataResponse.validations(custom0)
        let valid1 = APIs.echoGet._context(file: #file, line: #line)._validation()
        XCTAssert(valid1.0 == statusCode0)
        XCTAssert(valid1.1 == contentType0)
        XCTAssert(valid1.2["custom0"] != nil)
        
        let valid2 = APIs.echoGet
            .validate(statusCode: statusCode1)
            .validate(contentType: contentType1)
            .validate(identifier: custom1.0, validation: custom1.1)
            .validate(identifier: custom2.0, validation: custom2.1)
            ._context(file: #file, line: #line)._validation()
        XCTAssert(valid2.0 == statusCode1)
        XCTAssert(valid2.1 == contentType1)
        XCTAssert(valid2.2["custom0"] != nil &&
                  valid2.2["custom1"] != nil &&
                  valid2.2["custom2"] != nil)
        
        // cacheResponse
        let cacheResponse0 = APIs.echoGet._context(file: #file, line: #line)._cachedResponseHandler()
        XCTAssert(cacheResponse0 == nil)
        
        Far.default.dataResponse.cachedResponseHandler(Alamofire.ResponseCacher.doNotCache)
        let cacheResponse1 = APIs.echoGet._context(file: #file, line: #line)._cachedResponseHandler()
        XCTAssert(cacheResponse1 is Alamofire.ResponseCacher)
        
        Far.default.dataResponse.cachedResponseHandler(nil)
        let cacheResponse2 = APIs.echoGet._context(file: #file, line: #line)._cachedResponseHandler()
        XCTAssert(cacheResponse2 == nil)
        
        let cacheResponse3 = APIs.echoGet.cacheResponse(using: Alamofire.ResponseCacher.cache)._context(file: #file, line: #line)._cachedResponseHandler()
        XCTAssert(cacheResponse3 is Alamofire.ResponseCacher)
        
        // Clear
        Far.default.dataResponse.acceptableStatusCodes(nil)
        Far.default.dataResponse.acceptableContentTypes(nil)
        Far.default.dataResponse.validations(nil)
        Far.default.dataResponse.cachedResponseHandler(nil)
    }
    
    func responseQueue() {
        let mainQueue = DispatchQueue.main
        let myQueue = DispatchQueue(label: "my.queue")
        
        let queue0 = APIs.echoGet._context(file: #file, line: #line)._queue()
        XCTAssert(queue0 === mainQueue)
        
        Far.default.dataResponse.queue(myQueue)
        let queue1 = APIs.echoGet._context(file: #file, line: #line)._queue()
        XCTAssert(queue1 === myQueue)
        
        Far.default.dataResponse.queue(mainQueue)
        let queue2 = APIs.echoGet.queue(myQueue)._context(file: #file, line: #line)._queue()
        XCTAssert(queue2 === myQueue)
        
        Far.default.dataResponse.queue(myQueue)
        let queue3 = APIs.echoGet.queue(mainQueue)._context(file: #file, line: #line)._queue()
        XCTAssert(queue3 === mainQueue)
        
        // Clear
        Far.default.dataResponse.queue(.main)
    }
    
    func responseDataResponseSerializer() {
        let echo0 = GET<Bin, Data>(url: "http://www.xyz.com/echo")
        let serializer0 = echo0._context(file: #file, line: #line)._dataResponseSerializer()
        XCTAssert(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        XCTAssert(serializer0.emptyResponseCodes == Alamofire.DataResponseSerializer.defaultEmptyResponseCodes)
        XCTAssert(serializer0.emptyRequestMethods == Alamofire.DataResponseSerializer.defaultEmptyRequestMethods)
    }
    
    func responseStringResponseSerializer() {
        let echo0 = GET<Bin, String>(url: "http://www.xyz.com/echo")
        let serializer0 = echo0._context(file: #file, line: #line)._stringResponseSerializer()
        XCTAssert(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        XCTAssert(serializer0.encoding == nil)
        XCTAssert(serializer0.emptyResponseCodes == Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        XCTAssert(serializer0.emptyRequestMethods == Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
    }
    
    func responseJSONResponseSerializer() {
        let echo0 = GET<Bin, [String: Any]>(url: "http://www.xyz.com/echo")
        let serializer0 = echo0._context(file: #file, line: #line)._jsonResponseSerializer()
        XCTAssert(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        XCTAssert(serializer0.emptyResponseCodes == Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        XCTAssert(serializer0.emptyRequestMethods == Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
        XCTAssert(serializer0.options == .allowFragments)
    }
    
    func responseDecodableResponseSerializer() {
        let echo0 = GET<Bin, Bin>(url: "http://www.xyz.com/echo")
        let serializer0: Alamofire.DecodableResponseSerializer<Bin> = echo0._context(file: #file, line: #line)._decodableResponseSerializer()
        XCTAssert(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        XCTAssert(serializer0.decoder is JSONDecoder)
        XCTAssert(serializer0.emptyResponseCodes == Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        XCTAssert(serializer0.emptyRequestMethods == Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
    }
    
    func accessing() {
        
        // accessingRequest
        XCTAssert(self.$dataRequestEchoGet.request == nil)
        
        self.dataRequestEchoGet.request(nil) { resp in }
        
        XCTAssert(self.$dataRequestEchoGet.request != nil)
    }
}
