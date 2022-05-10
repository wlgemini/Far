//
//  Store.API._Default.swift
//

import Foundation
import Alamofire


extension Store.API {
    
    final class _Default {
        
        // DataRequest
        let dataRequest = Store.API._Default._DataRequest()
        
        // DataResponse
        let dataResponse = Store.API._Default._DataResponse()
    }
}


// MARK: - DataRequest/DataResponse
extension Store.API._Default {
    
    /// _DataRequest
    final class _DataRequest {
        
        // MARK: URL
        var base: Compute<String>?
        
        // MARK: Headers
        var headers: Compute<Alamofire.HTTPHeaders>?
        
        // MARK: Encoding/Encoder
        var encoding = Store.API._Default._Encoding()
        var encoder = Store.API._Default._Encoder()
        
        // MARK: Authentication
        var authenticate: URLCredential?
        
        // MARK: Redirect
        var redirect: Alamofire.RedirectHandler?
    }
    
    /// _DataResponse
    final class _DataResponse {
        
        // MARK: Validate DataResponse
        /// acceptable range, may override by Modifier.
        var acceptableStatusCodes: Range<Int>?
        
        /// acceptable content type, may override by Modifier.
        var acceptableContentTypes: [String]?
        
        /// custom validations, may override by Modifier, default: nil
        var validations: [String: Alamofire.DataRequest.Validation]?
        
        // MARK: Cache DataResponse
        var cachedResponseHandler: Alamofire.CachedResponseHandler?
        
        // MARK: DispatchQueue
        /// default: .main
        var queue: DispatchQueue = .main
        
        // MARK: Serialize DataResponse
        let serializeData = Store.API._Default._SerializeData()
        let serializeString = Store.API._Default._SerializeString()
        let serializeJSON = Store.API._Default._SerializeJSON()
        let serializeDecodable = Store.API._Default._SerializeDecodable()
    }
}


// MARK: - Encoder/Encoding
extension Store.API._Default {
    
    /// _Encoder
    final class _Encoder {
        
        /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        var get: Alamofire.ParameterEncoder = Alamofire.URLEncodedFormParameterEncoder.default
        
        /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        var delete: Alamofire.ParameterEncoder = Alamofire.URLEncodedFormParameterEncoder.default
        
        /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var patch: Alamofire.ParameterEncoder = Alamofire.JSONParameterEncoder.default
        
        /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var post: Alamofire.ParameterEncoder = Alamofire.JSONParameterEncoder.default
        
        /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var put: Alamofire.ParameterEncoder = Alamofire.JSONParameterEncoder.default
    }
    
    /// _Encoding
    final class _Encoding {
        
        /// for `get` encoding. default: `Alamofire.URLEncoding.default`
        var get: Alamofire.ParameterEncoding = Alamofire.URLEncoding.default
        
        /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
        var delete: Alamofire.ParameterEncoding = Alamofire.URLEncoding.default
        
        /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
        var patch: Alamofire.ParameterEncoding = Alamofire.JSONEncoding.default
        
        /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
        var post: Alamofire.ParameterEncoding = Alamofire.JSONEncoding.default
        
        /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
        var put: Alamofire.ParameterEncoding = Alamofire.JSONEncoding.default
    }
}


// MARK: - Serializer
extension Store.API._Default {
    
    /// _SerializeData
    final class _SerializeData {
        
        /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Set<Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods
    }
    
    /// _SerializeString
    final class _SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        var dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.StringResponseSerializer.defaultDataPreprocessor
        
        /// default `nil`
        var encoding: String.Encoding?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        var emptyResponseCodes: Set<Int> = Alamofire.StringResponseSerializer.defaultEmptyResponseCodes
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        var emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.StringResponseSerializer.defaultEmptyRequestMethods
    }
    
    /// _SerializeJSON
    final class _SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
        var dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
        var emptyResponseCodes: Set<Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
        var emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods
        
        /// default `.allowFragments`
        var options: JSONSerialization.ReadingOptions = .allowFragments
    }
    
    /// _SerializeDecodable
    final class _SerializeDecodable {
        
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
