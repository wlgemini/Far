//
//  DataRequestTests.swift
//
//  WebServer: https://httpbin.org/
//

import Testing
import Alamofire
import Far
import Foundation


extension FarTests {
    
    func method() async throws {
        // Given
        Far.api.dataRequest.base("https://httpbin.org")
        let post = POST<[String: Any], Data>("/post")
        
        // When
        let resp = await post.request(nil)
        
        // Then
        #expect(resp.error == nil)
    }
    
    func auth() async throws {
        // Given
        struct Auth: Decodable {
            var authenticated: Bool
            var user: String
        }
        
        Far.api.dataRequest.base("https://httpbin.org")
        let username = "some_user"
        let password = "some_password"
        let get = GET<[String: Any], Auth>("/basic-auth/\(username)/\(password)")
        
        
        // When
        let resp = await get.authenticate(username: username, password: password).request(nil)
        
        // Then
        let user = try resp.result.get().user
        let auth = try resp.result.get().authenticated
        #expect(user == "some_user" && auth == true)
        #expect(resp.error == nil)
    }
    
    func statusCodes() async {
        // Given
        Far.api.dataRequest.base("https://httpbin.org")
        
        let vali0: (String, Alamofire.DataRequest.Validation) = (
            "vali1", { (req, resp, data) -> DataRequest.ValidationResult in
                return .success(())
            }
        )
        
        let get = GET<[String: Any], Data>("/status/200")
        
        // When
        let resp = await get.validate(identifier: vali0.0, validation: vali0.1).request(nil)
    
        // Then
        #expect(resp.response?.statusCode == 200)
    }
    
    func headers() async throws {
        // Given
        struct Body: Decodable {
            struct Headers: Decodable {
                let Abc: String
                let Def: String
            }
            
            let headers: Headers
        }
        
        Far.api.dataRequest.base("https://httpbin.org")
        let get = GET<[String: Any], Body>("/headers")
        
        // When
        let resp = await get.headers(["Abc": "1", "Def": "2"]).request(nil)
        
        // Then
        let body = try resp.result.get()
        #expect(body.headers.Abc == "1")
        #expect(body.headers.Def == "2")
    }
    
    func echo() async throws {
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
        
        Far.api.dataRequest.base("https://httpbin.org")
        let post = POST<Params, HTTPBinResponse>("/anything")
        let params = Params(foo: "foo", bar: 123)
        
        // When
        let resp = await post.request(params)
        
        // Then
        let bin = try resp.result.get()
        let dataStr = (bin.data ?? "").data(using: .utf8) ?? Data()
        let data = try JSONDecoder().decode(Params.self, from: dataStr)
        #expect(data == params)
    }
}
