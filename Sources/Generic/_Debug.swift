//
//  _Debug.swift
//  


/// _Debug
enum _Debug {
    
    static func only(_ execute: @escaping () -> Void) {
        Swift.assert({
            execute()
            return true
        }())
    }
}
