//
//  Method.swift
//

import Alamofire


// MARK: - Method
public protocol Method: API {
    
    init(_ path: @escaping @autoclosure Compute<String>)
    
    init(url: @escaping @autoclosure Compute<String>)
}


// MARK: - Methods
public struct GET<Parameters, Returns>: Method {
    
    public let modifier: AnyModifier
    
    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .get),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .get),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self.modifier = modifier
    }
}


public struct POST<Parameters, Returns>: Method {
    
    public let modifier: AnyModifier
    
    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .post),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .post),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self.modifier = modifier
    }
}


public struct PUT<Parameters, Returns>: Method {
    
    public let modifier: AnyModifier
    
    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .put),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .put),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self.modifier = modifier
    }
}


public struct PATCH<Parameters, Returns>: Method {
    
    public let modifier: AnyModifier
    
    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .patch),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .patch),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self.modifier = modifier
    }
}


public struct DELETE<Parameters, Returns>: Method {
    
    public let modifier: AnyModifier
    
    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .delete),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .delete),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self.modifier = modifier
    }
}
