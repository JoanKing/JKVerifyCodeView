//
//  ViewController.swift
//  JKVerifyCodeView
//
//  Created by JoanKing on 06/07/2021.
//  Copyright (c) 2021 JoanKing. All rights reserved.
//

import UIKit
import JKVerifyCodeView
class ViewController: UIViewController {

    /// 验证码的View
    lazy var codeView: JKVerifyCodeView = {
        let codeView = JKVerifyCodeView(frame: CGRect(x: 62, y: 261, width: UIScreen.main.bounds.width - 124, height: 47), inputTextNum: 6, style: JKVerifyCodeStyle())
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

