//
//  Location.swift
//


/// Location
public struct Location: Swift.CustomStringConvertible {
    
    /// a location from nowhere
    public static let nowhere = Location(nil, nil)
    
    /// file: #fileID
    public let file: Swift.StaticString?
    
    /// line: #line
    public let line: Swift.UInt?
    
    /// init
    /// - Parameters:
    ///   - file: #fileID
    ///   - line: #line
    public init(_ file: Swift.StaticString?, _ line: Swift.UInt?) {
        self.file = file
        self.line = line
    }
    
    /// description
    ///
    ///     "@MyModule/MyClass#23"
    ///
    public var description: Swift.String {
        switch (self.file, self.line) {
            case (.some(let file), .some(let line)):
                return "@\(file)#\(line)"
                
            case (.some(let file), .none):
                return "@\(file)"
                
            case (.none, .some(let line)):
                return "#\(line)"
                
            case (.none, .none):
                return ""
        }
    }
}
