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
            weakSelf.click1()
            weakSelf.errorMessage = "我是错误值"
        
        }
    }
    
    

    @objc func click1() {
        codeView.cleanCodes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
