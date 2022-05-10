//
//  Store.swift
//

import Foundation
import Alamofire


/// namespace for `Store`
public enum Store {}


extension Store {
    
    static var isSessionFinalized: Bool = false
    
    static var session = Alamofire.Session(rootQueue: DispatchQueue(label: "Far.Session.rootQueue"))
}

extension Store.API {
    
    static let `default` = Store.API._Default()
}
