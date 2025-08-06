//
//  SignupFormModelValidator.swift
//  PhotoAppTests
//
//  Created by mac on 8/4/25.
//  Copyright © 2025 Sergey Kargopolov. All rights reserved.
//

import XCTest
@testable import PhotoApp

final class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    // MARK: FirstName Validation
    
    func testSignupFormModelValidator_WhenVaildFirstNameProvided_ShouldReturnTrue() {
        
        // Arrange
        // Act
        let isFirstNameVaild = sut.isFirstNameValid(firstName: "Serger")
        
        // Assert
        XCTAssertTrue(isFirstNameVaild, "The isFirstNameVaild() should have returned TRUE for a vaild first name but returned FALSE.")
        
    }
    
    
    func testSignupFormModelValidator_WhenEmptyFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isFirstNameVaild = sut.isFirstNameValid(firstName: "")
        
        // Assert
        XCTAssertFalse(isFirstNameVaild, "The isFirstNameVaild() should have returned FALSE for a vaild first name but returned TRUE.")
        
    }
    
    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isFirstNameVaild = sut.isFirstNameValid(firstName: "S")
        
        // Assert
        XCTAssertFalse(isFirstNameVaild, "The isFirstNameVaild() should have returned FALSE for a vaild first name that is shorter than \(SignupConstants.firstNameMinLength) chars but returned TRUE.")
        
    }
    
    
    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isFirstNameVaild = sut.isFirstNameValid(firstName: "ABCDEFGHLZKLMNOP") // 16        Valid <= 15
        
        // Assert
        XCTAssertFalse(isFirstNameVaild, "The isFirstNameVaild() should have returned FALSE for a vaild first name that is longer than \(SignupConstants.firstNameMaxLength)(don't include \(SignupConstants.firstNameMaxLength)) chars but returned TRUE.")
        
    }
    
    
    
    // MARK: LastName Validation
    
    
    func testSignupFormModelValidator_WhenVaildLastNameProvided_ShouldReturnTrue() {
        
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Serger")
        
        // Assert
        XCTAssertTrue(isLastNameValid, "The isFirstNameVaild() should have returned TRUE for a vaild first name but returned FALSE.")
        
    }
    
    
    func testSignupFormModelValidator_WhenEmptyLastNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isFirstNameVaild() should have returned FALSE for a vaild first name but returned TRUE.")
        
    }
    
    func testSignupFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "S")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isFirstNameVaild() should have returned FALSE for a vaild first name that is shorter than \(SignupConstants.firstNameMinLength) chars but returned TRUE.")
        
    }
    
    
    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        
        // Arrange
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "ABCDEFGHLZKLMNOP") // 16        Valid <= 15
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isFirstNameVaild() should have returned FALSE for a vaild first name that is longer than \(SignupConstants.firstNameMaxLength)(don't include \(SignupConstants.firstNameMaxLength)) chars but returned TRUE.")
        
    }
    
    
    // MARK: Email Validation
    
    func testSignupFormModelValidator_WhenVaildEmailProvided_ShouldReturnTrue() {
        
        // Arrange
        // Act
        let isValidEmailFormat = sut.isValidEmailFormat(email: "331686549@qq.com")
        
        // Assert
        XCTAssertTrue(isValidEmailFormat, "The isValidEmailFormat() should have returned TRUE for a vaild email but returned FALSE.")
        
    }
    
    func testSignupFormModelValidator_WhenInvalidsymbolEmailProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isValidEmailFormat = sut.isValidEmailFormat(email: "331686549#%^qq.com")
        
        // Assert
        XCTAssertFalse(isValidEmailFormat, "The isValidEmailFormat() should have returned FALSE for Invalid symbol Email but returned TRUE.")
        
    }
    
    
    // MARK: Password Validation
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12345678")
        
        // Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should have returned TRUE for a valid password  but it has returned FALSE")
        
    }
    
    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is shorter than \(SignupConstants.passwordMinLength) but it has returned TRUE")
        
    }
    
    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12345678901234567")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is longer than \(SignupConstants.passwordMaxLength) but it has returned TRUE")
        
    }
    
    func testSignupFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword:"12345678")
        
        // Assert
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch() should have returned TRUE for matching passwords but it has returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenNotMatchingPasswordsProvided_ShouldReturnFalse() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "1234678")
        
        // Assert
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch() should have returned FALSE for passwords that do not match but it has returned TRUE")
    }
    
    



}
