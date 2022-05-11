//
//  DataRequestTests.swift
//
//  WebServer: https://httpbin.org/
//

import XCTest
@testable import Alamofire
@testable import Far


class DataRequestTests {
    
    func method(test: XCTestCase) {
        // Given
        Far.default.dataRequest.base("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Any, AFError>?
        let post = POST<[String: Any], Any>("/post")

        
        // When
        post.request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertNotNil(response?.result)
        XCTAssertNil(response?.error)
    }
    
    func auth(test: XCTestCase) {
        // Given
        struct Auth: Decodable {
            var authenticated: Bool
            var user: String
        }
        
        Far.default.dataRequest.base("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Auth, AFError>?
        let get = GET<[String: Any], Auth>("/basic-auth/some_user/somepassword")

        
        // When
        get.authenticate(username: "some_user", password: "somepassword").request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        let user = try? response?.result.get().user
        let auth = try? response?.result.get().authenticated
        XCTAssert(user == "some_user" && auth == true)
        XCTAssertNil(response?.error)
    }
    
    func statusCodes(test: XCTestCase) {
        // Given
        Far.default.dataRequest.base("https://httpbin.org")
        let vali0Filfill = XCTestExpectation(description: "")
        let vali0: [String: Alamofire.DataRequest.Validation] = [
            "vali0": { (req, resp, data) -> DataRequest.ValidationResult in
                vali0Filfill.fulfill()
                return .success(())
            }
        ]
        
        let vali1Filfill = XCTestExpectation(description: "")
        let vali1: (String, Alamofire.DataRequest.Validation) = (
            "vali1", { (req, resp, data) -> DataRequest.ValidationResult in
                vali1Filfill.fulfill()
                return .success(())
            }
        )
        Far.default.dataResponse.validations(vali0)
        
        let respFilfill = XCTestExpectation(description: "")
        var response: DataResponse<Any, AFError>?
        let get = GET<[String: Any], Any>("/status/400")
        
        // When
        get
            .validate(identifier: vali1.0, validation: vali1.1)
            .request(nil) { resp in
            response = resp
            respFilfill.fulfill()
        }
        
        test.wait(for: [vali0Filfill, vali1Filfill, respFilfill], timeout: 60)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssert(response?.response?.statusCode == 400)
    }
    
    func headers(test: XCTestCase) {
        // Given
        struct Body: Decodable {
            struct Headers: Decodable {
                let Abc: String
                let Def: String
            }
            
            let headers: Headers
        }
        
        Far.default.dataRequest.base("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<Body, AFError>?
        let get = GET<[String: Any], Body>("/headers")
        
        // When
        get
            .headers(["Abc": "1", "Def": "2"]).request(nil) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        let body = try? response?.result.get()
        XCTAssert(body?.headers.Abc == "1")
        XCTAssert(body?.headers.Def == "2")
    }
    
    func echo(test: XCTestCase) {
        // Given
        struct Params: Codable, Equatable {
            let foo: String
            let bar: Int
        }
        
        struct HTTPBinResponse: Decodable {
            let headers: [String: String]
            let origin: String
            let url: String
            let data: String?
            let form: [String: String]?
            let args: [String: String]
        }
        
        Far.default.dataRequest.base("https://httpbin.org")
        let expectation = XCTestExpectation(description: "")
        var response: DataResponse<HTTPBinResponse, AFError>?
        let post = POST<Params, HTTPBinResponse>("/anything")
        let params = Params(foo: "foo", bar: 123)
        
        // When
        post
            .request(params) { resp in
            response = resp
            expectation.fulfill()
        }
        
        test.wait(for: [expectation], timeout: 20)
        
        // Then
        XCTAssertNotNil(response)
        let bin = try? response?.result.get()
        XCTAssertNotNil(bin)
        let dataStr = (bin?.data ?? "").data(using: .utf8) ?? Data()
        let data = try? JSONDecoder().decode(Params.self, from: dataStr)
        XCTAssert(data == params)
    }
}
