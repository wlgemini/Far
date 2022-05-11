//
//  _Location.swift
//


/// Locatable
protocol _Locatable {
    
    /// file & line
    var _location: _Location { get }
}


/// Location
struct _Location: CustomStringConvertible {
    
    /// a location from nowhere
    static let nowhere = _Location(nil, nil)
    
    /// file: #fileID
    let file: String?
    
    /// line: #line
    let line: UInt?
    
    /// init
    /// - Parameters:
    ///   - file: #fileID
    ///   - line: #line
    init(_ file: String?, _ line: UInt?) {
        self.file = file
        self.line = line
    }
    
    /// description
    ///
    ///     "@Module/ViewController#23"
    ///
    public var description: String {
        switch (self.file, self.line) {
        case (.some(let file), .some(let line)):
            let fileName = file.split(separator: ".").first ?? ""
            return "@\(String(fileName))#\(line)"
            
        case (.some(let file), .none):
            let fileName = file.split(separator: ".").first ?? ""
            return "@\(String(fileName))"
            
        case (.none, .some(let line)):
            return "#\(line)"
            
        case (.none, .none):
            return ""
        }
    }
}
