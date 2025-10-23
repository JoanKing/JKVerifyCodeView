//
//  CheckeredViewController.swift
//  JKVerifyCodeView_Example
//
//  Created by IronMan on 2021/11/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import JKVerifyCodeView
class CheckeredViewController: UIViewController {
    var errorMessage: String = ""
    /// 验证码的View
    lazy var codeView: JKVerifyCodeView = {
        let style = JKVerifyCodeStyle()
        style.cursorColor = UIColor.red
        style.cursorHeight = 20
        style.cursorWidth = 3
        style.verifyCodeStyleType = .checkered
        style.secureTextEntry = false
        style.customCornerRadius = 6
        style.borderWidth = 0.5
        style.inputTextNum = 5
        style.padding = 30
        style.isEvenlySplit = true
        // style.borderColor = UIColor.blue
        let codeView = JKVerifyCodeView(frame: CGRect(x: 32, y: 261, width: UIScreen.main.bounds.width - 64, height: 47), style: style)
        codeView.backgroundColor = .yellow
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "方格样式"
        self.view.backgroundColor = .brown
        
        self.view.addSubview(codeView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", style: .plain, target: self, action: #selector(click1))
        
        codeView.textFiled.becomeFirstResponder()
        
        // 监听验证码输入的过程
        codeView.textValueChange = {[weak self] str in
            guard let weakSelf = self else {
                return
            }
            print("输入中：\(str) 错误值：\(weakSelf.errorMessage)")
        }
        
        // 监听验证码输入完成
        codeView.inputFinish = {[weak self] str in
            guard let weakSelf = self else {
                return
            }
            print("输入完成：\(str)")
        
        }
    }
    

    @objc func click1() {
        codeView.cleanCodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        codeView.textFiled.endEditing(true)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
