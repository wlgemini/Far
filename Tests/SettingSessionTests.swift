//
//  SettingSessionTests.swift
//

import XCTest
@testable import Alamofire
@testable import Far


class SettingSessionTests {
    
    func sessionSetting() {
        // session not finalized
        XCTAssert(Far._isSessionFinalized == false, "session finalized")
        
        Far.session.configuration(URLSessionConfiguration.af.default)
        Far.session.requestQueue(DispatchQueue(label: "requestQueue"))
        Far.session.serializationQueue(DispatchQueue(label: "serializationQueue"))
        Far.session.interceptor(Alamofire.Interceptor())
        Far.session.serverTrustManager(Alamofire.ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:]))
        Far.session.redirectHandler(Alamofire.Redirector.doNotFollow)
        Far.session.cachedResponseHandler(Alamofire.ResponseCacher.doNotCache)
        Far.session.eventMonitors([Alamofire.ClosureEventMonitor()])
    }
    
    func sessionInit() {
        // session not finalized
        XCTAssert(Far._isSessionFinalized == false, "session finalized")
        
        // session finalize
        let session = Far.sessionFinalize()
        
        // session finalized
        XCTAssert(Far._isSessionFinalized == true, "session not finalized")
        
        // URLSessionConfiguration.af.default
        for header in session.sessionConfiguration.headers {
            XCTAssert(Far.session.configuration.value.headers.contains(header), "configuration.header not match")
        }
        
        // requestQueue
        XCTAssert(session.requestQueue.label == Far.session.requestQueue.value?.label, "requestQueue not equal")
        
        // serializationQueue
        XCTAssert(session.serializationQueue.label == Far.session.serializationQueue.value?.label, "serializationQueue not equal")
        
        // interceptor
        XCTAssert(session.interceptor != nil && Far.session.interceptor.value != nil, "interceptor is nil")
        
        // serverTrustManager
        XCTAssert(session.serverTrustManager === Far.session.serverTrustManager.value, "serverTrustManager not equal")
        
        // redirectHandler
        XCTAssert(session.redirectHandler != nil && Far.session.redirectHandler.value != nil, "redirectHandler is nil")
        
        // cachedResponseHandler
        XCTAssert(session.cachedResponseHandler != nil && Far.session.redirectHandler.value != nil, "cachedResponseHandler is nil")
        
        // eventMonitors
        let isMonitorsEqual = session.eventMonitor.monitors.count == session.defaultEventMonitors.count + (Far.session.eventMonitors.value?.count ?? 0)
        XCTAssert(isMonitorsEqual, "eventMonitors not equal")
    }
}
