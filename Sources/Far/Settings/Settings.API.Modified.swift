//
//  Settings.API.Modified.swift
//

import Foundation
import Alamofire


extension Settings.API {
    
    public final class Modified {
        
        // DataRequest Location
        let requestLocation: Location
        
        // DataRequest
        var dataRequest = Settings.API.Modified._DataRequest()
        
        // DataResponse
        var dataResponse = Settings.API.Modified._DataResponse()
        
        // Accessing
        var accessing = Settings.API.Modified._Accessing()
        
        /// init
        init(requestLocation: Location) {
            self.requestLocation = requestLocation
        }
    }
}


extension Settings.API.Modified {
    
    // MARK: DataRequest
    /// _DataRequest
    struct _DataRequest {
        
        // API
        var api = Settings.API.Modified._API()
        
        // Headers
        var headers: Alamofire.HTTPHeaders = Alamofire.HTTPHeaders()
        
        // Encoding/Encoder
        var encoding: Alamofire.ParameterEncoding?
        var encoder: Alamofire.ParameterEncoder?
        
        // URLRequest Modifiers
        var urlRequestModifiers: [MutatingAvailable<Foundation.URLRequest>] = []
        
        // Authentication
        var authenticate: Foundation.URLCredential?
        
        // Redirect
        var redirectHandler: Alamofire.RedirectHandler?
    }
    
    
    // MARK: DataResponse
    /// _DataResponse
    struct _DataResponse {
        
        // Validate DataResponse
        var acceptableStatusCodes: Swift.Range<Int>?
        var acceptableContentTypes: Compute<[Swift.String]>?
        var validations: [Swift.String: Alamofire.DataRequest.Validation] = [:]
        
        // Cache DataResponse
        var cachedResponseHandler: Alamofire.CachedResponseHandler?
        
        // DispatchQueue
        var queue: DispatchQueue?
        
        // Serialize DataResponse
        var serializeData = Settings.API.Modified._SerializeData()
        var serializeString = Settings.API.Modified._SerializeString()
        var serializeJSON = Settings.API.Modified._SerializeJSON()
        var serializeDecodable = Settings.API.Modified._SerializeDecodable()
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
        var base: Compute<Swift.String>?
        var appendPaths: [Compute<Swift.String>] = []
        var mock: Compute<Swift.String>?
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
        var emptyResponseCodes: Swift.Set<Int>?
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod>?
    }
    
    /// _SerializeString
    struct _SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `nil`
        var encoding: Swift.String.Encoding?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Swift.Set<Int>?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod>?
    }
    
    /// _SerializeJSON
    struct _SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Swift.Set<Int>?
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod>?
        
        /// default `.allowFragments`
        var options: Foundation.JSONSerialization.ReadingOptions?
    }
    
    /// _SerializeDecodable
    struct _SerializeDecodable {
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `JSONDecoder`
        var decoder: Alamofire.DataDecoder?
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyResponseCodes`
        var emptyResponseCodes: Swift.Set<Int>?
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyRequestMethods`
        var emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod>?
    }
}
