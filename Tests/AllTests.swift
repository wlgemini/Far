//
//  AllTests.swift
//  

import XCTest
import Alamofire
import Far


class AllTests: XCTestCase {
    
    let settingSession = SettingSessionTests()
    let settingAPI = SettingAPITests()
    let dataRequest = DataRequestTests()
    
    func testALL() {
        // Session
        settingSession.sessionInit()
        
        
        // API
        settingAPI.requestMethod()
        settingAPI.requestURL()
        settingAPI.requestEncoding()
        settingAPI.requestEncoder()
        settingAPI.requestHeaders()
        settingAPI.requestModifier()
        settingAPI.requestModify()
        
        settingAPI.responseModify()
        settingAPI.responseQueue()
        settingAPI.responseDataResponseSerializer()
        settingAPI.responseStringResponseSerializer()
        settingAPI.responseJSONResponseSerializer()
        settingAPI.responseDecodableResponseSerializer()
        settingAPI.accessing()
        
        
        // DataRequest
        dataRequest.method(test: self)
        dataRequest.auth(test: self)
        dataRequest.statusCodes(test: self)
        dataRequest.headers(test: self)
        dataRequest.echo(test: self)
    }
}
