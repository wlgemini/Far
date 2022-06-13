//
//  _ModifiedAPI.swift
//


/// _ModifiedAPI
struct _ModifiedAPI<Parameters, Returns, Modifier: APIModifier, NewModifier: APIModifier>: API, APIModifier {
    
    typealias Parameters = Parameters
    
    typealias Returns = Returns
    
    typealias Modifier = _APIModifier<Modifier, NewModifier>

    let modifier: _APIModifier<Modifier, NewModifier>

    init(modifier: Modifier, newModifier: NewModifier) {
        self.modifier = _APIModifier(modifier: modifier, newModifier: newModifier)
    }

    func apply(to context: ModifiedContext) {
        self.modifier.apply(to: context)
    }
}
