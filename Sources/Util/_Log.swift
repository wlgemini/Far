//
//  _Log.swift
//  


/// _Log
enum _Log {
    
    static func trace(_ item: @escaping @autoclosure () -> Any, location: _Location) {
        Swift.assert({
            let log = "🟢 \(location): \(item())"
            Far._log.trace._value(log)
            return true
        }())
    }
    
    static func warning(_ item: @escaping @autoclosure () -> Any, location: _Location) {
        Swift.assert({
            let log = "🟡 \(location): \(item())"
            Far._log.warning._value(log)
            return true
        }())
    }
    
    static func error(_ item: @escaping @autoclosure () -> Any, location: _Location) {
        Swift.assert({
            let log = "🔴 \(location): \(item())"
            Far._log.error._value(log)
            return true
        }())
    }
}

