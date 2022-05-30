//
//  _Log.swift
//  


/// _Log
enum _Log {
    
    static func trace(_ item: @escaping @autoclosure () -> Any, location: Location) {
        Swift.assert({
            let msg = Settings.Log.Message(location: location, item: item())
            Far._log.trace._value(msg)
            return true
        }())
    }
    
    static func warning(_ item: @escaping @autoclosure () -> Any, location: Location) {
        Swift.assert({
            let msg = Settings.Log.Message(location: location, item: item())
            Far._log.warning._value(msg)
            return true
        }())
    }
    
    static func error(_ item: @escaping @autoclosure () -> Any, location: Location) {
        Swift.assert({
            let msg = Settings.Log.Message(location: location, item: item())
            Far._log.error._value(msg)
            return true
        }())
    }
}

