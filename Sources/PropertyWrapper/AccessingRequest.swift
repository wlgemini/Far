//
//  AccessingRequest.swift
//

import Foundation
import Alamofire


/// Getting `Alamofire.DataRequest`
@propertyWrapper
public final class AccessingRequest<A>
where A: API {
    
    /// Determine whether or not to cancel the underlaying request when self deinit
    public var isCancelRequestWhenDeinit: Swift.Bool = true
    
    /// The underlaying request of current API
    public internal(set) weak var request: Alamofire.DataRequest?
    
    /// Init
    /// - Parameters:
    ///   - api: some API
    public init(_ api: A, file: Swift.String = #fileID) {
        self._api = api
        self._location = Location(file, nil)
    }
    
    public var wrappedValue: A {
        self._modifiedAPI
    }
    
    public var projectedValue: AccessingRequest<A> {
        self
    }
    
    let _api: A
    let _location: Location
    lazy var _modifiedAPI = self._api._modifier(_InternalModifier._AccessingRequest(onRequestAvailable: { [weak self] request in
        self?.request = request as? Alamofire.DataRequest
    }))
    
    deinit {
        if self.isCancelRequestWhenDeinit {
            _Log.trace("Auto cancelling request when deinit", location: self._location)
            self.request?.cancel()
        }
    }
}
