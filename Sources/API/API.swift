//
//  API.swift
//


// MARK: - API
public protocol API {
    
    /// Parameters
    associatedtype Parameters
    
    /// Returns
    associatedtype Returns
    
    /// modifier
    var modifier: AnyModifier { get }
    
    /// init
    init(modifier: AnyModifier)
}


extension API {
    
    func _modifier<M>(_ m: M) -> Self
    where M: Modifier {
        Self(modifier: AnyModifier(self.modifier, m))
    }
}
