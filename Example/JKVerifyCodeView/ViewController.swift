//
//  ViewController.swift
//  JKVerifyCodeView
//
//  Created by JoanKing on 06/07/2021.
//  Copyright (c) 2021 JoanKing. All rights reserved.
//

import UIKit
class ViewController: BaseViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "验证码"
        headDataArray = ["验证码的样式"];
        dataArray = [["下划线的样式", "方格样式"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: -验证码的样式
extension ViewController {
    
    // MARK: 1.1、下划线的样式
    @objc func test11() {
        self.navigationController?.pushViewController(UnderscoreViewController(), animated: true)
    }
    
    // MARK: 1.2、方格样式
    @objc func test12() {
        self.navigationController?.pushViewController(CheckeredViewController(), animated: true)
    }
}
