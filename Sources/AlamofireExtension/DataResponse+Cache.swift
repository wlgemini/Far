//
//  DataResponse+Extension.swift
//

import Foundation
import Alamofire


public extension Alamofire.AFDataResponse {
    
    /// Cache data, default using `URLCache.shared`, redirect response will not be cached.
    var cachedData: Data? {
        guard let request = self.request else { return nil }
        return URLCache.shared.cachedResponse(for: request)?.data
    }
    
    /// Decoded `Alamofire.AFDataResponse.cachedData`
    func cachedValue(options: JSONSerialization.ReadingOptions = .allowFragments) -> Any?
    where Success == Any {
        guard let data = self.cachedData else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: options)
    }
    
    /// Decoded `Alamofire.AFDataResponse.cachedData`
    func cachedValue(decoder: Alamofire.DataDecoder = JSONDecoder()) -> Success?
    where Success: Decodable {
        guard let data = self.cachedData else { return nil }
        return try? decoder.decode(Success.self, from: data)
    }
}
