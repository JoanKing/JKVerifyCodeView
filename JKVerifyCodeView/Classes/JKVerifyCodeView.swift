//
//  JKVerifyCodeView.swift
//  JKVerifyCodeView
//
//  Created by IronMan on 2021/6/7.
//

import Foundation
import SnapKit
import UIKit

public class JKVerifyCodeView: UIView {
    /// 是否输入完自动隐藏键盘
    public var isAutoResignFirstResponder: Bool = true
    /// 输入值改变
    public var textValueChange: ((_ text: String) -> Void)?
    /// 输入完成
    public var inputFinish: ((_ text: String) -> Void)?
    /// 输入框
    public lazy var textFiled: JKVerifyCodeTextView = {
        let textFiled = JKVerifyCodeTextView()
        textFiled.tintColor = .clear
        textFiled.backgroundColor = .clear
        textFiled.textColor = .clear
        if #available(iOS 12.0, *) {
            textFiled.keyboardType = .numberPad
            textFiled.textContentType = .oneTimeCode
        }
        textFiled.delegate = self
        textFiled.keyboardType = .decimalPad
        textFiled.addTarget(self, action: #selector(textFiledDidChange(_:)), for: .editingChanged)
        textFiled.addTarget(self, action: #selector(textFiledDidEnd(_:)), for: .editingDidEnd)
        self.addSubview(textFiled)
        return textFiled
    }()
    /// 验证码数量
    fileprivate var codeViews: [JKVerifyCodeNumView] = []
    /// 是否在输入中
    private var isInput = true
    /// 样式
    fileprivate var style: JKVerifyCodeStyle = JKVerifyCodeStyle()
    
    private var inputFields: [JKVerifyCodeNumView] = [];
    
    public init(frame: CGRect, style: JKVerifyCodeStyle = JKVerifyCodeStyle()) {
        super.init(frame: frame)
        self.style = style
        initSubviews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initSubviews() {
        textFiled.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(style.padding)
            make.right.equalToSuperview().offset(-style.padding)
            make.top.bottom.equalToSuperview()
        }
        // 每个验证码框宽度
        var itemWidth: CGFloat = 0
        // 左右两边的间距
        var padding: CGFloat = 0
        // 每个格子之间的间距
        var space: CGFloat = 0
        if style.isSquareBox {
            itemWidth = self.frame.size.height
            if style.isEvenlySplit {
                padding = style.padding
                space = (self.frame.size.width - style.padding * 2 - itemWidth * CGFloat(style.inputTextNum)) / (CGFloat(style.inputTextNum) - 1)
            } else {
                space = style.spacing
                padding = (self.frame.size.width - style.spacing * CGFloat(style.inputTextNum - 1) - itemWidth * CGFloat(style.inputTextNum)) / 2.0
            }
        } else if style.isCustomBoxSize {
            // 自定义盒子的大小
            itemWidth = style.customBoxSize.width
            padding = style.padding
            let denominator = CGFloat(style.inputTextNum - 1)
            let molecular = self.frame.width - style.padding * 2 - itemWidth * CGFloat(style.inputTextNum)
            space = molecular / denominator

        } else {
            itemWidth = (self.frame.size.width - style.padding * 2 - style.spacing * (CGFloat(style.inputTextNum) - 1)) / CGFloat(style.inputTextNum)
            padding = style.padding
            space = style.spacing
        }
        inputFields.removeAll()
        for i in 0..<style.inputTextNum {
            let codeNumView = JKVerifyCodeNumView(style: style)
            codeNumView.isUserInteractionEnabled = false
            self.addSubview(codeNumView)
            codeNumView.snp.makeConstraints { (make) in
                make.width.equalTo(itemWidth)
                make.left.equalToSuperview().offset(padding + CGFloat(i) * (space + itemWidth))
                make.top.bottom.equalToSuperview()
                
            }
            codeViews.append(codeNumView)
            inputFields.append(codeNumView)
            codeNumView.setCursorStatus(true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 供外部调用方法
public extension JKVerifyCodeView {
    
    // MARK: 设置验证码
    /// 设置验证码
    func setVerificationCode(code: String) {
        textFiled.text = code
        textFiledDidChange(textFiled)
    }
    
    // MARK: 清除所有输入
    /// 清除所有输入
    func cleanCodes(isFoucsFirst: Bool = false) {
        textFiled.text = ""
        textFiledDidChange(textFiled)
        allCursorHidden(isFoucsFirst: isFoucsFirst)
    }

    // MARK: 隐藏所有输入光标
    /// 隐藏所有输入光标
    func allCursorHidden(isFoucsFirst: Bool = false) {
        DispatchQueue.main.async {
            for i in 0..<self.codeViews.count {
                let codeView = self.codeViews[i]
                if i == 0 {
                    codeView.setCursorStatus(isFoucsFirst ? false : true)
                } else {
                    codeView.setCursorStatus(true)
                }
                if codeView.getNum().count == 0 {
                    codeView.setBottomLineFocus(isFocus: false)
                }
            }
        }
    }
    
    //MARK: 修改边框的颜色
    ///  修改边框的颜色
    /// - Parameter color: 边框的颜色
    func changeBoxBoxderColor(color: UIColor) {
        guard style.verifyCodeStyleType == .checkered else {
            return
        }
        for indexFiled in inputFields {
            indexFiled.changeNumLabelBorderColor(color: color)
        }
    }
    
    //MARK: 改变单个输入框的颜色
    /// 改变单个输入框的颜色
    /// - Parameter color: 颜色
    ///   - locationIndex: 位置
    func changeSingleBoxBoxderColor(color: UIColor, locationIndex: Int) {
        guard style.verifyCodeStyleType == .checkered else {
            return
        }
        for (index, indexFiled) in inputFields.enumerated() {
            if index == locationIndex {
                indexFiled.changeNumLabelBorderColor(color: color)
            } else {
                indexFiled.changeNumLabelBorderColor(color: UIColor.clear)
            }
        }
    }
}

// MARK: - 键盘显示隐藏
extension JKVerifyCodeView {
    
    @objc fileprivate func keyboardShow(note: Notification) {
        isInput = false
        textFiledDidChange(textFiled)
        isInput = true
    }
    
    @objc fileprivate func keyboardHidden(note: Notification) {
        allCursorHidden()
    }
}

// MARK: - UITextViewDelegate
extension JKVerifyCodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 输入框已有的值
        var inputText = textFiled.text ?? ""
        
        if string.count == 0 { // 删除
            if range.location != inputText.count - 1 { // 删除的不是最后一个
                if inputText.count > 0 {
                    // 手动删除最后一位
                    textFiled.text?.removeLast()
                    textFiledDidChange(textFiled)
                }
                return false
            }
        }
        
        if let tempRange = Range.init(range, in: inputText) {
            // 拼接输入后的值
            inputText = inputText.replacingCharacters(in: tempRange , with: string)
            let meetRegx = "[0-9]*"
            let characterSet = NSPredicate.init(format: "SELF MATCHES %@", meetRegx)
            if characterSet.evaluate(with: inputText) == false {
                return false
            }
        }
        
        if inputText.count > style.inputTextNum {
            return false
        }
        return true
    }
    
    @objc func textFiledDidChange(_ textFiled: UITextField) {
        let inputStr = textFiled.text ?? ""
        
        textValueChange?(inputStr)
        
        for i in 0..<codeViews.count {
            let codeView = codeViews[i]
            if i < inputStr.count {
                codeView.setNum(num: inputStr[String.Index(utf16Offset: i, in: inputStr)].description)
                codeView.setBottomLineFocus(isFocus: true)
                codeView.setCursorStatus(true)
            } else {
                if inputStr.count == 0, i == 0 {
                    codeView.setCursorStatus(false)
                    codeView.setBottomLineFocus(isFocus: true)
                    codeView.setNum(num: nil)
                } else {
                    codeView.setCursorStatus(i != inputStr.count)
                    codeView.setNum(num: nil)
                    codeView.setBottomLineFocus(isFocus: i == inputStr.count)
                }
            }
        }
        
        if isInput, inputStr.count >= style.inputTextNum {
            // 结束编辑
            if isAutoResignFirstResponder {
                // 隐藏键盘
                DispatchQueue.main.async {
                    textFiled.resignFirstResponder()
                }
            }
            allCursorHidden()
        }
    }
    
    @objc func textFiledDidEnd(_ textFiled: UITextField) {
        guard let inputStr = textFiled.text else { return }
        if isInput, inputStr.count >= style.inputTextNum {
            inputFinish?(inputStr)
        }
    }
}

