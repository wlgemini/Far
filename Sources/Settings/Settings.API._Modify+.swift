//
//  Settings.API._Modify+
//

import Foundation
import Alamofire


// MARK: - DataRequest
extension Settings.API._Modify {
    
    // MARK: HTTPMethod
    func _method() throws -> Alamofire.HTTPMethod {
        guard let method = self.dataRequest.api.method else {
            _Log.error("`HTTPMethod` not set, request won't start", location: self.requestLocation)
            throw FarError.method("`HTTPMethod` not set")
        }
        
        return method
    }
    
    // MARK: - URL
    func _url() throws -> Foundation.URL {
        
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
        
        guard let initialURL = self.dataRequest.api.initialURL else {
            _Log.error("`InitialURL` not set, request won't start", location: self.requestLocation)
            throw FarError.url("`InitialURL` not set")
        }
        
        var anyAbsoluteURL: Foundation.URL?
        
        switch initialURL {
            case .full(let fullURLStringCompute):
                var fullURLString = fullURLStringCompute()
                _dropLastForwardSlash(&fullURLString)
                
                if let fullURL = Foundation.URL(string: fullURLString) {
                    anyAbsoluteURL = fullURL
                } else {
                    _Log.error("`\(fullURLString)` doesn’t represent a valid URL, request won't start", location: self.requestLocation)
                }
                
            case .path(let pathStingCompute):
                var pathSting = pathStingCompute()
                _dropFirstForwardSlash(&pathSting)
                _dropLastForwardSlash(&pathSting)
                
                // using `modify base url` or `setting base url`
                let anyBaseURLSting = self.dataRequest.api.base?() ?? Far._api.dataRequest.base._value()
                
                if var baseURLSting = anyBaseURLSting {
                    _dropLastForwardSlash(&baseURLSting)
                    
                    if var baseURL = Foundation.URL(string: baseURLSting) {
                        baseURL.appendPathComponent(pathSting)
                        anyAbsoluteURL = baseURL
                    } else {
                        _Log.error("For API `\(pathSting)`, `\(baseURLSting)` doesn’t represent a valid URL, request won't start", location: self.requestLocation)
                    }
                } else {
                    _Log.error("For API `\(pathSting)`, base URL not set, request won't start", location: self.requestLocation)
                }
        }
        
        guard var absoluteURL = anyAbsoluteURL else {
            throw FarError.url("URL doesn’t valid, see error log for more detail.")
        }
        
        // append paths
        for pathStingCompute in self.dataRequest.api.appendPaths {
            var pathSting = pathStingCompute()
            _dropFirstForwardSlash(&pathSting)
            _dropLastForwardSlash(&pathSting)
            
            absoluteURL.appendPathComponent(pathSting)
        }
        
        // mock only in debug mode
        _Debug.execute {
            if let mockURLStingCompute = self.dataRequest.api.mock {
                var mockURLString = mockURLStingCompute()
                _dropLastForwardSlash(&mockURLString)
                
                if let mockURL = URL(string: mockURLString) {
                    absoluteURL = mockURL
                    _Log.warning("Using mock URL `\(mockURL)` for `\(absoluteURL)`", location: self.requestLocation)
                } else {
                    _Log.warning("Mock URL string`\(mockURLString)` doesn’t represent a valid URL", location: self.requestLocation)
                }
            }
        }
        
        return absoluteURL
    }
    
    // MARK: HTTPHeaders
    func _headers() -> Alamofire.HTTPHeaders {
        // combinedHeaders init from `Far._default.dataRequest.headers` or an empty headers
        var combinedHeaders = Far._api.dataRequest.headers._value() ?? Alamofire.HTTPHeaders()
        
        // Context.dataRequest.headers override or appends to combinedHeaders
        for h in self.dataRequest.headers {
            combinedHeaders.add(h)
        }
        
        return combinedHeaders
    }
    
    // MARK: Encoding
    func _encoding() -> Alamofire.ParameterEncoding {
        if let encoding = self.dataRequest.encoding {
            return encoding
            
        } else {
            guard let method = self.dataRequest.api.method else {
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
    
    // MARK: Encoder
    func _encoder() -> Alamofire.ParameterEncoder {
        if let encoder = self.dataRequest.encoder {
            return encoder
            
        } else {
            guard let method = self.dataRequest.api.method else {
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
    
    // MARK: Modify URLRequest
    func _urlRequestModifier() -> (inout Foundation.URLRequest) throws -> Swift.Void {
        // NOTE: Make sure not access `Context` in block
        return { [urlRequestModifiers = self.dataRequest.urlRequestModifiers] (urlRequest) in
            for modifier in urlRequestModifiers {
                try modifier(&urlRequest)
            }
        }
    }
    
    // MARK: Authentication
    func _authenticate() -> Foundation.URLCredential? {
        self.dataRequest.authenticate
    }
    
    // MARK: Redirect
    func _redirectHandler() -> Alamofire.RedirectHandler? {
        self.dataRequest.redirectHandler ?? Far._api.dataRequest.redirect._value
    }
}


// MARK: - DataResponse
extension Settings.API._Modify {
    
    // MARK: Validate DataResponse
    func _validation() -> (Swift.Range<Swift.Int>?, [Swift.String]?, [Swift.String : DataRequest.Validation]) {
        let acceptableStatusCodes = self.dataResponse.acceptableStatusCodes ??
        Far._api.dataResponse.acceptableStatusCodes._value
        
        let acceptableContentTypes = self.dataResponse.acceptableContentTypes?() ??
        Far._api.dataResponse.acceptableContentTypes._value
        
        let validations = self.dataResponse.validations.merging(Far._api.dataResponse.validations._value ?? [:], uniquingKeysWith: { (current, _) in current }) /* merging using Store.API.Modify value */
        
        return (acceptableStatusCodes, acceptableContentTypes, validations)
    }
    
    // MARK: Cache DataResponse
    func _cachedResponseHandler() -> Alamofire.CachedResponseHandler? {
        self.dataResponse.cachedResponseHandler ?? Far._api.dataResponse.cachedResponseHandler._value
    }
    
    // MARK: DispatchQueue
    func _queue() -> DispatchQueue {
        self.dataResponse.queue ?? Far._api.dataResponse.queue._value
    }
    
    // MARK: Serialize DataResponse
    func _dataResponseSerializer() -> Alamofire.DataResponseSerializer {
        let dataPreprocessor = self.dataResponse.serializeData.dataPreprocessor ??
        Far._api.dataResponse.serializeData.dataPreprocessor._value
        
        let emptyResponseCodes = self.dataResponse.serializeData.emptyResponseCodes ??
        Far._api.dataResponse.serializeData.emptyResponseCodes._value
        
        let emptyRequestMethods = self.dataResponse.serializeData.emptyRequestMethods ??
        Far._api.dataResponse.serializeData.emptyRequestMethods._value
        
        return Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods)
    }
    
    func _stringResponseSerializer() -> Alamofire.StringResponseSerializer {
        let dataPreprocessor = self.dataResponse.serializeString.dataPreprocessor ??
        Far._api.dataResponse.serializeString.dataPreprocessor._value
        
        let encoding = self.dataResponse.serializeString.encoding ??
        Far._api.dataResponse.serializeString.encoding._value
        
        let emptyResponseCodes = self.dataResponse.serializeString.emptyResponseCodes ??
        Far._api.dataResponse.serializeString.emptyResponseCodes._value
        
        let emptyRequestMethods = self.dataResponse.serializeString.emptyRequestMethods ??
        Far._api.dataResponse.serializeString.emptyRequestMethods._value
        
        return Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                  encoding: encoding,
                                                  emptyResponseCodes: emptyResponseCodes,
                                                  emptyRequestMethods: emptyRequestMethods)
    }
    
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func _jsonResponseSerializer() -> Alamofire.JSONResponseSerializer {
        let dataPreprocessor = self.dataResponse.serializeJSON.dataPreprocessor ??
        Far._api.dataResponse.serializeJSON.dataPreprocessor._value
        
        let emptyResponseCodes = self.dataResponse.serializeJSON.emptyResponseCodes ??
        Far._api.dataResponse.serializeJSON.emptyResponseCodes._value
        
        let emptyRequestMethods = self.dataResponse.serializeJSON.emptyRequestMethods ??
        Far._api.dataResponse.serializeJSON.emptyRequestMethods._value
        
        let options = self.dataResponse.serializeJSON.options ??
        Far._api.dataResponse.serializeJSON.options._value
        
        return Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods,
                                                options: options)
    }
    
    func _decodableResponseSerializer<R>() -> Alamofire.DecodableResponseSerializer<R>
    where R: Swift.Decodable {
        let dataPreprocessor = self.dataResponse.serializeDecodable.dataPreprocessor ??
        Far._api.dataResponse.serializeDecodable.dataPreprocessor._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultDataPreprocessor
        
        let decoder = self.dataResponse.serializeDecodable.decoder ??
        Far._api.dataResponse.serializeDecodable.decoder._value ??
        Foundation.JSONDecoder()
        
        let emptyResponseCodes = self.dataResponse.serializeDecodable.emptyResponseCodes ??
        Far._api.dataResponse.serializeDecodable.emptyResponseCodes._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultEmptyResponseCodes
        
        let emptyRequestMethods = self.dataResponse.serializeDecodable.emptyRequestMethods ??
        Far._api.dataResponse.serializeDecodable.emptyRequestMethods._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultEmptyRequestMethods
        
        return Alamofire.DecodableResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                     decoder: decoder,
                                                     emptyResponseCodes: emptyResponseCodes,
                                                     emptyRequestMethods: emptyRequestMethods)
    }
}

// MARK: - Accessing
extension Settings.API._Modify {
    
    // MARK: - Accessing Request
    func _accessingRequest() -> Available<Alamofire.Request>? {
        self.accessing.onRequestAvailable
    }
}
