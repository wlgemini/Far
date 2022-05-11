//
//  Far.swift
//

import Foundation
import Alamofire


/// namespace for `Far`
public enum Far {}


// MARK: Session
extension Far {
    
    public static let session = Settings.Session()
}


// MARK: API Default
extension Far {
    
    public static var apiDefault: Settings.API.Default {
        Self._default
    }
}


// MARK: - Private
extension Far {
    
    static var _isSessionFinalized: Bool = false
    
    static let _session: Alamofire.Session = {
        Self._isSessionFinalized = true
        return Alamofire.Session(configuration: Self.session.configuration._value,
                                 delegate: Self.session.delegate._value,
                                 rootQueue: Self.session.rootQueue._value,
                                 startRequestsImmediately: Self.session.startRequestsImmediately._value,
                                 requestQueue: Self.session.requestQueue._value,
                                 serializationQueue: Self.session.serializationQueue._value,
                                 interceptor: Self.session.interceptor._value,
                                 serverTrustManager: Self.session.serverTrustManager._value,
                                 redirectHandler: Self.session.redirectHandler._value,
                                 cachedResponseHandler: Self.session.cachedResponseHandler._value,
                                 eventMonitors: Self.session.eventMonitors._value ?? [])
    }()
}


extension Far {
    
    static let _default = Settings.API.Default()
}
