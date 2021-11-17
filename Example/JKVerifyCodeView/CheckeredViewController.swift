//
//  CheckeredViewController.swift
//  JKVerifyCodeView_Example
//
//  Created by IronMan on 2021/11/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class CheckeredViewController: UIViewController {

    /// 验证码的View
    lazy var codeView: JKVerifyCodeView = {
        let style = JKVerifyCodeStyle()
        style.cursorColor = UIColor.red
        style.verifyCodeStyleType = .checkered
        style.secureTextEntry = false
        
        let codeView = JKVerifyCodeView(frame: CGRect(x: 62, y: 261, width: UIScreen.main.bounds.width - 124, height: 47), inputTextNum: 6, style: style)
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "方格样式"
        self.view.backgroundColor = .white
        
        self.view.addSubview(codeView)
        
        codeView.textFiled.becomeFirstResponder()
        
        // 监听验证码输入的过程
        codeView.textValueChange = { str in
            print("输入中：\(str)")
        }
        
        // 监听验证码输入完成
        codeView.inputFinish = { str in
            print("输入完成：\(str)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
