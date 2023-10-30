//
//  Setter.swift
//


/// for locatable setter type
public protocol LocatableSetter {
    
    associatedtype S
    
    mutating func callAsFunction(_ value: S, file: Swift.StaticString, line: Swift.UInt)
}


/// Setter
public enum Setter {
    
    /// for copy value
    public enum Copy {}
    
    /// for compute value
    public enum Compute {}
    
    /// for available value
    public enum Available {}
}


extension Setter.Copy {
    
    /// Nonnil
    public struct Nonnil<T>: LocatableSetter {
        
        public typealias S = T
        
        public mutating func callAsFunction(_ value: T, file: Swift.StaticString = #fileID, line: Swift.UInt = #line) {
            self._value = value
            self._location = Location(file, line)
        }
        
        init(_ value: T) {
            self._value = value
            self._location = .nowhere
        }
        
        var _value: T
        var _location: Location
    }
    
    
    /// Nillable
    public struct Nillable<T>: LocatableSetter {

        public typealias S = T?
        
        public mutating func callAsFunction(_ value: T?, file: Swift.StaticString = #fileID, line: Swift.UInt = #line) {
            self._value = value
            self._location = Location(file, line)
        }
        
        init() {
            self._value = nil
            self._location = .nowhere
        }
        
        var _value: T?
        var _location: Location
    }
}


extension Setter.Compute {
    
    /// Nonnil
    public struct Nonnil<T>: LocatableSetter {

        public typealias S = Compute<T>

        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T>, file: Swift.StaticString = #fileID, line: Swift.UInt = #line) {
            self._value = value
            self._location = Location(file, line)
        }
        
        init(_ value: @escaping @autoclosure Compute<T>) {
            self._value = value
            self._location = .nowhere
        }
        
        var _value: Compute<T>
        var _location: Location
    }
    
    
    /// Nillable
    public struct Nillable<T>: LocatableSetter {

        public typealias S = Compute<T?>
        
        public mutating func callAsFunction(_ value: @escaping @autoclosure Compute<T?>, file: Swift.StaticString = #fileID, line: Swift.UInt = #line) {
            self._value = value
            self._location = Location(file, line)
        }
        
        init() {
            self._value = { nil }
            self._location = .nowhere
        }
        
        var _value: Compute<T?>
        var _location: Location
    }
}


extension Setter.Available {
    
    /// Nonnil
    public struct Nonnil<T>: LocatableSetter {

        public typealias S = Available<T>

        public mutating func callAsFunction(_ value: @escaping Available<T>, file: Swift.StaticString = #fileID, line: Swift.UInt = #line) {
            self._value = value
            self._location = Location(file, line)
        }
        
        init(_ value: @escaping Available<T>) {
            self._value = value
            self._location = .nowhere
        }
        
        var _value: Available<T>
        var _location: Location
    }
    
    
    /// Nillable
    public struct Nillable<T>: LocatableSetter {

        public typealias S = Available<T?>

        public mutating func callAsFunction(_ value: @escaping Available<T?>, file: Swift.StaticString = #fileID, line: Swift.UInt = #line) {
            self._value = value
            self._location = Location(file, line)
        }
        
        init() {
            self._value = { _ in }
            self._location = .nowhere
        }
        
        var _value: Available<T?>
        var _location: Location
    }
}
