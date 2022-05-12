//
//  Far.swift
//

import Foundation
import Alamofire


/// namespace for `Far`
public enum Far {}


// MARK: Session
extension Far {
    
    public static var session: Alamofire.Session? {
        get {
            if Self._isSessionFinalized {
                return Self._sessionFinalized
            } else {
                return Self._session
            }
        }
        
        set {
            if Self._isSessionFinalized {
                return
            } else {
                Self._session = newValue
            }
        }
    }
    
    public static var isSessionFinalized: Bool {
        Self._isSessionFinalized
    }
    
    @discardableResult
    public static func sessionFinalize() -> Alamofire.Session {
        Self._sessionFinalized
    }
}


// MARK: API Default
extension Far {
    
    public static var api: Settings.API.Default {
        Self._api
    }
}


// MARK: - Private
extension Far {
    
    static var _isSessionFinalized: Bool = false
    
    static var _session: Alamofire.Session?
    
    static let _sessionFinalized: Alamofire.Session = {
        Self._isSessionFinalized = true
        return Self._session ?? Alamofire.Session()
    }()
}


extension Far {
    
    static let _api = Settings.API.Default()
}
