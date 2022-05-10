//
//  InternalModifier.swift
//  

import Foundation
import Alamofire


/// _InternalModifier
enum _InternalModifier {
    
    // MARK: - Accessing
    /// AccessingRequest
    struct AccessingRequest: Modifier {
        
        public func modify(context: ModifyContext) {
            context.accessing.onRequestAvailable = self._onRequestAvailable
        }
        
        var _onRequestAvailable: (Alamofire.Request) -> Void
        
        init(onRequestAvailable: @escaping (Alamofire.Request) -> Void) {
            self._onRequestAvailable = onRequestAvailable
        }
    }
}
