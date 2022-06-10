//
//  APIModifier.swift
//


/// _ModifiedAPI
struct _ModifiedAPI<Parameters, Returns, Modifier: APIModifier, NewModifier: APIModifier>: API, APIModifier {
    
    typealias Parameters = Parameters
    
    typealias Returns = Returns
    
    typealias Modifier = Modifier

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
