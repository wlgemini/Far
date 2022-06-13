//
//  API.swift
//


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


extension API {
    
    /// modify API, return an opaque type
    public func modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> some API<Parameters, Returns> {
        _ModifiedAPI<Parameters, Returns, Modifier, NewModifier>(modifier: self.modifier, newModifier: newModifier)
    }
    
    /// modify API
    func _modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> _ModifiedAPI<Parameters, Returns, Modifier, NewModifier> {
        _ModifiedAPI<Parameters, Returns, Modifier, NewModifier>(modifier: self.modifier, newModifier: newModifier)
    }
}
