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
    
    static var allTests = [
        ("testValidated", testValidated)
    ]

    func testValidated() {
        let validValue = 1
        let invalidValue = 0
        var validated = Validated<Int>(initialValue: 0, .init { value in
            if value == validValue {
                return .success(())
            } else {
                return .failure("")
            }
        })
//        XCTAssertNil(validated.restore())
        XCTAssertEqual(validated.wrappedValue, invalidValue)
        validated.wrappedValue = validValue
        XCTAssertEqual(validValue, validated.wrappedValue)
        XCTAssert(validated.isValid)
        validated.wrappedValue = invalidValue
        XCTAssertEqual(invalidValue, validated.wrappedValue)
        XCTAssertFalse(validated.isValid)
        XCTAssertEqual(validValue, validated.lastSuccessfulValidatedValue)
        validated.restore()
        XCTAssertEqual(validValue, validated.wrappedValue)
//        validated.wrappedValue = nil
//        XCTAssertNil(validated.wrappedValue)
    }
    
}
