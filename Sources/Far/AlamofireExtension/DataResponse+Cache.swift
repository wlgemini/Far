//
//  DataResponse+Extension.swift
//

import Foundation
import Alamofire


public extension Alamofire.AFDataResponse {
    
    /// Cache data, default using `URLCache.shared`, redirect response will not be cached.
    var cachedData: Foundation.Data? {
        guard let request = self.request else { return nil }
        return Foundation.URLCache.shared.cachedResponse(for: request)?.data
    }
    
    /// Decoded `Alamofire.AFDataResponse.cachedData`
    func cachedValue(options: Foundation.JSONSerialization.ReadingOptions = .allowFragments) -> Any?
    where Success == Any {
        guard let data = self.cachedData else { return nil }
        return try? Foundation.JSONSerialization.jsonObject(with: data, options: options)
    }
    
    /// Decoded `Alamofire.AFDataResponse.cachedData`
    func cachedValue(decoder: Alamofire.DataDecoder = Foundation.JSONDecoder()) -> Success?
    where Success: Swift.Decodable {
        guard let data = self.cachedData else { return nil }
        return try? decoder.decode(Success.self, from: data)
    }
}
