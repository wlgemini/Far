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
                _Log.warning("Can not set new session, cause session has finalized", location: Location.nowhere)
                return
            } else {
                _Debug.execute {
                    if let newSession = newValue {
                        _Log.trace("Set new session: \(newSession)", location: Location.nowhere)
                    } else {
                        _Log.trace("Set new session: nil", location: Location.nowhere)
                    }                    
                }
                Self._session = newValue
            }
        }
    }
    
    public static var isSessionFinalized: Swift.Bool {
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


// MARK: Log
extension Far {
    
    public static var log: Settings.Log {
        Self._log
    }
}


// MARK: - Private
extension Far {
    
    static var _isSessionFinalized: Swift.Bool = false
    
    static var _session: Alamofire.Session?
    
    static let _sessionFinalized: Alamofire.Session = {
        _Log.trace("Session finalized", location: Location.nowhere)
        Self._isSessionFinalized = true
        return Self._session ?? Alamofire.Session()
    }()
}


extension Far {
    
    static let _api = Settings.API.Default()
}


extension Far {
    
    static let _log = Settings.Log()
}
