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
    
    /// modify API, with an opaque return type
    public func modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> some API<Parameters, Returns> {
        self._modifier(newModifier)
    }
    
    /// modify API
    func _modifier<NewModifier: APIModifier>(_ newModifier: NewModifier) -> _ModifiedAPI<Parameters, Returns, _APIModifier<Modifier, NewModifier>> {
        _ModifiedAPI(_APIModifier(self.modifier, newModifier))
    }
}
