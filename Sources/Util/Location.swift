//
//  Location.swift
//


/// Location
public struct Location: Swift.CustomStringConvertible {
    
    /// a location from nowhere
    public static let nowhere = Location(nil, nil)
    
    /// file: #fileID
    public let file: Swift.String?
    
    /// line: #line
    public let line: Swift.UInt?
    
    /// init
    /// - Parameters:
    ///   - file: #fileID
    ///   - line: #line
    public init(_ file: Swift.String?, _ line: Swift.UInt?) {
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
                let fileName = file.split(separator: ".").first ?? ""
                return "@\(Swift.String(fileName))#\(line)"
                
            case (.some(let file), .none):
                let fileName = file.split(separator: ".").first ?? ""
                return "@\(Swift.String(fileName))"
                
            case (.none, .some(let line)):
                return "#\(line)"
                
            case (.none, .none):
                return ""
        }
    }
}
