//
//  _Lazy.swift
//  


enum _Lazy<Value> {

    case hasValue(value: Value)
    
    case unset(initializer: Compute<Value>)
    
    var hasValue: Value? {
        switch self {
        case .hasValue(let value):
            return value
            
        case .unset:
            return nil
        }
    }
    
    mutating func finalize() -> Value {
        switch self {
        case .hasValue(let value):
            return value
            
        case .unset(let initializer):
            let value = initializer()
            self = .hasValue(value: value)
            return value
        }
    }
}
