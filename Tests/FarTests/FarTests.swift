import Testing
import Foundation
import Alamofire
import Far


@Suite
struct FarTests {
    
    init() {
        // Log
        self.logInit()
        
        // Session
        self.sessionInit()
    }
   
    func logInit() {
        Far.log.trace { log in
            Swift.print("[Trace]", "\(log.location):", log.item)
        }
        
        Far.log.warning { log in
            Swift.print("[Warning]", "\(log.location):", log.item)
        }
        
        Far.log.error { log in
            Swift.print("[Error]", "\(log.location):", log.item)
        }
    }

    func sessionInit() {
        let session = Alamofire.Session()
        
        Far.session = session
        #expect(Far.session === session)
        #expect(Far.isSessionFinalized == false)
        
        Far.session = nil
        #expect(Far.session == nil)
        #expect(Far.isSessionFinalized == false)
        
        Far.session = session
        #expect(Far.session === session)
        #expect(Far.isSessionFinalized == false)
        
        Far.sessionFinalize()
        #expect(Far.session === session)
        #expect(Far.isSessionFinalized == true)
        
        Far.session = nil
        #expect(Far.session != nil)
        #expect(Far.session === session)
        #expect(Far.isSessionFinalized == true)
    }
}

extension FarTests {
    
    /*
     测试case需要顺序执行
     */
    @Test
    func all() async throws {
        
        // API
        self.requestMethod()
        self.requestURL()
        self.requestEncoding()
        self.requestEncoder()
        self.requestHeaders()
        await self.requestModifier()
        self.requestModify()
        
        self.responseModify()
        self.responseQueue()
        self.responseDataResponseSerializer()
        self.responseStringResponseSerializer()
        self.responseJSONResponseSerializer()
        self.responseDecodableResponseSerializer()
        self.accessing()
        
        
        // DataRequest
        try await self.method()
        try await self.auth()
        await self.statusCodes()
        try await self.headers()
        try await self.echo()
    }
}
