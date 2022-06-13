//
//  _ModifiedAPI.swift
//


/// _ModifiedAPI
struct _ModifiedAPI<P, R, M: APIModifier>: API, APIModifier {
    
    typealias Parameters = P
    
    typealias Returns = R
    
    typealias Modifier = M

    let modifier: M

    init(_ modifier: M) {
        self.modifier = modifier
    }

    func apply(to context: ModifiedContext) {
        self.modifier.apply(to: context)
    }
}
