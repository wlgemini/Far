//
//  API+Modify.swift
//

import Foundation
import Alamofire


// MARK: - Modify DataRequest
public extension API {
    
    /// modify base url
    func base(_ base: @escaping @autoclosure Compute<Swift.String>) -> Self {
        self._modifier(DataRequestModifier.URL(base: base))
    }
    
    /// append path
    func appendPath(_ appendPath: @escaping @autoclosure Compute<Swift.String>) -> Self {
        self._modifier(DataRequestModifier.URL(appendPath: appendPath))
    }
    
    /// mocking with full url
    func mock(_ mock: @escaping @autoclosure Compute<Swift.String>) -> Self {
        self._modifier(DataRequestModifier.URL(mock: mock))
    }
    
    /// set additional header
    func header(name: Swift.String, value: Swift.String) -> Self {
        self._modifier(DataRequestModifier.HTTPHeader(name: name, value: value))
    }
    
    /// set additional headers
    func headers(_ dictionary: [Swift.String: Swift.String]) -> Self {
        self._modifier(DataRequestModifier.HTTPHeaders(dictionary))
    }
    
    /// modify encoding
    func encoding(_ encoding: Alamofire.ParameterEncoding) -> Self
    where Self.Parameters == [Swift.String: Any] {
        self._modifier(DataRequestModifier.Encoding(encoding))
    }
    
    /// modify encoder
    func encoder(_ encoder: Alamofire.ParameterEncoder) -> Self
    where Self.Parameters: Swift.Encodable {
        self._modifier(DataRequestModifier.Encoder(encoder))
    }
    
    /// modify URLRequest.timeoutInterval
    func timeoutInterval(_ timeoutInterval: TimeInterval) -> Self {
        self._modifier(DataRequestModifier.TimeoutInterval(timeoutInterval))
    }
    
    /// modify authenticate
    func authenticate(username: Swift.String,
                      password: Swift.String,
                      persistence: Foundation.URLCredential.Persistence = .forSession) -> Self {
        self._modifier(DataRequestModifier.Authenticate(username: username,
                                                        password: password,
                                                        persistence: persistence))
    }
    
    /// modify authenticate
    func authenticate(credential: Foundation.URLCredential) -> Self {
        self._modifier(DataRequestModifier.Authenticate(credential: credential))
    }
    
    /// modify redirect
    func redirect(using handler: Alamofire.RedirectHandler) -> Self {
        self._modifier(DataRequestModifier.Redirect(using: handler))
    }
}


// MARK: - Modify DataResponse
public extension API {
    
    /// validate statusCode
    func validate(statusCode acceptableStatusCodes: Swift.Range<Swift.Int>) -> Self {
        self._modifier(DataResponseModifier.Validation(statusCode: acceptableStatusCodes))
    }
    
    /// validate contentType
    func validate(contentType acceptableContentTypes: @escaping @autoclosure Compute<[Swift.String]>) -> Self {
        self._modifier(DataResponseModifier.Validation(contentType: acceptableContentTypes))
    }
    
    /// validates the request, using the specified closure.
    /// - Parameters:
    ///   - identifier: Same identifier will be override.
    ///   - validation: Custom validation
    func validate(identifier: Swift.String, validation: @escaping Alamofire.DataRequest.Validation) -> Self {
        self._modifier(DataResponseModifier.Validation(identifier: identifier, validation: validation))
    }
    
    /// modify cache response
    func cacheResponse(using handler: Alamofire.CachedResponseHandler) -> Self {
        self._modifier(DataResponseModifier.CacheResponse(using: handler))
    }
    
    /// The queue on which the completion handler is dispatched
    func queue(_ queue: DispatchQueue) -> Self {
        self._modifier(DataResponseModifier.Queue(queue))
    }
    
    /// serialize data
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor,
                   emptyResponseCodes: Swift.Set<Swift.Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods) -> Self
    where Returns == Foundation.Data {
        let serializer = Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods)
        return self._modifier(DataResponseModifier.SerializeData(serializer))
    }
    
    /// serialize string
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.StringResponseSerializer.defaultDataPreprocessor,
                   encoding: Swift.String.Encoding? = nil,
                   emptyResponseCodes: Swift.Set<Swift.Int> = Alamofire.StringResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod> = Alamofire.StringResponseSerializer.defaultEmptyRequestMethods) -> Self
    where Returns == Swift.String {
        let serializer = Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                            encoding: encoding,
                                                            emptyResponseCodes: emptyResponseCodes,
                                                            emptyRequestMethods: emptyRequestMethods)
        return self._modifier(DataResponseModifier.SerializeString(serializer))
    }
    
    /// serialize json
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor,
                   emptyResponseCodes: Swift.Set<Swift.Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods,
                   options: Foundation.JSONSerialization.ReadingOptions = .allowFragments) -> Self
    where Returns == [Swift.String: Any] {
        let serializer = Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods,
                                                          options: options)
        return self._modifier(DataResponseModifier.SerializeJSON(serializer))
    }
    
    /// serialize decodable
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DecodableResponseSerializer<Returns>.defaultDataPreprocessor,
                   decoder: Alamofire.DataDecoder = Foundation.JSONDecoder(),
                   emptyResponseCodes: Swift.Set<Swift.Int> = Alamofire.DecodableResponseSerializer<Returns>.defaultEmptyResponseCodes,
                   emptyRequestMethods: Swift.Set<Alamofire.HTTPMethod> = Alamofire.DecodableResponseSerializer<Returns>.defaultEmptyRequestMethods) -> Self
    where Returns: Swift.Decodable {
        let serializer = Alamofire.DecodableResponseSerializer<Returns>(dataPreprocessor: dataPreprocessor,
                                                                  decoder: decoder,
                                                                  emptyResponseCodes: emptyResponseCodes,
                                                                  emptyRequestMethods: emptyRequestMethods)
        return self._modifier(DataResponseModifier.SerializeDecodable<Returns>(serializer))
    }
}
