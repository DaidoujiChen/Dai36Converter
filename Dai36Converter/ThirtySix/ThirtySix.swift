//
//  ThirtySix.swift
//  Dai36Converter
//
//  Created by DaidoujiChen on 2016/3/10.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import Foundation

extension Character {
    
    private func ascii() -> Int {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return Int(scalars[scalars.startIndex].value)
    }
    
}

extension Array where Element: IntegerType {
    
    private func safeValueAtBehind(index: Int) -> Element {
        let safeIndex = self.behindAt(index)
        return safeIndex >= 0 ? self[safeIndex] : 0
    }
    
    private func behindAt(index: Int) -> Int {
        return self.count - 1 - index
    }
    
}

func +(left: ThirtySix, right: ThirtySix) -> ThirtySix {
    return left.add(right)
}

// Private Instance Method
extension ThirtySix {
    
    // 先把數字加起來
    private func add(other: ThirtySix) -> ThirtySix {
        
        // 取長那邊當作基準
        let maxCount = max(self.numbers.count, other.numbers.count)
        var newThirtySix = ThirtySix(size: maxCount)
        
        for index in 0..<maxCount {
            
            // 分別檢查該 index 在兩個相加的數字上是否都有該欄位
            let selfValue = self.numbers.safeValueAtBehind(index)
            let otherValue = other.numbers.safeValueAtBehind(index)
            
            // 放到新的欄位
            newThirtySix.numbers[newThirtySix.numbers.behindAt(index)] = selfValue + otherValue
        }
        return newThirtySix.carry()
    }
    
    // 進位處理
    private func carry() -> ThirtySix {
        
        // 建立一個比目前多 1 位的空格先
        var newThirtySix = ThirtySix(size: self.numbers.count + 1)
        for index in 0..<self.numbers.count {
            let selfIndex = self.numbers.behindAt(index)
            let newIndex = newThirtySix.numbers.behindAt(index)
            
            // 把數值放入新的空格中
            let value = self.numbers[selfIndex] + newThirtySix.numbers[newIndex]
            if (value >= 36) {
                newThirtySix.numbers[newIndex] = value % 36
                newThirtySix.numbers[newIndex - 1] = value / 36
            }
            else {
                newThirtySix.numbers[newIndex] = value
            }
        }
        return newThirtySix
    }
    
    // 字元轉 ASCII
    private func characterToASCII(character: Character) -> Int? {
        let characterASCII = character.ascii()
        if characterASCII >= self.digital0 && characterASCII <= self.digital9 {
            return characterASCII - self.digital0
        }
        else if characterASCII >= self.letterA && characterASCII <= self.letterZ {
            return characterASCII - self.letterA + 10
        }
        return nil
    }
    
    // ASCII 轉字串
    private func asciiToString(ascii: Int) -> String? {
        switch ascii {
        case 0..<10:
            return String(UnicodeScalar(ascii + self.digital0))
            
        case 10..<36:
            return String(UnicodeScalar(ascii - 10 + self.letterA))
            
        default:
            return nil
        }
    }
    
}

struct ThirtySix {
    
    private var numbers: [Int] = []
    private let digital0 = Character("0").ascii()
    private let digital9 = Character("9").ascii()
    private let letterA = Character("A").ascii()
    private let letterZ = Character("Z").ascii()
    
    var value: String {
        get {
            var resultString = ""
            var startUntilNotZero = false
            for index in 0..<self.numbers.count {
                let asciiValue = self.numbers[index]
                
                // 過濾掉前面如果有 0
                if !startUntilNotZero {
                    if asciiValue > 0 {
                        startUntilNotZero = true
                    }
                    else {
                        continue
                    }
                }
                
                // 將 ascii 轉為字串
                if let safeString = self.asciiToString(asciiValue) {
                    resultString += safeString
                }
                else {
                    print("Some ASCII Out of Control")
                }
            }
            return resultString
        }
    }
    
    init(by string: String) {
        let uppercaseString = string.uppercaseString
        
        // 先將字串轉為 ascii
        for (_, character) in uppercaseString.characters.enumerate() {
            if let safeASCII = self.characterToASCII(character) {
                self.numbers.append(safeASCII)
            }
            else {
                print("Some Character Out of Control")
            }
        }
    }
    
    private init(size: Int) {
        for _ in 0..<size {
            self.numbers.append(0)
        }
    }
    
}