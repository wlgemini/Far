//
//  Far.swift
//

import Foundation
import Alamofire


/// namespace for `Far`
public enum Far {}


// MARK: Session
extension Far {
    
    public static var session = Setter.Copy.Nonnil<Alamofire.Session>(Alamofire.Session(rootQueue: DispatchQueue(label: "Far.Session.rootQueue")))
    
    static let _sessionFinalized: Alamofire.Session = {
        return Self.session.value
    }()
}

// MARK: API Default
extension Far {
    
    public static let api = Store.API.Default()
}
