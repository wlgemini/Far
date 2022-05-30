//
//  _Location.swift
//


/// Locatable
protocol _Locatable {
    
    /// file & line
    var _location: _Location { get }
}


/// Location
struct _Location: Swift.CustomStringConvertible {
    
    /// a location from nowhere
    static let nowhere = _Location(nil, nil)
    
    /// file: #fileID
    let file: Swift.String?
    
    /// line: #line
    let line: Swift.UInt?
    
    /// init
    /// - Parameters:
    ///   - file: #fileID
    ///   - line: #line
    init(_ file: Swift.String?, _ line: Swift.UInt?) {
        self.file = file
        self.line = line
    }
    
    /// description
    ///
    ///     "@Module/ViewController#23"
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
