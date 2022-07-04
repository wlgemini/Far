//
//  API+DataRequestHelper.swift
//  

import Foundation
import Alamofire


// MARK: - Context
extension API {
    
    /// context
    func _context(file: Swift.StaticString, line: Swift.UInt) -> ModifiedContext {
        let ctx = ModifiedContext(requestLocation: Location(file, line))
        self.modifier.apply(to: ctx)
        return ctx
    }
}

// MARK: - Request
extension API {
    
    /// request encoding
    func _request(parameters: Parameters?, context: ModifiedContext) -> Alamofire.DataRequest
    where Parameters == [Swift.String: Any] {
        let method = Settings.API._method(context: context)
        let url = Settings.API._url(context: context)
        let headers = Settings.API._headers(context: context)
        let encoding = Settings.API._encoding(context: context)
        let requestModifier = Settings.API._urlRequestModifier(context: context)
        return Far._sessionFinalized.request(url,
                                             method: method,
                                             parameters: parameters,
                                             encoding: encoding,
                                             headers: headers,
                                             interceptor: nil,
                                             requestModifier: requestModifier)
    }
    
    /// request encodable
    func _request(parameters: Parameters?, context: ModifiedContext) -> Alamofire.DataRequest
    where Parameters: Swift.Encodable {
        let method = Settings.API._method(context: context)
        let url = Settings.API._url(context: context)
        let headers = Settings.API._headers(context: context)
        let encoder = Settings.API._encoder(context: context)
        let requestModifier = Settings.API._urlRequestModifier(context: context)
        return Far._sessionFinalized.request(url,
                                             method: method,
                                             parameters: parameters,
                                             encoder: encoder,
                                             headers: headers,
                                             interceptor: nil,
                                             requestModifier: requestModifier)
    }
}

// MARK: - Request Modify
extension API {
    
    /// request modify
    func _requestModify(request: Alamofire.DataRequest, context: ModifiedContext) {
        // authentication
        if let credential = Settings.API._authenticate(context: context) {
            request.authenticate(with: credential)
        }
        
        // redirect
        if let redirectHandler = Settings.API._redirectHandler(context: context) {
            request.redirect(using: redirectHandler)
        }
    }
}

// MARK: - Response Modify
extension API {
    
    /// response modify
    func _responseModify(request: Alamofire.DataRequest, context: ModifiedContext) {
        // validation
        let (acceptableStatusCodes, acceptableContentTypes, validations) = Settings.API._validation(context: context)
        
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
        if let cachedResponseHandler = Settings.API._cachedResponseHandler(context: context) {
            request.cacheResponse(using: cachedResponseHandler)
        }
    }
}

// MARK: - Response
extension API {
    
    /// response data
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext,
                   completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void)
    where Returns == Foundation.Data {
        let queue = Settings.API._queue(context: context)
        let serializer = Settings.API._dataResponseSerializer(context: context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response string
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext,
                   completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void)
    where Returns == Swift.String {
        let queue = Settings.API._queue(context: context)
        let serializer = Settings.API._stringResponseSerializer(context: context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response json
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext,
                   completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void)
    where Returns == Any {
        let queue = Settings.API._queue(context: context)
        let serializer = Settings.API._jsonResponseSerializer(context: context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response decodable
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext,
                   completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void)
    where Returns: Swift.Decodable {
        let queue = Settings.API._queue(context: context)
        let serializer: Alamofire.DecodableResponseSerializer<Returns> = Settings.API._decodableResponseSerializer(context: context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
}

// MARK: - Async Response
extension API {
    
    /// async response data
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext) async -> Alamofire.DataResponse<Returns, AFError>
    where Returns == Foundation.Data {
        let serializer = Settings.API._dataResponseSerializer(context: context)
        return await request.serializingResponse(using: serializer).response
    }
    
    /// async response string
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext) async -> Alamofire.DataResponse<Returns, AFError>
    where Returns == Swift.String {
        let serializer = Settings.API._stringResponseSerializer(context: context)
        return await request.serializingResponse(using: serializer).response
    }
    
    /// async response json
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext) async -> Alamofire.DataResponse<Returns, AFError>
    where Returns == Any {
        let serializer = Settings.API._jsonResponseSerializer(context: context)
        return await request.serializingResponse(using: serializer).response
    }
    
    /// async response decodable
    func _response(request: Alamofire.DataRequest,
                   context: ModifiedContext) async -> Alamofire.DataResponse<Returns, AFError>
    where Returns: Swift.Decodable {
        let serializer: Alamofire.DecodableResponseSerializer<Returns> = Settings.API._decodableResponseSerializer(context: context)
        return await request.serializingResponse(using: serializer).response
    }
}

// MARK: - Request accessing
extension API {
    
    /// accessing data request
    func _requestAccessing(request: Alamofire.DataRequest, context: ModifiedContext) {
        // onRequestAvailable
        if let onRequestAvailable = Settings.API._accessingRequest(context: context) {
            onRequestAvailable(request)
        }
    }
}
