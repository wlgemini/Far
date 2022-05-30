//
//  Settings.Log.swift
//


extension Settings {
    
    /// Log
    public final class Log {
        
        public var trace = Setter.Available.Nonnil<Swift.String> { Swift.print($0) }
        
        public var warning = Setter.Available.Nonnil<Swift.String> { Swift.print($0) }
        
        public var error = Setter.Available.Nonnil<Swift.String> { Swift.print($0) }
        
        init() {}
    }
}
