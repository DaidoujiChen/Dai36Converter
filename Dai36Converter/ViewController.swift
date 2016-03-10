//
//  ViewController.swift
//  Dai36Converter
//
//  Created by DaidoujiChen on 2016/3/10.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet weak var outputTextField: NSTextField!

    @IBAction func onPressConvertAction(sender: AnyObject) {
        let splitInput = self.inputTextField.stringValue.componentsSeparatedByString("-")
        var result = ThirtySix(by: "")
        for input in splitInput {
            result = result + ThirtySix(by: input)
        }
        self.outputTextField.stringValue = result.value
    }
    
}

