//
//  API+DataRequest.swift
//

import Foundation
import Alamofire


// MARK: - Request
public extension API {
    
    /// Parameters == [String: Any], Returns == Data
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns == Foundation.Data {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == [String: Any], Returns == String
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns == Swift.String {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == [String: Any], Returns == Any
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns == Any {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == [String: Any], Returns: Decodable
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters == [Swift.String: Any], Returns: Swift.Decodable {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == Encodable, Returns == Data
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns == Foundation.Data {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == Encodable, Returns == String
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns == Swift.String {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == Encodable, Returns == Any
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns == Any {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
    
    /// Parameters == Encodable, Returns: Decodable
    func request(_ parameters: Parameters?,
                 completion: @escaping (Alamofire.DataResponse<Returns, AFError>) -> Swift.Void,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line)
    where Parameters: Swift.Encodable, Returns: Swift.Decodable {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
    }
}

// MARK: - Async Request
public extension API {
    
    /// Parameters == [String: Any], Returns == Data
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters == [Swift.String: Any], Returns == Foundation.Data {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == [String: Any], Returns == String
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters == [Swift.String: Any], Returns == Swift.String {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == [String: Any], Returns == Any
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters == [Swift.String: Any], Returns == Any {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == [String: Any], Returns: Decodable
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters == [Swift.String: Any], Returns: Swift.Decodable {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == Encodable, Returns == Data
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters: Swift.Encodable, Returns == Foundation.Data {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == Encodable, Returns == String
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters: Swift.Encodable, Returns == Swift.String {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == Encodable, Returns == Any
    @available(*, deprecated, message: "JSONResponseSerializer deprecated and will be removed in Alamofire 6. Use DecodableResponseSerializer instead.")
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters: Swift.Encodable, Returns == Any {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
    
    /// Parameters == Encodable, Returns: Decodable
    func request(_ parameters: Parameters?,
                 file: Swift.StaticString = #fileID,
                 line: Swift.UInt = #line) async -> Alamofire.DataResponse<Returns, AFError>
    where Parameters: Swift.Encodable, Returns: Swift.Decodable {
        let context = self._context(file: file, line: line)
        let request = self._request(parameters: parameters, context: context)
        self._requestAccessing(request: request, context: context)
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        return await self._response(request: request, context: context)
    }
}
