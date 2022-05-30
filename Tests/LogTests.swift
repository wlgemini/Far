//
//  LogTests.swift
//

import XCTest
import Alamofire
@testable import Far


class LogTests {
 
    func logInit() {
        Far.log.trace { log in
            Swift.print("Test", log)
        }
        
        Far.log.warning { log in
            Swift.print("Test", log)
        }
        
        Far.log.error { log in
            Swift.print("Test", log)
        }
    }
}
