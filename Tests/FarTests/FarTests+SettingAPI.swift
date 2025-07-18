import Testing
import Foundation
import Alamofire
@testable import Far



extension FarTests {
    
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
    
    func requestMethod() {
        let contextEchoGet = Settings.API._method(context: APIs.echoGet._context(file: #fileID, line: #line))
        #expect(contextEchoGet == .get)
        
        let contextEchoDelete = Settings.API._method(context: APIs.echoDelete._context(file: #fileID, line: #line))
        #expect(contextEchoDelete == .delete)
        
        let contextEchoPatch = Settings.API._method(context: APIs.echoPatch._context(file: #fileID, line: #line))
        #expect(contextEchoPatch == .patch)
        
        let contextEchoPost = Settings.API._method(context: APIs.echoPost._context(file: #fileID, line: #line))
        #expect(contextEchoPost == .post)
        
        let contextEchoPut = Settings.API._method(context: APIs.echoPut._context(file: #fileID, line: #line))
        #expect(contextEchoPut == .put)
    }
    
    func requestURL() {
        let AbsoluteURL = "http://www.xyz.com/a/p/i/foo/bar"
        let AbsoluteDefaultURL = "http://www.abc.com/a/p/i/foo/bar"
        let MockURL = "http://www.mocking.com/mock"
        
        let FullURL = "http://www.xyz.com/a/p/i"
        let FullDefaultURL = "http://www.abc.com/a/p/i"
        
        let BaseURL = "http://www.xyz.com"
        let BaseURL_ = "http://www.xyz.com////"
        
        let BaseDefaultURL = "http://www.abc.com"
        let BaseDefaultURL_ = "http://www.abc.com////"
        
        let Path = "a/p/i"
        let _Path = "////a/p/i"
        
        let AppendPath0 = "foo"
        let _AppendPath0 = "////foo"
        let AppendPath1 = "bar"
        let _AppendPath1 = "////bar"
        
        
        // GET(url:) + .appendPath(_ path:)
        do {
            // GET(url:)
            let api0 = GET<Bin, Bin>(url: FullURL)
            let url0 = Settings.API._url(context: api0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url0)
            
            
            // GET(url:) + .appendPath(_ path:)
            let api1 = GET<Bin, Bin>(url: FullURL).appendPath(AppendPath0).appendPath(AppendPath1)
            let url1 = Settings.API._url(context: api1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url1)
            
            let api1_ = GET<Bin, Bin>(url: FullURL).appendPath(_AppendPath0).appendPath(_AppendPath1)
            let url1_ = Settings.API._url(context: api1_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url1_)
            
            
            // Mock
            let mockAPI0 = api0.mock(MockURL)
            let mockURL0 = Settings.API._url(context: mockAPI0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL0)
            
            let mockAPI1 = api1.mock(MockURL)
            let mockURL1 = Settings.API._url(context: mockAPI1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL1)
        }
        
        
        // GET(_ path:) + .base(_ baseURL:) + .appendPath(_ path:)
        do {
            // GET(_ path:)
            let api0 = GET<Bin, Bin>(Path)
            let url0 = Settings.API._url(context: api0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(nil == url0)
            
            let api0_ = GET<Bin, Bin>(_Path)
            let url0_ = Settings.API._url(context: api0_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(nil == url0_)
            
            
            // GET(_ path:) + .base(_ baseURL:)
            let api1 = GET<Bin, Bin>(Path).base(BaseURL)
            let url1 = Settings.API._url(context: api1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url1)
            
            let api1_ = GET<Bin, Bin>(_Path).base(BaseURL_)
            let url1_ = Settings.API._url(context: api1_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url1_)
            
            
            // GET(_ path:) + .base(_ baseURL:) + .appendPath(_ path:)
            let api2 = GET<Bin, Bin>(Path).base(BaseURL).appendPath(AppendPath0).appendPath(AppendPath1)
            let url2 = Settings.API._url(context: api2._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url2)
            
            let api2_ = GET<Bin, Bin>(_Path).base(BaseURL_).appendPath(_AppendPath0).appendPath(_AppendPath1)
            let url2_ = Settings.API._url(context: api2_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url2_)
            
            
            // Mock
            let mockAPI0 = api0.mock(MockURL)
            let mockURL0 = Settings.API._url(context: mockAPI0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(nil == mockURL0)
            
            let mockAPI1 = api1.mock(MockURL)
            let mockURL1 = Settings.API._url(context: mockAPI1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL1)
            
            let mockAPI2 = api2.mock(MockURL)
            let mockURL2 = Settings.API._url(context: mockAPI2._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL2)
        }
        
        
        // Far.api.dataRequest.base(_ baseURL:)
        // GET(url:) + .appendPath(_ path:)
        do {
            // Far.api.dataRequest.base(_ baseURL:)
            // GET(url:)
            Far.api.dataRequest.base(BaseDefaultURL)
            let api0 = GET<Bin, Bin>(url: FullURL)
            let url0 = Settings.API._url(context: api0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url0)
            
            Far.api.dataRequest.base(BaseDefaultURL_)
            let api0_ = GET<Bin, Bin>(url: FullURL)
            let url0_ = Settings.API._url(context: api0_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url0_)
            
            
            // Far.api.dataRequest.base(_ baseURL:)
            // GET(url:) + .appendPath(_ path:)
            Far.api.dataRequest.base(BaseDefaultURL)
            let api1 = GET<Bin, Bin>(url: FullURL).appendPath(AppendPath0).appendPath(AppendPath1)
            let url1 = Settings.API._url(context: api1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url1)
            
            Far.api.dataRequest.base(BaseDefaultURL_)
            let api1_ = GET<Bin, Bin>(url: FullURL).appendPath(_AppendPath0).appendPath(_AppendPath1)
            let url1_ = Settings.API._url(context: api1_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url1_)
            
            
            // Mock
            let mockAPI0 = api0.mock(MockURL)
            let mockURL0 = Settings.API._url(context: mockAPI0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL0)
            
            let mockAPI1 = api1.mock(MockURL)
            let mockURL1 = Settings.API._url(context: mockAPI1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL1)
        }
        
        // Far.api.dataRequest.base(_ baseURL:)
        // GET(_ path:) + .base(_ baseURL:) + .appendPath(_ path:)
        do {
            // Far.api.dataRequest.base(_ baseURL:)
            // GET(_ path:)
            Far.api.dataRequest.base(BaseDefaultURL)
            let api0 = GET<Bin, Bin>(Path)
            let url0 = Settings.API._url(context: api0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullDefaultURL == url0)
            
            Far.api.dataRequest.base(BaseDefaultURL_)
            let api0_ = GET<Bin, Bin>(_Path)
            let url0_ = Settings.API._url(context: api0_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullDefaultURL == url0_)
            
            
            // Far.api.dataRequest.base(_ baseURL:)
            // GET(_ path:) + .appendPath(_ path:)
            Far.api.dataRequest.base(BaseDefaultURL)
            let api1 = GET<Bin, Bin>(Path).appendPath(AppendPath0).appendPath(AppendPath1)
            let url1 = Settings.API._url(context: api1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteDefaultURL == url1)
            
            Far.api.dataRequest.base(BaseDefaultURL_)
            let api1_ = GET<Bin, Bin>(_Path).appendPath(_AppendPath0).appendPath(_AppendPath1)
            let url1_ = Settings.API._url(context: api1_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteDefaultURL == url1_)
            
            
            // Far.api.dataRequest.base(_ baseURL:)
            // GET(_ path:) + .base(_ baseURL:)
            Far.api.dataRequest.base(BaseDefaultURL)
            let api2 = GET<Bin, Bin>(Path).base(BaseURL)
            let url2 = Settings.API._url(context: api2._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url2)
            
            Far.api.dataRequest.base(BaseDefaultURL_)
            let api2_ = GET<Bin, Bin>(_Path).base(BaseURL_)
            let url2_ = Settings.API._url(context: api2_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(FullURL == url2_)
            
            
            // Far.api.dataRequest.base(_ baseURL:)
            // GET(_ path:) + .base(_ baseURL:) + .appendPath(_ path:)
            Far.api.dataRequest.base(BaseDefaultURL)
            let api3 = GET<Bin, Bin>(Path).base(BaseURL).appendPath(AppendPath0).appendPath(AppendPath1)
            let url3 = Settings.API._url(context: api3._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url3)
            
            Far.api.dataRequest.base(BaseDefaultURL_)
            let api3_ = GET<Bin, Bin>(_Path).base(BaseURL_).appendPath(_AppendPath0).appendPath(_AppendPath1)
            let url3_ = Settings.API._url(context: api3_._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(AbsoluteURL == url3_)
            
            
            // Mock
            let mockAPI0 = api0.mock(MockURL)
            let mockURL0 = Settings.API._url(context: mockAPI0._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL0)
            
            let mockAPI1 = api1.mock(MockURL)
            let mockURL1 = Settings.API._url(context: mockAPI1._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL1)
            
            let mockAPI2 = api2.mock(MockURL)
            let mockURL2 = Settings.API._url(context: mockAPI2._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL2)
            
            let mockAPI3 = api3.mock(MockURL)
            let mockURL3 = Settings.API._url(context: mockAPI3._context(file: #fileID, line: #line)).value?.absoluteString
            #expect(MockURL == mockURL3)
        }
        
        
        // Clear
        Far.api.dataRequest.base(nil)
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
            let header0 = Settings.API._headers(context: api0._context(file: #file, line: #line))
            
            #expect(header0.count == 1)
            #expect(header0[kv0.0] == kv0.1)
            
            // Headers: kv1
            let api1 = api0.headers(kv1)
            let header1 = Settings.API._headers(context: api1._context(file: #file, line: #line))
            
            #expect(header1.count == kv1.count + 1)
            #expect(header1[kv0.0] == kv0.1)
            
            for h in kv1 {
                #expect(header1[h.key] == h.value)
            }
            
            // Headers: kv2
            let api2 = api1.headers(kv2)
            let header2 = Settings.API._headers(context: api2._context(file: #file, line: #line))
            
            #expect(header2.count == kv2.count + 1)
            #expect(header2[kv0.0] == kv0.1)
            
            for h in kv2 {
                #expect(header2[h.key] == h.value)
            }
        }
    }
    
    func requestEncoding() {
        // Default
        let get0 = Settings.API._encoding(context: APIs.echoJSONGet._context(file: #fileID, line: #line))
        let delete0 = Settings.API._encoding(context: APIs.echoJSONDelete._context(file: #fileID, line: #line))
        let patch0 = Settings.API._encoding(context: APIs.echoJSONPatch._context(file: #fileID, line: #line))
        let post0 = Settings.API._encoding(context: APIs.echoJSONPost._context(file: #fileID, line: #line))
        let put0 = Settings.API._encoding(context: APIs.echoJSONPut._context(file: #fileID, line: #line))
        
        #expect(get0 is Alamofire.URLEncoding)
        #expect(delete0 is Alamofire.URLEncoding)
        #expect(patch0 is Alamofire.JSONEncoding)
        #expect(post0 is Alamofire.JSONEncoding)
        #expect(put0 is Alamofire.JSONEncoding)
        
        // Modify
        let get1 = Settings.API._encoding(context: APIs.echoJSONGet.encoding(Alamofire.JSONEncoding.default)._context(file: #fileID, line: #line))
        let delete1 = Settings.API._encoding(context: APIs.echoJSONDelete.encoding(Alamofire.JSONEncoding.default)._context(file: #fileID, line: #line))
        let patch1 = Settings.API._encoding(context: APIs.echoJSONPatch.encoding(Alamofire.URLEncoding.default)._context(file: #fileID, line: #line))
        let post1 = Settings.API._encoding(context: APIs.echoJSONPost.encoding(Alamofire.URLEncoding.default)._context(file: #fileID, line: #line))
        let put1 = Settings.API._encoding(context: APIs.echoJSONPut.encoding(Alamofire.URLEncoding.default)._context(file: #fileID, line: #line))
        
        #expect(get1 is Alamofire.JSONEncoding)
        #expect(delete1 is Alamofire.JSONEncoding)
        #expect(patch1 is Alamofire.URLEncoding)
        #expect(post1 is Alamofire.URLEncoding)
        #expect(put1 is Alamofire.URLEncoding)
    }
    
    func requestEncoder() {
        // Default
        let get0 = Settings.API._encoder(context: APIs.echoGet._context(file: #fileID, line: #line))
        let delete0 = Settings.API._encoder(context: APIs.echoDelete._context(file: #fileID, line: #line))
        let patch0 = Settings.API._encoder(context: APIs.echoPatch._context(file: #fileID, line: #line))
        let post0 = Settings.API._encoder(context: APIs.echoPost._context(file: #fileID, line: #line))
        let put0 = Settings.API._encoder(context: APIs.echoPut._context(file: #fileID, line: #line))
        
        #expect(get0 is Alamofire.URLEncodedFormParameterEncoder)
        #expect(delete0 is Alamofire.URLEncodedFormParameterEncoder)
        #expect(patch0 is Alamofire.JSONParameterEncoder)
        #expect(post0 is Alamofire.JSONParameterEncoder)
        #expect(put0 is Alamofire.JSONParameterEncoder)
        
        // Modify
        let get1 = Settings.API._encoder(context: APIs.echoGet.encoder(Alamofire.JSONParameterEncoder.default)._context(file: #fileID, line: #line))
        let delete1 = Settings.API._encoder(context: APIs.echoDelete.encoder(Alamofire.JSONParameterEncoder.default)._context(file: #fileID, line: #line))
        let patch1 = Settings.API._encoder(context: APIs.echoPatch.encoder(Alamofire.URLEncodedFormParameterEncoder.default)._context(file: #fileID, line: #line))
        let post1 = Settings.API._encoder(context: APIs.echoPost.encoder(Alamofire.URLEncodedFormParameterEncoder.default)._context(file: #fileID, line: #line))
        let put1 = Settings.API._encoder(context: APIs.echoPut.encoder(Alamofire.URLEncodedFormParameterEncoder.default)._context(file: #fileID, line: #line))
        
        #expect(get1 is Alamofire.JSONParameterEncoder)
        #expect(delete1 is Alamofire.JSONParameterEncoder)
        #expect(patch1 is Alamofire.URLEncodedFormParameterEncoder)
        #expect(post1 is Alamofire.URLEncodedFormParameterEncoder)
        #expect(put1 is Alamofire.URLEncodedFormParameterEncoder)
    }
    
    func requestModifier() async {
        let BaseURL = "http://www.xyz.com/"
        let Path = "echo/"
        let FullURL = BaseURL + Path
        
        let timeoutInterval: TimeInterval = 2
        let api0 = GET<Bin, Bin>(url: FullURL).timeoutInterval(timeoutInterval)
        let resp = await api0.request(nil)
        
        #expect(resp.request?.timeoutInterval == timeoutInterval)
    }
    
    func requestModify() {
        // Authentication
        let auth0 = Settings.API._authenticate(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(auth0 == nil)
        
        let username = "xyz"
        let password = "123"
        let auth1 = Settings.API._authenticate(context: APIs.echoGet.authenticate(username: username, password: password)._context(file: #file, line: #line))
        #expect(auth1?.user == username)
        #expect(auth1?.password == password)
        
        // Redirect
        let redir0 = Settings.API._redirectHandler(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(redir0 == nil)
        
        Far.api.dataRequest.redirect(Alamofire.Redirector.doNotFollow)
        let redir1 = Settings.API._redirectHandler(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(redir1 is Alamofire.Redirector)
        
        Far.api.dataRequest.redirect(nil)
        let redir2 = Settings.API._redirectHandler(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(redir2 == nil)
        
        let redir3 = Settings.API._redirectHandler(context: APIs.echoGet.redirect(using: Alamofire.Redirector.follow)._context(file: #file, line: #line))
        #expect(redir3 is Alamofire.Redirector)
        
        // Clear
        Far.api.dataRequest.redirect(nil)
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
        
        let valid0 = Settings.API._validation(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(valid0.0 == nil ) // nil
        #expect(valid0.1 == nil) // nil
        #expect(valid0.2.isEmpty == true) // empty
        
        Far.api.dataResponse.acceptableStatusCodes(statusCode0)
        Far.api.dataResponse.acceptableContentTypes(contentType0)
        Far.api.dataResponse.validations(custom0)
        let valid1 = Settings.API._validation(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(valid1.0 == statusCode0)
        #expect(valid1.1 == contentType0)
        #expect(valid1.2["custom0"] != nil)
        
        let valid2 = Settings.API._validation(context:
                                                APIs.echoGet
            .validate(statusCode: statusCode1)
            .validate(contentType: contentType1)
            .validate(identifier: custom1.0, validation: custom1.1)
            .validate(identifier: custom2.0, validation: custom2.1)
            ._context(file: #file, line: #line)
        )
        #expect(valid2.0 == statusCode1)
        #expect(valid2.1 == contentType1)
        #expect(valid2.2["custom0"] != nil &&
                  valid2.2["custom1"] != nil &&
                  valid2.2["custom2"] != nil)
        
        // cacheResponse
        let cacheResponse0 = Settings.API._cachedResponseHandler(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(cacheResponse0 == nil)
        
        Far.api.dataResponse.cachedResponseHandler(Alamofire.ResponseCacher.doNotCache)
        let cacheResponse1 = Settings.API._cachedResponseHandler(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(cacheResponse1 is Alamofire.ResponseCacher)
        
        Far.api.dataResponse.cachedResponseHandler(nil)
        let cacheResponse2 = Settings.API._cachedResponseHandler(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(cacheResponse2 == nil)
        
        let cacheResponse3 = Settings.API._cachedResponseHandler(context: APIs.echoGet.cacheResponse(using: Alamofire.ResponseCacher.cache)._context(file: #file, line: #line))
        #expect(cacheResponse3 is Alamofire.ResponseCacher)
        
        // Clear
        Far.api.dataResponse.acceptableStatusCodes(nil)
        Far.api.dataResponse.acceptableContentTypes(nil)
        Far.api.dataResponse.validations(nil)
        Far.api.dataResponse.cachedResponseHandler(nil)
    }
    
    func responseQueue() {
        let mainQueue = DispatchQueue.main
        let myQueue = DispatchQueue(label: "my.queue")
        
        let queue0 = Settings.API._queue(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(queue0 === mainQueue)
        
        Far.api.dataResponse.queue(myQueue)
        let queue1 = Settings.API._queue(context: APIs.echoGet._context(file: #file, line: #line))
        #expect(queue1 === myQueue)
        
        Far.api.dataResponse.queue(mainQueue)
        let queue2 = Settings.API._queue(context: APIs.echoGet.queue(myQueue)._context(file: #file, line: #line))
        #expect(queue2 === myQueue)
        
        Far.api.dataResponse.queue(myQueue)
        let queue3 = Settings.API._queue(context: APIs.echoGet.queue(mainQueue)._context(file: #file, line: #line))
        #expect(queue3 === mainQueue)
        
        // Clear
        Far.api.dataResponse.queue(.main)
    }
    
    func responseDataResponseSerializer() {
        let echo0 = GET<Bin, Data>(url: "http://www.xyz.com/echo")
        let serializer0 = Settings.API._dataResponseSerializer(context: echo0._context(file: #file, line: #line))
        #expect(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        #expect(serializer0.emptyResponseCodes == Alamofire.DataResponseSerializer.defaultEmptyResponseCodes)
        #expect(serializer0.emptyRequestMethods == Alamofire.DataResponseSerializer.defaultEmptyRequestMethods)
    }
    
    func responseStringResponseSerializer() {
        let echo0 = GET<Bin, String>(url: "http://www.xyz.com/echo")
        let serializer0 = Settings.API._stringResponseSerializer(context: echo0._context(file: #file, line: #line))
        #expect(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        #expect(serializer0.encoding == nil)
        #expect(serializer0.emptyResponseCodes == Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        #expect(serializer0.emptyRequestMethods == Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
    }
    
    func responseJSONResponseSerializer() {
        let echo0 = GET<Bin, [String: Any]>(url: "http://www.xyz.com/echo")
        let serializer0 = Settings.API._jsonResponseSerializer(context: echo0._context(file: #file, line: #line))
        #expect(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        #expect(serializer0.emptyResponseCodes == Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        #expect(serializer0.emptyRequestMethods == Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
        #expect(serializer0.options == .allowFragments)
    }
    
    func responseDecodableResponseSerializer() {
        let echo0 = GET<Bin, Bin>(url: "http://www.xyz.com/echo")
        let serializer0: Alamofire.DecodableResponseSerializer<Bin> = Settings.API._decodableResponseSerializer(context: echo0._context(file: #file, line: #line))
        #expect(serializer0.dataPreprocessor is Alamofire.PassthroughPreprocessor)
        #expect(serializer0.decoder is JSONDecoder)
        #expect(serializer0.emptyResponseCodes == Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        #expect(serializer0.emptyRequestMethods == Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
    }
    
    func accessing() {
        @AutoCancelRequest(APIs.echoGet.base("http://www.xyz.com/"))
        var dataRequestEchoGet
         
        #expect($dataRequestEchoGet.request == nil)
        
        dataRequestEchoGet.request(nil) { resp in }
        
        #expect($dataRequestEchoGet.request != nil)
    }
}
