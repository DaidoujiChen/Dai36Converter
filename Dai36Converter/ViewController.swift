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
    @IBOutlet weak var resultTextField: NSTextField!

    @IBAction func onPressConvertAction(sender: AnyObject) {
        let splitInput = self.inputTextField.stringValue.componentsSeparatedByString("-")
        var result = ThirtySix(by: "")
        for input in splitInput {
            result <+= ThirtySix(by: input)
        }
        self.outputTextField.stringValue = result.value
        
        if let safeURL = NSURL(string: "http://tinyurl.com/api-create.php?url=moemoeder://?unlock=\(result.value)") {
            NSURLSession.sharedSession().dataTaskWithURL(safeURL, completionHandler: { [weak self] (data, response, error) -> Void in
                guard let safeSelf = self else {
                    return
                }
                
                if let safeData = data, let safeResult = String(data: safeData, encoding: NSUTF8StringEncoding) where error == nil {
                    safeSelf.resultTextField.stringValue = safeResult
                }
                else {
                    safeSelf.resultTextField.stringValue = "Some Thing Wrong"
                }
            }).resume()
        }
    }
    
}

