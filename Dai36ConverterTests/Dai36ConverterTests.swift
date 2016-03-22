//
//  Dai36ConverterTests.swift
//  Dai36ConverterTests
//
//  Created by DaidoujiChen on 2016/3/10.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import XCTest
@testable import Dai36Converter

class Dai36ConverterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCalculate1() {
        let number1 = ThirtySix(by: "1")
        let number2 = ThirtySix(by: "1")
        let result = number1 + number2
        assert(result.value == "2", "算出結果不符")
    }
    
    func testCalculate2() {
        let number1 = ThirtySix(by: "Z")
        let number2 = ThirtySix(by: "5")
        let result = number1 + number2
        assert(result.value == "14", "算出結果不符")
    }
    
    func testCalculate3() {
        let number1 = ThirtySix(by: "abcde")
        let number2 = ThirtySix(by: "111111")
        let result = number1 + number2
        assert(result.value == "1BCDEF", "算出結果不符")
    }
    
    func testCalculate4() {
        let number1 = ThirtySix(by: "z")
        let number2 = ThirtySix(by: "111111")
        let result = number1 + number2
        assert(result.value == "111120", "算出結果不符")
    }
    
    func testCalculate5() {
        let number1 = ThirtySix(by: "z")
        let number2 = ThirtySix(by: "zz")
        let number3 = ThirtySix(by: "zzz")
        let result = number1 + number2 + number3
        assert(result.value == "110X", "算出結果不符")
    }
    
    func testCalculate6() {
        let number1 = ThirtySix(by: "111")
        let number2 = ThirtySix(by: "222")
        let number3 = ThirtySix(by: "zzz")
        let result = number1 + number2 + number3
        assert(result.value == "1332", "算出結果不符")
    }
    
    func testCalculate7() {
        let number1 = ThirtySix(by: "17A9214D")
        let number2 = ThirtySix(by: "6EAF")
        let number3 = ThirtySix(by: "4637")
        let number4 = ThirtySix(by: "B843")
        let number5 = ThirtySix(by: "6295A2E6F894")
        let result = number1 + number2 + number3 + number4 + number5
        assert(result.value == "6295B9OG31V6", "算出結果不符")
    }
    
    func testCalculate8() {
        let testKey = "17A9214D-6EAF-4637-B843-6295A2E6F894"
        var result = ThirtySix(by: "")
        for input in testKey.componentsSeparatedByString("-") {
            result <+= ThirtySix(by: input)
        }
        assert(result.value == "6295B9OG31V6", "算出結果不符")
    }
    
}
