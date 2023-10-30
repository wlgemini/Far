//
//  API.swift
//


/// APIModifier
public protocol APIModifier {
    
    func apply(to context: Settings.API.Modified)
}

/// API
public protocol API<Parameters, Returns> {
    
    /// Parameters
    associatedtype Parameters
    
    /// Returns
    associatedtype Returns
    
    /// Modifier
    associatedtype Modifier: APIModifier
    
    /// modifier
    var modifier: Modifier { get }
}

/// APIModifier2
public struct APIModifier2<First: APIModifier, Second: APIModifier>: APIModifier {
    
    public let first: First
    
    public let second: Second
    
    public init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
    
    public func apply(to context: Settings.API.Modified) {
        self.first.apply(to: context)
        self.second.apply(to: context)
    }
}

/// AnyAPIModifier2
public struct AnyAPIModifier2: APIModifier {
    
    public let first: any APIModifier
    
    public let second: any APIModifier
    
    public init<First: APIModifier, Second: APIModifier>(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
    
    public func apply(to context: Settings.API.Modified) {
        self.first.apply(to: context)
        self.second.apply(to: context)
    }
}

/// APIModified
public struct APIModified<P, R, M: APIModifier>: API, APIModifier {
    
    public typealias Parameters = P
    
    public typealias Returns = R
    
    public typealias Modifier = M

    public let modifier: M

    public init(_ modifier: M) {
        self.modifier = modifier
    }

    public func apply(to context: Settings.API.Modified) {
        self.modifier.apply(to: context)
    }
}

extension API {

    /// add API modifier
    func _modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> APIModified<Parameters, Returns, APIModifier2<Modifier, NewModifier>> {
        APIModified(APIModifier2(self.modifier, newModifier))
    }
    
    /// add API type-erased-modifier
    func _any_modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> APIModified<Parameters, Returns, AnyAPIModifier2> {
        APIModified(AnyAPIModifier2(self.modifier, newModifier))
    }
}
