//
//  Settings.Log.swift
//


extension Settings {
    
    /// Log
    public final class Log {
        
        public var trace = Setter.Available.Nonnil<Message> { Swift.print("🟢 \($0.location): \($0.item)") }
        
        public var warning = Setter.Available.Nonnil<Message> { Swift.print("🟡 \($0.location): \($0.item)") }
        
        public var error = Setter.Available.Nonnil<Message> { Swift.print("🔴 \($0.location): \($0.item)") }
        
        init() {}
    }
}


extension Settings.Log {
    
    /// Message
    public struct Message {
        
        /// location in file
        public let location: Location
        
        /// item
        public let item: Any
    }
}
