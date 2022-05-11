//
//  _Debug.swift
//  


/// _Debug
enum _Debug {
    
    static func execute(_ exe: @escaping () -> Void) {
        Swift.assert({
            exe()
            return true
        }())
    }
}
