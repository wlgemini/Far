//
//  AutoCancelRequest.swift
//

import Foundation
import Alamofire


/// Auto cancel `Alamofire.DataRequest`
@propertyWrapper
public final class AutoCancelRequest<A> where A: API {
    
    /// Determine whether or not to cancel the underlaying request when self deinit
    public var isCancelRequestWhenDeinit: Swift.Bool = true
    
    /// The underlaying request of current API
    public internal(set) weak var request: Alamofire.DataRequest?
    
    /// Init
    /// - Parameters:
    ///   - api: some API
    public init(_ api: A, file: Swift.StaticString = #fileID) {
        self._location = Location(file, nil)
        self._api = api._modifier(_InternalModifier._AccessingRequest(onRequestAvailable: { [weak self] request in
            self?.request = request as? Alamofire.DataRequest
        }))
    }
    
    public var wrappedValue: some API<A.Parameters, A.Returns> {
        self._api
    }
    
    public var projectedValue: AutoCancelRequest<A> {
        self
    }
    
    let _location: Location
    var _api: APIModified<A.Parameters, A.Returns, APIModifier2<A.Modifier, _InternalModifier._AccessingRequest>>!
    
    deinit {
        if self.isCancelRequestWhenDeinit {
            _Log.trace("Auto cancelling request when deinit", location: self._location)
            self.request?.cancel()
        }
    }
}
