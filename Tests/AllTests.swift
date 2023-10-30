//
//  AllTests.swift
//  

import XCTest
import Alamofire
import Far


class AllTests: XCTestCase {
    
    let log = LogTests()
    let settingSession = SettingSessionTests()
    let settingAPI = SettingAPITests()
    let dataRequest = DataRequestTests()
    
    func testALL() {
        // Log
        self.log.logInit()
        
        // Session
        self.settingSession.sessionInit()
        
        
        // API
        self.settingAPI.requestMethod()
        self.settingAPI.requestURL()
        self.settingAPI.requestEncoding()
        self.settingAPI.requestEncoder()
        self.settingAPI.requestHeaders()
        self.settingAPI.requestModifier()
        self.settingAPI.requestModify()
        
        self.settingAPI.responseModify()
        self.settingAPI.responseQueue()
        self.settingAPI.responseDataResponseSerializer()
        self.settingAPI.responseStringResponseSerializer()
        self.settingAPI.responseJSONResponseSerializer()
        self.settingAPI.responseDecodableResponseSerializer()
        self.settingAPI.accessing()
        
        
        // DataRequest
        self.dataRequest.method(test: self)
        self.dataRequest.auth(test: self)
        self.dataRequest.statusCodes(test: self)
        self.dataRequest.headers(test: self)
        self.dataRequest.echo(test: self)
    }
}
