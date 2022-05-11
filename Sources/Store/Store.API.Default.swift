//
//  Store.API.Default.swift
//

import Foundation
import Alamofire


// MARK: API
extension Store.API {
    
    /// API
    public final class Default {
        
        public var dataRequest = DataRequest()
        
        public var dataResponse = DataResponse()
        
        init() {}
    }
}


// MARK: - DataRequest/DataResponse
extension Store.API.Default {
    
    /// DataRequest
    public struct DataRequest {
        
        // MARK: URL
        public var base = Setter.Compute.Nillable<String>()
        
        // MARK: Headers
        public var headers = Setter.Compute.Nillable<Alamofire.HTTPHeaders>()
        
        // MARK: Encoding/Encoder
        public var encoding = Encoding()
        public var encoder = Encoder()
        
        // MARK: Authentication
        public var authenticate = Setter.Copy.Nillable<URLCredential>()
        
        // MARK: Redirect
        public var redirect = Setter.Copy.Nillable<Alamofire.RedirectHandler>()
        
        init() {}
    }
    
    /// DataResponse
    public struct DataResponse {
        
        // MARK: Validate DataResponse
        /// acceptable range, may override by Modifier.
        public var acceptableStatusCodes = Setter.Copy.Nillable<Range<Int>>()
        
        /// acceptable content type, may override by Modifier.
        public var acceptableContentTypes = Setter.Copy.Nillable<[String]>()
        
        /// custom validations, may override by Modifier, default: nil
        public var validations = Setter.Copy.Nillable<[String: Alamofire.DataRequest.Validation]>()
        
        // MARK: Cache DataResponse
        public var cachedResponseHandler = Setter.Copy.Nillable<Alamofire.CachedResponseHandler>()
        
        // MARK: DispatchQueue
        /// default: .main
        public var queue = Setter.Copy.Nonnil<DispatchQueue>(.main)
        
        // MARK: Serialize DataResponse
        public var serializeData = SerializeData()
        public var serializeString = SerializeString()
        public var serializeJSON = SerializeJSON()
        public var serializeDecodable = SerializeDecodable()
        
        init() {}
    }
}


// MARK: - Encoder/Encoding
extension Store.API.Default {
    
    /// Encoder
    public struct Encoder {
        
        /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        public var get = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.URLEncodedFormParameterEncoder.default)
        
        /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        public var delete = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.URLEncodedFormParameterEncoder.default)
        
        /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var patch = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.JSONParameterEncoder.default)
        
        /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var post = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.JSONParameterEncoder.default)
        
        /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var put = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.JSONParameterEncoder.default)
        
        init() {}
    }
    
    /// Encoding
    public struct Encoding {
        
        /// for `get` encoding. default: `Alamofire.URLEncoding.default`
        public var get = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.URLEncoding.default)
        
        /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
        public var delete = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.URLEncoding.default)
        
        /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
        public var patch = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.JSONEncoding.default)
        
        /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
        public var post = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.JSONEncoding.default)
        
        /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
        public var put = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.JSONEncoding.default)
        
        init() {}
    }
}


// MARK: - Serializer
extension Store.API.Default {
    
    /// SerializeData
    public struct SerializeData {
        
        /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nonnil<Alamofire.DataPreprocessor>(Alamofire.DataResponseSerializer.defaultDataPreprocessor)
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nonnil<Set<Int>>(Alamofire.DataResponseSerializer.defaultEmptyResponseCodes)
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nonnil<Set<Alamofire.HTTPMethod>>(Alamofire.DataResponseSerializer.defaultEmptyRequestMethods)
        
        init() {}
    }
    
    /// SerializeString
    public struct SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nonnil<Alamofire.DataPreprocessor>(Alamofire.StringResponseSerializer.defaultDataPreprocessor)
        
        /// default `nil`
        public var encoding = Setter.Copy.Nillable<String.Encoding>()
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nonnil<Set<Int>>(Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nonnil<Set<Alamofire.HTTPMethod>>(Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
        
        init() {}
    }
    
    /// SerializeJSON
    public struct SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
        public var dataPreprocessor = Setter.Copy.Nonnil<Alamofire.DataPreprocessor>(Alamofire.JSONResponseSerializer.defaultDataPreprocessor)
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
        public var emptyResponseCodes = Setter.Copy.Nonnil<Set<Int>>(Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes)
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
        public var emptyRequestMethods = Setter.Copy.Nonnil<Set<Alamofire.HTTPMethod>>(Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods)
        
        /// default `.allowFragments`
        public var options = Setter.Copy.Nonnil<JSONSerialization.ReadingOptions>(.allowFragments)
        
        init() {}
    }
    
    /// SerializeDecodable
    public struct SerializeDecodable {
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nillable<Alamofire.DataPreprocessor>()
        
        /// default `JSONDecoder`
        public var decoder = Setter.Copy.Nillable<Alamofire.DataDecoder>()
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nillable<Set<Int>>()
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nillable<Set<Alamofire.HTTPMethod>>()
        
        init() {}
    }
}
