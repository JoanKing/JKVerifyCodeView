//
//  JKVerifyCodeStyle.swift
//  JKVerifyCodeView
//
//  Created by IronMan on 2021/6/7.
//

// MARK:- 验证码的配置
import Foundation

public class JKVerifyCodeStyle: NSObject {
    
    /// 输入框没有获取焦点的颜色
    public var lineViewNormalColor: UIColor = UIColor(hexString: "#EBEBEB")
    /// 输入框获取焦点的颜色
    public var lineViewFocusColor: UIColor = UIColor(hexString: "#999999")
    /// 光标的颜色
    public var cursorColor: UIColor = UIColor(hexString: "#FF4600")
    /// 每个验证码输入框间距
    public var spacing: CGFloat = 10
    /// 验证码输入框距离两边的边距
    public var padding: CGFloat = 0
    /// 验证码的字体
    public var numLabelFontSize: UIFont = UIFont.systemFont(ofSize: 28)
    /// 验证码的字体
    public var numLabelTextColor: UIColor = UIColor(hexString: "#333333")
}

// MARK:- UIColor的构造方法
extension UIColor {
    
    // MARK: 根据 RGBA 设置颜色颜色
    /// 根据 RGBA 设置颜色颜色
    /// - Parameters:
    ///   - r: red 颜色值
    ///   - g: green颜色值
    ///   - b: blue颜色值
    ///   - alpha: 透明度
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // MARK: 2.2、十六进制字符串创建的颜色
    /// 十六进制字符串创建的颜色
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16) / 255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8) / 255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0) / 255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        }
    }
}
