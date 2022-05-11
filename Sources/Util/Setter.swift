//
//  Setter.swift
//


/// for Getter type
public protocol Gettable {
    
    associatedtype G
    
    var value: G { get }
}


/// for Setter type
public protocol Settable: Gettable {
    
    associatedtype S
    
    mutating func callAsFunction(_ value: S, file: String, line: UInt)
}


/// Setter
public enum Setter {
    
    /// for copy value
    public enum Copy { }
    
    /// for compute value
    public enum Compute { }
}


extension Setter.Copy {
    
    /// Nonnil
    public struct Nonnil<T>: Settable, _Locatable {
        
        public typealias G = T
        
        public typealias S = T
        
        public var value: T {
            self._value
        }
        
        public mutating func callAsFunction(_ value: T, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self._location = _Location(file, line)
        }
        
        init(_ value: T) {
            self._value = value
            self._location = .nowhere
        }
        
        var _value: T
        var _location: _Location
    }
    
    
    /// Nillable
    public struct Nillable<T>: Settable, _Locatable {
        
        public typealias G = T?
        
        public typealias S = T?
        
        public var value: T? {
            self._value
        }
        
        public mutating func callAsFunction(_ value: T?, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self._location = _Location(file, line)
        }
        
        init() {
            self._value = nil
            self._location = .nowhere
        }
        
        var _value: T?
        var _location: _Location
    }
}


extension Setter.Compute {
    
    /// Nonnil
    public struct Nonnil<T>: Settable, _Locatable {
    
        public typealias G = T
        
        public typealias S = Compute<T>
        
        public var value: T {
            self._value()
        }
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T>, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self._location = _Location(file, line)
        }
        
        init(_ value: @escaping @autoclosure Compute<T>) {
            self._value = value
            self._location = .nowhere
        }
        
        var _value: Compute<T>
        var _location: _Location
    }
    
    
    /// Nillable
    public struct Nillable<T>: Settable, _Locatable {
        
        public typealias G = T?
        
        public typealias S = Compute<T?>
        
        public var value: T? {
            self._value()
        }
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T?>, file: String = #fileID, line: UInt = #line) {
            self._value = value
            self._location = _Location(file, line)
        }
        
        init() {
            self._value = { nil }
            self._location = .nowhere
        }
        
        var _value: Compute<T?>
        var _location: _Location
    }
}
