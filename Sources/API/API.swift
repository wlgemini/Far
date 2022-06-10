//
//  API.swift
//


// MARK: - API
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
    
    /// modify API
    public func modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> some API<Parameters, Returns> {
        _ModifiedAPI<Parameters, Returns, Modifier, NewModifier>(modifier: self.modifier, newModifier: newModifier)
    }
}
