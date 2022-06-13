//
//  APIModifier.swift
//


/// APIModifier
public protocol APIModifier {
    
    func apply(to context: ModifiedContext)
}


/// ModifiedContext
public typealias ModifiedContext = Settings.API._Modify


/// _APIModifier
struct _APIModifier<First: APIModifier, Second: APIModifier>: APIModifier {
    
    let first: First
    
    let second: Second
    
    init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
    
    func apply(to context: ModifiedContext) {
        self.first.apply(to: context)
        self.second.apply(to: context)
    }
}
