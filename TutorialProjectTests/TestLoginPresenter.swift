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

class TestLoginPresent: QuickSpec {
    override class func spec() {
        describe("Login") {
            // tạo instance của LoginPresenter
            var sut: LoginPresenter!
            // khai báo đối tượng của LoginDisplay
            var loginDisplayMock: LoginDisplayMock!
            // sẽ chạy trước mỗi test case
            beforeEach {
                loginDisplayMock = mock(LoginDisplay.self)
                sut = LoginPresenterImpl(controller: loginDisplayMock)
            }
            // group lại các test case
            context("Login form validate") {
                it("check usernam emptry") {
                    // input: usename rong
                    // action: .login(username, password)
                    //expect: show lên cho user 1 message lỗi "user  is requied"
                    let username = ""
                    sut.login(username: username, passwork: "testPasword")
                    // // expect
                    
                    verify(loginDisplayMock.validateFailure(message: "Username is required"))
                        .wasCalled()
                }
            }
        }
    }
}
