//
//  APIModifier.swift
//


/// APIModifier
public protocol APIModifier {
    
    func apply(to context: ModifiedContext)
}


/// ModifiedContext
public typealias ModifiedContext = Settings.API._Modify
