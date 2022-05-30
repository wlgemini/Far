//
//  DataRequestModifier.swift
//

import Foundation
import Alamofire


/// DataRequestModifier
public enum DataRequestModifier {

    // MARK: - Method/URL
    /// HTTPMethod
    public struct HTTPMethod: Modifier {
        
        public init(method: Alamofire.HTTPMethod) {
            self.method = method
        }
        
        public func modify(context: ModifyContext) {
            if context.dataRequest.api.method == nil {
                context.dataRequest.api.method = self.method
            } else {
                _Log.error("Can not modify `HTTPMethod`", location: context.requestLocation)
            }
        }
        
        let method: Alamofire.HTTPMethod
    }


    /// InitialURL
    ///
    /// some type examples:
    ///
    ///     http://www.example.com/some/path/to/file
    ///     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
    ///                                         full
    ///
    ///     http://www.example.com/some/path/to/file
    ///                           ~~~~~~~~~~~~~~~~~^
    ///                                         path
    ///
    public struct InitialURL: Modifier {
        
        public init(url: @escaping Compute<Swift.String>) {
            self._type = .full(url)
        }
        
        public init(path: @escaping Compute<Swift.String>) {
            self._type = .path(path)
        }
        
        public func modify(context: ModifyContext) {
            if context.dataRequest.api.initialURL == nil {
                context.dataRequest.api.initialURL = self._type
            } else {
                _Log.error("Can not modify `InitialURL`", location: context.requestLocation)
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case full(Compute<Swift.String>)
            
            case path(Compute<Swift.String>)
        }
    }
    
    
    /// URL
    ///
    /// some type examples:
    ///
    ///     http://www.example.com/some/path/to/file
    ///     ~~~~~~~~~~~~~~~~~~~~~^
    ///                       base
    ///
    ///     http://www.example.com/some/path/to/file/appendPath
    ///                                             ~~~~~~~~~~^
    ///                                              appendPath
    ///
    ///     http://www.mock.com/some/path/to/file/appendPath
    ///     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
    ///                                                 mock
    ///
    public struct URL: Modifier {
        
        public init(base: @escaping Compute<Swift.String>) {
            self._type = .base(base)
        }
        
        public init(appendPath: @escaping Compute<Swift.String>) {
            self._type = .appendPath(appendPath)
        }
        
        public init(mock: @escaping Compute<Swift.String>) {
            self._type = .mock(mock)
        }
        
        public func modify(context: ModifyContext) {
            switch self._type {
            case .base(let base):
                context.dataRequest.api.base = base
                
            case .appendPath(let appendPath):
                context.dataRequest.api.appendPaths.append(appendPath)
                
            case .mock(let mock):
                context.dataRequest.api.mock = mock
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case base(Compute<Swift.String>)
            
            case appendPath(Compute<Swift.String>)
            
            case mock(Compute<Swift.String>)
        }
    }

    // MARK: - HTTPHeader
    /// Header
    public struct HTTPHeader: Modifier {
        
        public init(name: Swift.String, value: Swift.String) {
            self._header = Alamofire.HTTPHeader(name: name, value: value)
        }
        
        public func modify(context: ModifyContext) {
            context.dataRequest.headers.add(self._header)
        }
        
        let _header: Alamofire.HTTPHeader
    }
    
    
    /// Headers
    public struct HTTPHeaders: Modifier {
        
        public init(_ dictionary: [Swift.String: Swift.String]) {
            self._headers = Alamofire.HTTPHeaders(dictionary)
        }
        
        public func modify(context: ModifyContext) {
            for h in self._headers {
                context.dataRequest.headers.add(h)
            }
        }
        
        let _headers: Alamofire.HTTPHeaders
    }
    
    
    // MARK: - Encoder/Encoding
    /// Encoder
    public struct Encoder: Modifier {
        
        public init(_ encoder: Alamofire.ParameterEncoder) {
            self._encoder = encoder
        }
        
        public func modify(context: ModifyContext) {
            context.dataRequest.encoder = self._encoder
        }
        
        let _encoder: Alamofire.ParameterEncoder
    }
    
    
    /// Encoding
    public struct Encoding: Modifier {
        
        public init(_ encoding: Alamofire.ParameterEncoding) {
            self._encoding = encoding
        }
        
        public func modify(context: ModifyContext) {
            context.dataRequest.encoding = self._encoding
        }
        
        let _encoding: Alamofire.ParameterEncoding
    }
    
    
    // MARK: - Modify URLRequest
    /// TimeoutInterval
    public struct TimeoutInterval: Modifier {
        
        public init(_ timeInterval: TimeInterval) {
            self._timeInterval = timeInterval
        }
        
        public func modify(context: ModifyContext) {
            context.dataRequest.urlRequestModifiers.append { [timeInterval = self._timeInterval] urlRequest in
                urlRequest.timeoutInterval = timeInterval
            }
        }
        
        let _timeInterval: Foundation.TimeInterval
    }
    
    
    // MARK: - Authenticate
    /// Authenticate
    public struct Authenticate: Modifier {
        
        public init(username: Swift.String, password: Swift.String, persistence: Foundation.URLCredential.Persistence) {
            self._credential = Foundation.URLCredential(user: username, password: password, persistence: persistence)
        }
        
        public init(credential: Foundation.URLCredential) {
            self._credential = credential
        }
        
        public func modify(context: ModifyContext) {
            context.dataRequest.authenticate = self._credential
        }
        
        let _credential: Foundation.URLCredential
    }
    
    
    // MARK: - Redirect
    /// Redirect
    public struct Redirect: Modifier {
        
        public init(using handler: Alamofire.RedirectHandler) {
            self._handler = handler
        }
        
        public func modify(context: ModifyContext) {
            context.dataRequest.redirectHandler = self._handler
        }
        
        let _handler: Alamofire.RedirectHandler
    }
}
