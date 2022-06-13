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
struct _APIModifier<Modifier: APIModifier, NewModifier: APIModifier>: APIModifier {
    
    let modifier: Modifier
    
    let newModifier: NewModifier
    
    init(modifier: Modifier, newModifier: NewModifier) {
        self.modifier = modifier
        self.newModifier = newModifier
    }
    
    func apply(to context: ModifiedContext) {
        self.modifier.apply(to: context)
        self.newModifier.apply(to: context)
    }
}
