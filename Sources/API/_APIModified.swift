//
//  _APIModified.swift
//  


/// _APIModified
struct _APIModified<P, R, M: APIModifier>: API, APIModifier {
    
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
