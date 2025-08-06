//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by mac on 8/5/25.
//  Copyright © 2025 Sergey Kargopolov. All rights reserved.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {
    
    var sut: SignupwebService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = SignupwebService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testSignupwebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        // Arrange
        //Act
        
        let signFormRequestModel = SignupFormRequestModel(firstName: "David", lastName: "Putin", email: "test2344@qq.com", password: "12345678")
        sut.signup(withForm: signFormRequestModel)
        
        //Assert
        
        
    }



}
