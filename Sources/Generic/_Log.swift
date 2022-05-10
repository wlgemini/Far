//
//  _Log.swift
//  


/// _Log
enum _Log {
    
    static func trace(_ item: @escaping @autoclosure () -> Any, location: _Location) {
        Swift.assert({
            let str = "🟢 \(location): \(item())"
            print(str)
            return true
        }())
    }
    
    static func warning(_ item: @escaping @autoclosure () -> Any, location: _Location) {
        Swift.assert({
            let str = "🟡 \(location): \(item())"
            print(str)
            return true
        }())
    }
    
    static func error(_ item: @escaping @autoclosure () -> Any, location: _Location) {
        Swift.assert({
            let str = "🔴 \(location): \(item())"
            print(str)
            return true
        }())
    }
}

