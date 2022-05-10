//
//  Far.swift
//

import Foundation
import Alamofire


/// namespace for `Far`
public enum Far {}


// MARK: Session
extension Far {
    
    public func session(_ value: Alamofire.Session, file: String = #fileID, line: UInt = #line) {
        guard Store.isSessionFinalized == false else {
            _Log.warning("can not mutating finalized session", location: _Location(file, line))
            return
        }
        
        Store.session = value
    }
}

// MARK: API Default DataRequest
extension Far {
    
    public static func base(_ value: @escaping @autoclosure Compute<String>, file: String = #fileID, line: UInt = #line) -> Self.Type {
        Store.API.default.dataRequest.base = value
        return self
    }
    
    public static func headers(_ value: @escaping @autoclosure Compute<Alamofire.HTTPHeaders>, file: String = #fileID, line: UInt = #line) -> Self.Type {
        Store.API.default.dataRequest.headers = value
        return self
    }
    
    
}
