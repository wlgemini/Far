//
//  DataResponseModifier.swift
//  

import Foundation
import Alamofire


/// DataResponseModifier
public enum DataResponseModifier {
    
    // MARK: - Validation
    /// Validation
    public struct Validation: Modifier {
        
        public init(statusCode acceptableStatusCodes: Range<Int>) {
            self._type = .statusCode(acceptableStatusCodes)
        }
        
        public init(contentType acceptableContentTypes: @escaping Compute<[String]>) {
            self._type = .contentType(acceptableContentTypes)
        }
        
        public init(identifier: String, validation: @escaping Alamofire.DataRequest.Validation) {
            self._type = .custom(identifier, validation)
        }
        
        public func modify(context: ModifyContext) {
            switch self._type {
                case .statusCode(let acceptableStatusCodes):
                    context.dataResponse.acceptableStatusCodes = acceptableStatusCodes
                    
                case .contentType(let acceptableContentTypes):
                    context.dataResponse.acceptableContentTypes = acceptableContentTypes
                    
                case .custom(let identifier, let validation):
                    context.dataResponse.validations[identifier] = validation
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case statusCode(Range<Int>)
            
            case contentType(Compute<[String]>)
            
            case custom(String, Alamofire.DataRequest.Validation)
        }
    }
    
    
    // MARK: - CacheResponse
    /// CacheResponse
    public struct CacheResponse: Modifier {
        
        public init(using handler: Alamofire.CachedResponseHandler) {
            self._handler = handler
        }
        
        public func modify(context: ModifyContext) {
            context.dataResponse.cachedResponseHandler = self._handler
        }
        
        let _handler: Alamofire.CachedResponseHandler
    }
    
    
    // MARK: - Queue
    public struct Queue: Modifier {
        
        public init(_ queue: DispatchQueue) {
            self._queue = queue
        }
        
        public func modify(context: ModifyContext) {
            context.dataResponse.queue = self._queue
        }
        
        let _queue: DispatchQueue
    }

    
    // MARK: - Serializer
    /// SerializeData
    public struct SerializeData: Modifier {
        
        public init(_ serializer: Alamofire.DataResponseSerializer) {
            self._serializer = serializer
        }
        
        public func modify(context: ModifyContext) {
            context.dataResponse.serializeData.dataPreprocessor._value = self._serializer.dataPreprocessor
            context.dataResponse.serializeData.emptyResponseCodes._value = self._serializer.emptyResponseCodes
            context.dataResponse.serializeData.emptyRequestMethods._value = self._serializer.emptyRequestMethods
        }
        
        let _serializer: Alamofire.DataResponseSerializer
    }
    
    /// SerializeString
    public struct SerializeString: Modifier {
        
        public init(_ serializer: Alamofire.StringResponseSerializer) {
            self._serializer = serializer
        }
        
        public func modify(context: ModifyContext) {
            context.dataResponse.serializeString.dataPreprocessor._value = self._serializer.dataPreprocessor
            context.dataResponse.serializeString.encoding._value = self._serializer.encoding
            context.dataResponse.serializeString.emptyResponseCodes._value = self._serializer.emptyResponseCodes
            context.dataResponse.serializeString.emptyRequestMethods._value = self._serializer.emptyRequestMethods
        }
        
        let _serializer: Alamofire.StringResponseSerializer
    }
    
    /// SerializeJSON
    public struct SerializeJSON: Modifier {
        
        public init(_ serializer: Alamofire.JSONResponseSerializer) {
            self._serializer = serializer
        }
        
        public func modify(context: ModifyContext) {
            context.dataResponse.serializeJSON.dataPreprocessor._value = self._serializer.dataPreprocessor
            context.dataResponse.serializeJSON.emptyResponseCodes._value = self._serializer.emptyResponseCodes
            context.dataResponse.serializeJSON.emptyRequestMethods._value = self._serializer.emptyRequestMethods
            context.dataResponse.serializeJSON.options._value = self._serializer.options
        }
        
        let _serializer: Alamofire.JSONResponseSerializer
    }
    
    /// SerializeDecodable
    public struct SerializeDecodable<T>: Modifier
    where T: Decodable {
        
        public init(_ serializer: Alamofire.DecodableResponseSerializer<T>) {
            self._serializer = serializer
        }
        
        public func modify(context: ModifyContext) {
            context.dataResponse.serializeDecodable.dataPreprocessor._value = self._serializer.dataPreprocessor
            context.dataResponse.serializeDecodable.decoder._value = self._serializer.decoder
            context.dataResponse.serializeDecodable.emptyResponseCodes._value = self._serializer.emptyResponseCodes
            context.dataResponse.serializeDecodable.emptyRequestMethods._value = self._serializer.emptyRequestMethods
        }
        
        let _serializer: Alamofire.DecodableResponseSerializer<T>
    }
}
