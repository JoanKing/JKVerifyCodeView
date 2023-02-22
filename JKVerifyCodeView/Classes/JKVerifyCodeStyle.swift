//
//  JKVerifyCodeStyle.swift
//  JKVerifyCodeView
//
//  Created by IronMan on 2021/6/7.
//

// MARK:- 验证码的配置
import Foundation

public enum JKVerifyCodeStyleType {
    /// 下划线
    case underscore
    /// 方格类型
    case checkered
}

@objcMembers public class JKVerifyCodeStyle: NSObject {
    //MARK: 😊通用设置
    /// 验证码样式，默认下划线(目前支持下滑线和方格类型)
    public var verifyCodeStyleType: JKVerifyCodeStyleType = .underscore
    /// 输入框的个数
    public var inputTextNum: Int = 6
    /// 光标的颜色
    public var cursorColor: UIColor = UIColor(hexString: "#FF4600")
    
    //MARK: 😊下划线类型的样式设置
    /// 下划线输入框没有获取焦点的颜色
    public var lineViewNormalColor: UIColor = UIColor(hexString: "#EBEBEB")
    /// 下划线输入框获取焦点的颜色
    public var lineViewFocusColor: UIColor = UIColor(hexString: "#999999")
    
    /// 每个验证码输入框间距
    public var spacing: CGFloat = 10
    /// 每个验证码输入框的是否是正方形
    public var isSquareBox: Bool = false
    /// 自定义盒子大小
    public var isCustomBoxSize: Bool = false
    /// 自定义盒子大小(只有上面生效的时候才生效)
    public var customBoxSize: CGSize = CGSize.zero
    /// 自定义盒子：圆角的大小
    public var customCornerRadius: CGFloat = 0
    /// 是否均分控件间距
    public var isEvenlySplit: Bool = false
    /// 验证码输入框距离两边的边距
    public var padding: CGFloat = 0
    /// 验证码的字体
    public var numLabelFontSize: UIFont = UIFont.systemFont(ofSize: 28)
    /// 验证码的字体颜色
    public var numLabelTextColor: UIColor = UIColor(hexString: "#333333")
    
    // MARK: 😊方格类型的样式设置
    /// 带边框的颜色
    public var borderColor: UIColor = UIColor(hexString: "#EBEBEB")
    /// 方格的背景色
    public var boxBackGroundColor: UIColor = UIColor.clear
    /// 带边框的验证码宽度
    public var borderWidth: CGFloat = (1.0 / UIScreen.main.scale)
    /// 方格类型的隐藏圆的直径
    public var circleViewDiameter: CGFloat = 8
    /// 方各类型的隐藏圆的颜色
    public var circleViewColor: UIColor = UIColor.black
    /// 是否安全的输入
    public var secureTextEntry: Bool = true
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
