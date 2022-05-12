import XCTest
import Alamofire
import Far


class SettingSessionTests {
    
    func sessionInit() {
        let session = Alamofire.Session()
        XCTAssert(Far.session == nil)
        XCTAssert(Far.isSessionFinalized == false)
        
        Far.session = session
        XCTAssert(Far.session === session)
        XCTAssert(Far.isSessionFinalized == false)
        
        Far.sessionFinalize()
        XCTAssert(Far.session === session)
        XCTAssert(Far.isSessionFinalized == true)
        
        Far.session = nil
        XCTAssert(Far.session != nil)
        XCTAssert(Far.session === session)
        XCTAssert(Far.isSessionFinalized == true)
    }
}
