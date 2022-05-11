//
//  Store.API.Modify.swift
//

import Foundation
import Alamofire


extension Store.API {
    
    public final class Modify {
        
        // DataRequest Location
        let requestLocation: _Location
        
        // DataRequest
        var dataRequest = Store.API.Modify._DataRequest()
        
        // DataResponse
        var dataResponse = Store.API.Modify._DataResponse()
        
        // Accessing
        var accessing = Store.API.Modify._Accessing()
        
        /// init
        init(requestLocation: _Location) {
            self.requestLocation = requestLocation
        }
    }
}


extension Store.API.Modify {
    
    // MARK: DataRequest
    /// _DataRequest
    struct _DataRequest {
        
        // API
        var api = Store.API.Modify._API()
        
        // Headers
        var headers: Alamofire.HTTPHeaders = Alamofire.HTTPHeaders()
        
        // Encoding/Encoder
        var encoding: Alamofire.ParameterEncoding?
        var encoder: Alamofire.ParameterEncoder?
        
        // URLRequest Modifiers
        var urlRequestModifiers: [MutatingAvailable<URLRequest>] = []
        
        // Authentication
        var authenticate: URLCredential?
        
        // Redirect
        var redirectHandler: Alamofire.RedirectHandler?
    }
    
    
    // MARK: DataResponse
    /// _DataResponse
    struct _DataResponse {
                
        // Validate DataResponse
        var acceptableStatusCodes: Range<Int>?
        var acceptableContentTypes: Compute<[String]>?
        var validations: [String: Alamofire.DataRequest.Validation] = [:]
        
        // Cache DataResponse
        var cachedResponseHandler: Alamofire.CachedResponseHandler?
        
        // DispatchQueue
        var queue: DispatchQueue?
        
        // Serialize DataResponse
        var serializeData = Store.API.Modify._SerializeData()
        var serializeString = Store.API.Modify._SerializeString()
        var serializeJSON = Store.API.Modify._SerializeJSON()
        var serializeDecodable = Store.API.Modify._SerializeDecodable()
    }
    
    
    // MARK: Accessing
    /// _Accessing
    struct _Accessing {
        
        var onRequestAvailable: Available<Alamofire.Request>?
    }
    
    
    // MARK: DataRequest.API
    /// _API
    struct _API {
        
        // Method
        var method: Alamofire.HTTPMethod?
        
        // Initial URL
        var initialURL: DataRequestModifier.InitialURL._Type?
        
        // Modify URL
        var base: Compute<String>?
        var appendPaths: [Compute<String>] = []
        var mock: Compute<String>?
    }
    
    
    // MARK: - DataRequest.Encoder/Encoding
    /// _Encoder
    struct _Encoder {
        
        /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        var get: Alamofire.ParameterEncoder?
        
        /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        var delete: Alamofire.ParameterEncoder?
        
        /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var patch: Alamofire.ParameterEncoder?
        
        /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var post: Alamofire.ParameterEncoder?
        
        /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var put: Alamofire.ParameterEncoder?
    }
    
    /// _Encoding
    struct _Encoding {
        
        /// for `get` encoding. default: `Alamofire.URLEncoding.default`
        var get: Alamofire.ParameterEncoding?
        
        /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
        var delete: Alamofire.ParameterEncoding?
        
        /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
        var patch: Alamofire.ParameterEncoding?
        
        /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
        var post: Alamofire.ParameterEncoding?
        
        /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
        var put: Alamofire.ParameterEncoding?
    }
    
    
    // MARK: - DataResponse.Serializer
    /// _SerializeData
    struct _SerializeData {
        
        /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
    }
    
    /// _SerializeString
    struct _SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `nil`
        var encoding: String.Encoding?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
    }
    
    /// _SerializeJSON
    struct _SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
        
        /// default `.allowFragments`
        var options: JSONSerialization.ReadingOptions?
    }
    
    /// _SerializeDecodable
    struct _SerializeDecodable {
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `JSONDecoder`
        var decoder: Alamofire.DataDecoder?
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyResponseCodes`
        var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyRequestMethods`
        var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
    }
}
