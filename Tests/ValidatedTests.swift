//
//  ValidatedTests.swift
//  ValidatedPropertyKitKit
//
//  Created by Sven Tiigi on 20.06.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

@testable import ValidatedPropertyKit
import XCTest

class ValidatedTests: XCTestCase {
    struct TestStruct {
        @Validated(.init { value in
            if value == 1 {
                return .success(())
            } else {
                return .failure("")
            }
        }) public var validated  = 0
    }
    
    static var allTests = [
        ("testValidated", testValidated)
    ]

    func testValidated() {
        let validValue = 1
        let invalidValue = 0
        
        var testStruct = TestStruct()
        
        XCTAssertNil(testStruct.$validated.restore())
        XCTAssertEqual(testStruct.validated, invalidValue)
        testStruct.validated = validValue
        XCTAssertEqual(validValue, testStruct.validated)
        XCTAssert(testStruct.$validated.isValid)
        testStruct.validated = invalidValue
        XCTAssertEqual(invalidValue, testStruct.validated)
        XCTAssertFalse(testStruct.$validated.isValid)
        XCTAssertEqual(validValue, testStruct.$validated.lastSuccessfulValidatedValue)
        testStruct.$validated.restore()
        XCTAssertEqual(validValue, testStruct.validated)
    }
    
}
