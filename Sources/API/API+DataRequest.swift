//
//  API+DataRequest.swift
//

import Foundation
import Alamofire


public extension API {
    
    // MARK: Parameters == [String: Any], Returns == Data
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns == Foundation.Data {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == [String: Any], Returns == String
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns == Swift.String {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == [String: Any], Returns == Any
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns == Any {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == [String: Any], Returns: Decodable
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns: Swift.Decodable {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == Encodable, Returns == Data
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns == Foundation.Data {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == Encodable, Returns == String
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns == Swift.String {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == Encodable, Returns == Any
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns == Any {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: Parameters == Encodable, Returns: Decodable
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void,
                 file: Swift.String = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns: Swift.Decodable {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
}


// MARK: - Request Helper
extension API {
    
    /// context
    func _context(file: Swift.String, line: Swift.UInt) -> ModifyContext {
        let ctx = ModifyContext(requestLocation: _Location(file, line))
        self.modifier.modify(context: ctx)
        return ctx
    }
    
    /// request encoding
    func _request(parameters: Parameters?, context: ModifyContext) -> Alamofire.DataRequest?
    where Parameters == [Swift.String: Any] {
        guard let method = context._method() else { return nil }
        guard let url = context._url() else { return nil }
        let headers = context._headers()
        let encoding = context._encoding()
        let requestModifier = context._urlRequestModifier()
        return Far._sessionFinalized.request(url,
                                             method: method,
                                             parameters: parameters,
                                             encoding: encoding,
                                             headers: headers,
                                             interceptor: nil,
                                             requestModifier: requestModifier)
    }
    
    /// request encodable
    func _request(parameters: Parameters?, context: ModifyContext) -> Alamofire.DataRequest?
    where Parameters: Swift.Encodable {
        guard let method = context._method() else { return nil }
        guard let url = context._url() else { return nil }
        let headers = context._headers()
        let encoder = context._encoder()
        let requestModifier = context._urlRequestModifier()
        return Far._sessionFinalized.request(url,
                                             method: method,
                                             parameters: parameters,
                                             encoder: encoder,
                                             headers: headers,
                                             interceptor: nil,
                                             requestModifier: requestModifier)
    }
    
    /// request modify
    func _requestModify(request: Alamofire.DataRequest, context: ModifyContext) {
        // authentication
        if let credential = context._authenticate() {
            request.authenticate(with: credential)
        }
        
        // redirect
        if let redirectHandler = context._redirectHandler() {
            request.redirect(using: redirectHandler)
        }
    }
    
    /// response modify
    func _responseModify(request: Alamofire.DataRequest, context: ModifyContext) {
        // validation
        let (acceptableStatusCodes, acceptableContentTypes, validations) = context._validation()
        
        // statusCodes validation
        if let statusCodes = acceptableStatusCodes {
            request.validate(statusCode: statusCodes)
        } else {
            request.validate(statusCode: 200 ..< 300)
        }
        
        // contentTypes validation
        if let contentTypes = acceptableContentTypes {
            request.validate(contentType: contentTypes)
        } else {
            if let accept = request.request?.value(forHTTPHeaderField: "Accept") {
                let contentTypes = accept.components(separatedBy: ",")
                request.validate(contentType: contentTypes)
            } else {
                request.validate(contentType: ["*/*"])
            }
        }
        
        // custom validations
        validations.values.forEach {
            request.validate($0)
        }
        
        // cacheResponse
        if let cachedResponseHandler = context._cachedResponseHandler() {
            request.cacheResponse(using: cachedResponseHandler)
        }
    }
    
    /// response data
    func _response(request: Alamofire.DataRequest,
                   context: ModifyContext,
                   completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void)
    where Returns == Foundation.Data {
        let queue = context._queue()
        let serializer = context._dataResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response string
    func _response(request: Alamofire.DataRequest,
                   context: ModifyContext,
                   completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void)
    where Returns == Swift.String {
        let queue = context._queue()
        let serializer = context._stringResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response json
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func _response(request: Alamofire.DataRequest,
                   context: ModifyContext,
                   completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void)
    where Returns == Any {
        let queue = context._queue()
        let serializer = context._jsonResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response decodable
    func _response(request: Alamofire.DataRequest,
                   context: ModifyContext,
                   completion: @escaping (Alamofire.AFDataResponse<Returns>) -> Swift.Void)
    where Returns: Swift.Decodable {
        let queue = context._queue()
        let serializer: Alamofire.DecodableResponseSerializer<Returns> = context._decodableResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// accessing data request
    func _requestAccessing(request: Alamofire.DataRequest, context: ModifyContext) {
        // onRequestAvailable
        if let onRequestAvailable = context._accessingRequest() {
            onRequestAvailable(request)
        }
    }
}
