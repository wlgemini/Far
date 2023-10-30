//
//  _InternalModifier.swift
//  

import Foundation
import Alamofire


/// _InternalModifier
enum _InternalModifier {
    
    // MARK: - Accessing
    /// AccessingRequest
    struct _AccessingRequest: APIModifier {
        
        func apply(to context: Settings.API.Modified) {
            context.accessing.onRequestAvailable = self._onRequestAvailable
        }
        
        var _onRequestAvailable: (Alamofire.Request) -> Swift.Void
        
        init(onRequestAvailable: @escaping (Alamofire.Request) -> Swift.Void) {
            self._onRequestAvailable = onRequestAvailable
        }
    }
}
