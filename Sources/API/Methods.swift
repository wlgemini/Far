//
//  Methods.swift
//

import Alamofire


// MARK: - Methods
public struct GET<Parameters, Returns>: API {
    
    public var modifier: some APIModifier {
        _APIModifier(self._method, self._initialURL)
    }
    
    public init(_ path: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .get)
        self._initialURL = DataRequestModifier.InitialURL(path: path)
    }
    
    public init(url: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .get)
        self._initialURL = DataRequestModifier.InitialURL(url: url)
    }
    
    let _method: DataRequestModifier.HTTPMethod
    let _initialURL: DataRequestModifier.InitialURL
}


public struct POST<Parameters, Returns>: API {
    
    public var modifier: some APIModifier {
        _APIModifier(self._method, self._initialURL)
    }
    
    public init(_ path: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .post)
        self._initialURL = DataRequestModifier.InitialURL(path: path)
    }
    
    public init(url: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .post)
        self._initialURL = DataRequestModifier.InitialURL(url: url)
    }
    
    let _method: DataRequestModifier.HTTPMethod
    let _initialURL: DataRequestModifier.InitialURL
}


public struct PUT<Parameters, Returns>: API {
    
    public var modifier: some APIModifier {
        _APIModifier(self._method, self._initialURL)
    }
    
    public init(_ path: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .put)
        self._initialURL = DataRequestModifier.InitialURL(path: path)
    }
    
    public init(url: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .put)
        self._initialURL = DataRequestModifier.InitialURL(url: url)
    }
    
    let _method: DataRequestModifier.HTTPMethod
    let _initialURL: DataRequestModifier.InitialURL
}


public struct PATCH<Parameters, Returns>: API {
    
    public var modifier: some APIModifier {
        _APIModifier(self._method, self._initialURL)
    }
    
    public init(_ path: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .patch)
        self._initialURL = DataRequestModifier.InitialURL(path: path)
    }
    
    public init(url: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .patch)
        self._initialURL = DataRequestModifier.InitialURL(url: url)
    }
    
    let _method: DataRequestModifier.HTTPMethod
    let _initialURL: DataRequestModifier.InitialURL
}


public struct DELETE<Parameters, Returns>: API {
    
    public var modifier: some APIModifier {
        _APIModifier(self._method, self._initialURL)
    }
    
    public init(_ path: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .delete)
        self._initialURL = DataRequestModifier.InitialURL(path: path)
    }
    
    public init(url: @escaping @autoclosure Compute<Swift.String>) {
        self._method = DataRequestModifier.HTTPMethod(method: .delete)
        self._initialURL = DataRequestModifier.InitialURL(url: url)
    }
    
    let _method: DataRequestModifier.HTTPMethod
    let _initialURL: DataRequestModifier.InitialURL
}
