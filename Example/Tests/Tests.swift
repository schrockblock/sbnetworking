// https://github.com/Quick/Quick

import Quick
import Nimble
import OHHTTPStubs
import SBNetworking
@testable import SBNetworking_Example

class LoginSpec: QuickSpec {
    override func spec() {
        describe("Login test") {
            context("success") {
                it("should log in successfully") {
                    stub(condition: isHost("habitica.com")) { _ in
                        let stubPath = OHPathForFile("login_success.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }
                    waitUntil(timeout: 0.5) { done in
                        let username = "fake73"
                        let password = "fakepassword"
                        
                        ServerConfiguration.defaultConfiguration = ExampleServerConfiguration.production
                        LoginNetworkCall().login(username: username, password: password, completion: { (successObject, error) in
                            expect(successObject).toNot(beNil())
                            if let success = successObject {
                                expect(success.objectId).toNot(beNil())
                                expect(success.apiToken).toNot(beNil())
                            }
                            done()
                        })
                    }
                }
            }
        }
    }
}
