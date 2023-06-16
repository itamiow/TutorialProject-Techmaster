//
//  TestLoginPresenter.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
import Quick
import Nimble
import Mockingbird

@testable import TutorialProject

class TestLoginPresenter: QuickSpec {
    override class func spec() {
        describe("Login") {
            /**
             Step 1: Tạo instance của LoginPresenter
             */
            var sut: LoginPresenter!
            
            /// Khai báo đối tượng của LoginDisplay
            var loginDisplayMock: LoginDisplayMock!
            
            /**
             Sẽ chạy trước mỗi test case
             */
            beforeEach {
                loginDisplayMock = mock(LoginDisplay.self)
//                sut = LoginPresenterImpl(controller: loginDisplayMock)
            }
            
            /**
             Group lại các test case
             */
            context("Login form validate") {
                it("check username empty") {
                    /**
                     input : username rỗng
                     action: .login(username, password)
                     expect: show lên cho user 1 message lỗi "Username is required"
                     */
                    /// input
                    let username = ""
                    
                    // action
                    sut.login(username: username, password: "testPassword")
                    
                    /// expect
                    verify(loginDisplayMock.validateFailure(message: "Username is required", field: <#String#>)).wasCalled()
                }
            }
        }
    }
}
