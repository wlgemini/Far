//
//  LogTests.swift
//

import XCTest
import Alamofire
@testable import Far


class LogTests {
    
    func logInit() {
        
        Far.log.trace { log in
            Swift.print("[Trace]", log.location, log.item)
        }
        
        Far.log.warning { log in
            Swift.print("[Warning]", log.location, log.item)
        }
        
        Far.log.error { log in
            Swift.print("[Error]", log.location, log.item)
        }
    }
}
