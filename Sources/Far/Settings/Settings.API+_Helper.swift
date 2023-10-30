//
//  Settings.API+_Helper.swift
//

import Foundation
import Alamofire


// MARK: - DataRequest
extension Settings.API {
    
    /// HTTPMethod
    static func _method(context: Settings.API.Modified) -> Alamofire.HTTPMethod {
        guard let method = context.dataRequest.api.method else {
            fatalError("`HTTPMethod` not set")
        }
        
        return method
    }
    
    /// URL
    static func _url(context: Settings.API.Modified) -> Settings.API._URLResult {
        /// remove first `/` if any
        func _dropFirstForwardSlash(_ string: inout Swift.String) {
            while string.first == "/" {
                string.removeFirst()
            }
        }
        
        /// remove last `/` if any
        func _dropLastForwardSlash(_ string: inout Swift.String) {
            while string.last == "/" {
                string.removeLast()
            }
        }
        
        guard let initialURL = context.dataRequest.api.initialURL else {
            fatalError("`InitialURL` not set")
        }
        
        var absoluteURL: Foundation.URL
        
        switch initialURL {
            case .full(let fullURLStringCompute):
                var fullURLString = fullURLStringCompute()
                _dropLastForwardSlash(&fullURLString)
                
                if let fullURL = Foundation.URL(string: fullURLString) {
                    absoluteURL = fullURL
                } else {
                    _Log.error("`\(fullURLString)` doesn’t represent a valid URL, request won't start", location: context.requestLocation)
                    return .failure(AFError.invalidURL(url: fullURLString))
                }
                
            case .path(let pathStingCompute):
                var pathSting = pathStingCompute()
                _dropFirstForwardSlash(&pathSting)
                _dropLastForwardSlash(&pathSting)
                
                // using `modify base url` or `setting base url`
                let anyBaseURLSting = context.dataRequest.api.base?() ?? Far._api.dataRequest.base._value()
                
                if var baseURLSting = anyBaseURLSting {
                    _dropLastForwardSlash(&baseURLSting)
                    
                    if var baseURL = Foundation.URL(string: baseURLSting) {
                        baseURL.appendPathComponent(pathSting)
                        absoluteURL = baseURL
                    } else {
                        _Log.error("For API `\(pathSting)`, `\(baseURLSting)` doesn’t represent a valid URL, request won't start", location: context.requestLocation)
                        return .failure(AFError.invalidURL(url: baseURLSting))
                    }
                } else {
                    _Log.error("For API `\(pathSting)`, base URL not set, request won't start", location: context.requestLocation)
                    return .failure(AFError.invalidURL(url: pathSting))
                }
        }
        
        // append paths
        for pathStingCompute in context.dataRequest.api.appendPaths {
            var pathSting = pathStingCompute()
            _dropFirstForwardSlash(&pathSting)
            _dropLastForwardSlash(&pathSting)
            
            absoluteURL.appendPathComponent(pathSting)
        }
        
        // mock only in debug mode
        _Debug.execute {
            if let mockURLStingCompute = context.dataRequest.api.mock {
                var mockURLString = mockURLStingCompute()
                _dropLastForwardSlash(&mockURLString)
                
                if let mockURL = URL(string: mockURLString) {
                    absoluteURL = mockURL
                    _Log.warning("Using mock URL `\(mockURL)` for `\(absoluteURL)`", location: context.requestLocation)
                } else {
                    _Log.warning("Mock URL string`\(mockURLString)` doesn’t represent a valid URL", location: context.requestLocation)
                }
            }
        }
        
        return .success(absoluteURL)
    }
    
    /// HTTPHeaders
    static func _headers(context: Settings.API.Modified) -> Alamofire.HTTPHeaders {
        // combinedHeaders init from `Far._default.dataRequest.headers` or an empty headers
        var combinedHeaders = Far._api.dataRequest.headers._value() ?? Alamofire.HTTPHeaders()
        
        // Context.dataRequest.headers override or appends to combinedHeaders
        for h in context.dataRequest.headers {
            combinedHeaders.add(h)
        }
        
        return combinedHeaders
    }
    
    /// Encoding
    static func _encoding(context: Settings.API.Modified) -> Alamofire.ParameterEncoding {
        if let encoding = context.dataRequest.encoding {
            return encoding
            
        } else {
            guard let method = context.dataRequest.api.method else {
                return Alamofire.URLEncoding.default
            }
            
            switch method {
                // URLEncoding
                case .get: return Far._api.dataRequest.encoding.get._value
                case .delete: return Far._api.dataRequest.encoding.delete._value
                    
                // JSONEncoding
                case .patch: return Far._api.dataRequest.encoding.patch._value
                case .post: return Far._api.dataRequest.encoding.post._value
                case .put: return Far._api.dataRequest.encoding.put._value
                    
                // default
                default: return Alamofire.URLEncoding.default
            }
        }
    }
    
    /// Encoder
    static func _encoder(context: Settings.API.Modified) -> Alamofire.ParameterEncoder {
        if let encoder = context.dataRequest.encoder {
            return encoder
            
        } else {
            guard let method = context.dataRequest.api.method else {
                return Alamofire.URLEncodedFormParameterEncoder.default
            }
            
            switch method {
                // URLEncodedFormParameterEncoder
                case .get: return Far._api.dataRequest.encoder.get._value
                case .delete: return Far._api.dataRequest.encoder.delete._value
                    
                // JSONEncoding
                case .patch: return Far._api.dataRequest.encoder.patch._value
                case .post: return Far._api.dataRequest.encoder.post._value
                case .put: return Far._api.dataRequest.encoder.put._value
                    
                // default
                default: return Alamofire.URLEncodedFormParameterEncoder.default
            }
        }
    }
    
    /// Modify URLRequest
    static func _urlRequestModifier(context: Settings.API.Modified) -> (inout Foundation.URLRequest) throws -> Swift.Void {
        // NOTE: Make sure not access `Context` in block
        return { [urlRequestModifiers = context.dataRequest.urlRequestModifiers] (urlRequest) in
            for modifier in urlRequestModifiers {
                try modifier(&urlRequest)
            }
        }
    }
    
    /// Authentication
    static func _authenticate(context: Settings.API.Modified) -> Foundation.URLCredential? {
        context.dataRequest.authenticate
    }
    
    /// Redirect
    static func _redirectHandler(context: Settings.API.Modified) -> Alamofire.RedirectHandler? {
        context.dataRequest.redirectHandler ?? Far._api.dataRequest.redirect._value
    }
}


// MARK: - DataResponse
extension Settings.API {
    
    /// Validate DataResponse
    static func _validation(context: Settings.API.Modified) -> (Swift.Range<Swift.Int>?, [Swift.String]?, [Swift.String : DataRequest.Validation]) {
        let acceptableStatusCodes = context.dataResponse.acceptableStatusCodes ??
        Far._api.dataResponse.acceptableStatusCodes._value
        
        let acceptableContentTypes = context.dataResponse.acceptableContentTypes?() ??
        Far._api.dataResponse.acceptableContentTypes._value
        
        let validations = context.dataResponse.validations.merging(Far._api.dataResponse.validations._value ?? [:], uniquingKeysWith: { (current, _) in current }) /* merging using Store.API.Modify value */
        
        return (acceptableStatusCodes, acceptableContentTypes, validations)
    }
    
    /// Cache DataResponse
    static func _cachedResponseHandler(context: Settings.API.Modified) -> Alamofire.CachedResponseHandler? {
        context.dataResponse.cachedResponseHandler ?? Far._api.dataResponse.cachedResponseHandler._value
    }
    
    /// DispatchQueue
    static func _queue(context: Settings.API.Modified) -> DispatchQueue {
        context.dataResponse.queue ?? Far._api.dataResponse.queue._value
    }
    
    /// Serialize Data
    static func _dataResponseSerializer(context: Settings.API.Modified) -> Alamofire.DataResponseSerializer {
        let dataPreprocessor = context.dataResponse.serializeData.dataPreprocessor ??
        Far._api.dataResponse.serializeData.dataPreprocessor._value
        
        let emptyResponseCodes = context.dataResponse.serializeData.emptyResponseCodes ??
        Far._api.dataResponse.serializeData.emptyResponseCodes._value
        
        let emptyRequestMethods = context.dataResponse.serializeData.emptyRequestMethods ??
        Far._api.dataResponse.serializeData.emptyRequestMethods._value
        
        return Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods)
    }
    
    /// Serialize String
    static func _stringResponseSerializer(context: Settings.API.Modified) -> Alamofire.StringResponseSerializer {
        let dataPreprocessor = context.dataResponse.serializeString.dataPreprocessor ??
        Far._api.dataResponse.serializeString.dataPreprocessor._value
        
        let encoding = context.dataResponse.serializeString.encoding ??
        Far._api.dataResponse.serializeString.encoding._value
        
        let emptyResponseCodes = context.dataResponse.serializeString.emptyResponseCodes ??
        Far._api.dataResponse.serializeString.emptyResponseCodes._value
        
        let emptyRequestMethods = context.dataResponse.serializeString.emptyRequestMethods ??
        Far._api.dataResponse.serializeString.emptyRequestMethods._value
        
        return Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                  encoding: encoding,
                                                  emptyResponseCodes: emptyResponseCodes,
                                                  emptyRequestMethods: emptyRequestMethods)
    }
    
    /// Serialize JSON
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    static func _jsonResponseSerializer(context: Settings.API.Modified) -> Alamofire.JSONResponseSerializer {
        let dataPreprocessor = context.dataResponse.serializeJSON.dataPreprocessor ??
        Far._api.dataResponse.serializeJSON.dataPreprocessor._value
        
        let emptyResponseCodes = context.dataResponse.serializeJSON.emptyResponseCodes ??
        Far._api.dataResponse.serializeJSON.emptyResponseCodes._value
        
        let emptyRequestMethods = context.dataResponse.serializeJSON.emptyRequestMethods ??
        Far._api.dataResponse.serializeJSON.emptyRequestMethods._value
        
        let options = context.dataResponse.serializeJSON.options ??
        Far._api.dataResponse.serializeJSON.options._value
        
        return Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods,
                                                options: options)
    }
    
    /// Serialize Decodable
    static func _decodableResponseSerializer<R>(context: Settings.API.Modified) -> Alamofire.DecodableResponseSerializer<R>
    where R: Swift.Decodable {
        let dataPreprocessor = context.dataResponse.serializeDecodable.dataPreprocessor ??
        Far._api.dataResponse.serializeDecodable.dataPreprocessor._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultDataPreprocessor
        
        let decoder = context.dataResponse.serializeDecodable.decoder ??
        Far._api.dataResponse.serializeDecodable.decoder._value ??
        Foundation.JSONDecoder()
        
        let emptyResponseCodes = context.dataResponse.serializeDecodable.emptyResponseCodes ??
        Far._api.dataResponse.serializeDecodable.emptyResponseCodes._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultEmptyResponseCodes
        
        let emptyRequestMethods = context.dataResponse.serializeDecodable.emptyRequestMethods ??
        Far._api.dataResponse.serializeDecodable.emptyRequestMethods._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultEmptyRequestMethods
        
        return Alamofire.DecodableResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                     decoder: decoder,
                                                     emptyResponseCodes: emptyResponseCodes,
                                                     emptyRequestMethods: emptyRequestMethods)
    }
}

// MARK: - Accessing
extension Settings.API {
    
    /// Accessing Request
    static func _accessingRequest(context: Settings.API.Modified) -> Available<Alamofire.Request>? {
        context.accessing.onRequestAvailable
    }
}


// MARK: - Helper Type
extension Settings.API {
    
    /// for `Alamofire.URLConvertible`
    typealias _URLResult = _Result<Foundation.URL, Alamofire.AFError>
}

extension Settings.API._URLResult: Alamofire.URLConvertible {
    
    func asURL() throws -> URL {
        switch self {
            case .success(let url): return url
            case .failure(let error): throw error
        }
    }
}
