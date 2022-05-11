//
//  Store.API.Modify+Helper
//

import Foundation
import Alamofire


// MARK: - DataRequest
extension Store.API.Modify {
    
    // MARK: HTTPMethod
    func _method() -> Alamofire.HTTPMethod? {
        guard let method = self.dataRequest.api.method else {
            _Log.error("`HTTPMethod` not set, request won't start", location: self.requestLocation)
            return nil
        }
        
        return method
    }
    
    // MARK: - URL
    func _url() -> String? {
        guard let initialURL = self.dataRequest.api.initialURL else {
            _Log.error("`InitialURL` not set, request won't start", location: self.requestLocation)
            return nil
        }
        
        var anyFullURL: String?
        
        switch initialURL {
            case .full(let fullURL):
                anyFullURL = fullURL()
                
            case .path(let pathURL):
                // modify `base url` or setting `base url`
                let anyBaseURL = self.dataRequest.api.base?() ?? Far.api.dataRequest.base._value()
                
                if let baseURL = anyBaseURL {
                    anyFullURL = baseURL + pathURL()
                } else {
                    _Log.error("Base URL not set, request won't start", location: self.requestLocation)
                }
        }
        
        guard var fullURL = anyFullURL else { return nil }
        
        // append paths
        let appendPaths = self.dataRequest.api.appendPaths.reduce("", { $0 + $1() })
        fullURL += appendPaths
        
        // mock only in debug mode
        _Debug.only {
            if let mock = self.dataRequest.api.mock {
                let mockURL = mock()
                _Log.warning("Using mock `\(mockURL)` for `\(fullURL)`", location: self.requestLocation)
                fullURL = mockURL
            }
        }
        
        return fullURL
    }
    
    // MARK: HTTPHeaders
    func _headers() -> Alamofire.HTTPHeaders {
        // combinedHeaders init from `Store._api.dataRequest.headers()` or an empty headers
        var combinedHeaders = Far.api.dataRequest.headers._value() ?? Alamofire.HTTPHeaders()
        
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
                case .get: return Far.api.dataRequest.encoding.get._value
                case .delete: return Far.api.dataRequest.encoding.delete._value
                    
                // JSONEncoding
                case .patch: return Far.api.dataRequest.encoding.patch._value
                case .post: return Far.api.dataRequest.encoding.post._value
                case .put: return Far.api.dataRequest.encoding.put._value
                    
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
                case .get: return Far.api.dataRequest.encoder.get._value
                case .delete: return Far.api.dataRequest.encoder.delete._value
                    
                // JSONEncoding
                case .patch: return Far.api.dataRequest.encoder.patch._value
                case .post: return Far.api.dataRequest.encoder.post._value
                case .put: return Far.api.dataRequest.encoder.put._value
                    
                // default
                default: return Alamofire.URLEncodedFormParameterEncoder.default
            }
        }
    }
    
    // MARK: Modify URLRequest
    func _urlRequestModifier() -> (inout URLRequest) throws -> Void {
        // NOTE: Make sure not access `Context` in block
        return { [urlRequestModifiers = self.dataRequest.urlRequestModifiers] (urlRequest) in
            for modifier in urlRequestModifiers {
                try modifier(&urlRequest)
            }
        }
    }
    
    // MARK: Authentication
    func _authenticate() -> URLCredential? {
        self.dataRequest.authenticate
    }
    
    // MARK: Redirect
    func _redirectHandler() -> Alamofire.RedirectHandler? {
        self.dataRequest.redirectHandler ?? Far.api.dataRequest.redirect._value
    }
}


// MARK: - DataResponse
extension Store.API.Modify {
    
    // MARK: Validate DataResponse
    func _validation() -> (Range<Int>?, [String]?, [String : DataRequest.Validation]) {
        let acceptableStatusCodes = self.dataResponse.acceptableStatusCodes ??
        Far.api.dataResponse.acceptableStatusCodes._value
        
        let acceptableContentTypes = self.dataResponse.acceptableContentTypes?() ??
        Far.api.dataResponse.acceptableContentTypes._value
        
        let validations = self.dataResponse.validations.merging(Far.api.dataResponse.validations._value ?? [:], uniquingKeysWith: { (current, _) in current }) /* merging using Store.API.Modify value */
        
        return (acceptableStatusCodes, acceptableContentTypes, validations)
    }
    
    // MARK: Cache DataResponse
    func _cachedResponseHandler() -> Alamofire.CachedResponseHandler? {
        self.dataResponse.cachedResponseHandler ?? Far.api.dataResponse.cachedResponseHandler._value
    }
    
    // MARK: DispatchQueue
    func _queue() -> DispatchQueue {
        self.dataResponse.queue ?? Far.api.dataResponse.queue._value
    }
    
    // MARK: Serialize DataResponse
    func _dataResponseSerializer() -> Alamofire.DataResponseSerializer {
        let dataPreprocessor = self.dataResponse.serializeData.dataPreprocessor ??
        Far.api.dataResponse.serializeData.dataPreprocessor._value
        
        let emptyResponseCodes = self.dataResponse.serializeData.emptyResponseCodes ??
        Far.api.dataResponse.serializeData.emptyResponseCodes._value
        
        let emptyRequestMethods = self.dataResponse.serializeData.emptyRequestMethods ??
        Far.api.dataResponse.serializeData.emptyRequestMethods._value
        
        return Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods)
    }
    
    func _stringResponseSerializer() -> Alamofire.StringResponseSerializer {
        let dataPreprocessor = self.dataResponse.serializeString.dataPreprocessor ??
        Far.api.dataResponse.serializeString.dataPreprocessor._value
        
        let encoding = self.dataResponse.serializeString.encoding ??
        Far.api.dataResponse.serializeString.encoding._value
        
        let emptyResponseCodes = self.dataResponse.serializeString.emptyResponseCodes ??
        Far.api.dataResponse.serializeString.emptyResponseCodes._value
        
        let emptyRequestMethods = self.dataResponse.serializeString.emptyRequestMethods ??
        Far.api.dataResponse.serializeString.emptyRequestMethods._value
        
        return Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                  encoding: encoding,
                                                  emptyResponseCodes: emptyResponseCodes,
                                                  emptyRequestMethods: emptyRequestMethods)
    }
    
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func _jsonResponseSerializer() -> Alamofire.JSONResponseSerializer {
        let dataPreprocessor = self.dataResponse.serializeJSON.dataPreprocessor ??
        Far.api.dataResponse.serializeJSON.dataPreprocessor._value
        
        let emptyResponseCodes = self.dataResponse.serializeJSON.emptyResponseCodes ??
        Far.api.dataResponse.serializeJSON.emptyResponseCodes._value
        
        let emptyRequestMethods = self.dataResponse.serializeJSON.emptyRequestMethods ??
        Far.api.dataResponse.serializeJSON.emptyRequestMethods._value
        
        let options = self.dataResponse.serializeJSON.options ??
        Far.api.dataResponse.serializeJSON.options._value
        
        return Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods,
                                                options: options)
    }
    
    func _decodableResponseSerializer<R>() -> Alamofire.DecodableResponseSerializer<R>
    where R: Decodable {
        let dataPreprocessor = self.dataResponse.serializeDecodable.dataPreprocessor ??
        Far.api.dataResponse.serializeDecodable.dataPreprocessor._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultDataPreprocessor
        
        let decoder = self.dataResponse.serializeDecodable.decoder ??
        Far.api.dataResponse.serializeDecodable.decoder._value ??
        JSONDecoder()
        
        let emptyResponseCodes = self.dataResponse.serializeDecodable.emptyResponseCodes ??
        Far.api.dataResponse.serializeDecodable.emptyResponseCodes._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultEmptyResponseCodes
        
        let emptyRequestMethods = self.dataResponse.serializeDecodable.emptyRequestMethods ??
        Far.api.dataResponse.serializeDecodable.emptyRequestMethods._value ??
        Alamofire.DecodableResponseSerializer<R>.defaultEmptyRequestMethods
        
        return Alamofire.DecodableResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                     decoder: decoder,
                                                     emptyResponseCodes: emptyResponseCodes,
                                                     emptyRequestMethods: emptyRequestMethods)
    }
}

// MARK: - Accessing
extension Store.API.Modify {
    
    // MARK: - Accessing Request
    func _accessingRequest() -> Available<Alamofire.Request>? {
        self.accessing.onRequestAvailable
    }
}
