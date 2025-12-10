
# JKVerifyCodeView

[![CI Status](https://img.shields.io/travis/JoanKing/JKVerifyCodeView.svg?style=flat)](https://travis-ci.org/JoanKing/JKVerifyCodeView)
[![Version](https://img.shields.io/cocoapods/v/JKVerifyCodeView.svg?style=flat)](https://cocoapods.org/pods/JKVerifyCodeView)
[![License](https://img.shields.io/cocoapods/l/JKVerifyCodeView.svg?style=flat)](https://cocoapods.org/pods/JKVerifyCodeView)
[![Platform](https://img.shields.io/cocoapods/p/JKVerifyCodeView.svg?style=flat)](https://cocoapods.org/pods/JKVerifyCodeView)

## Requirements

    Swift5.0+

## Installation

JKVerifyCodeView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JKVerifyCodeView'
```

## 视图层级
  - 最底层一个隐藏的UITextView，上面铺的Label
  - 输入焦点在UITextView，监听UITextView的输入，给Label赋值
  - 通过Label显示输入的文字使用CAShapeLayer绘制光标
  - 通过光标的显示隐藏来控制光标的移动
  - 基础动画控制光标闪动
 
## 使用说明
![效果图](https://user-images.githubusercontent.com/19670000/120996449-e718bc80-c7b8-11eb-9e68-cb4657fa2567.gif)

   - 1、先定义一个 `JKVerifyCodeStyle`，设置整体的样式， 样式如下

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
    
   - 2、展示整个界面，监听输入的过程

    // 监听验证码输入的过程
    codeView.textValueChange = { str in
        print("输入中：\(str)")
    }
        
    // 监听验证码输入完成
    codeView.inputFinish = { str in
        print("输入完成：\(str)")
    }
   - 3、类型目前支持两种：下划线和方格
   
     ![下划线样式](https://user-images.githubusercontent.com/19670000/142150056-6271001d-a5e4-426a-8f5f-008d98bb9252.jpg)
     ![方格类型](https://user-images.githubusercontent.com/19670000/142150114-72b934f5-5627-4337-b1f5-628d59bb75ef.jpg)
     ![方格类型加密](https://user-images.githubusercontent.com/19670000/142155444-8fe70ab5-a429-48da-bcc7-8470b9176ba7.jpg)

## Author


JoanKing, jkironman@163.com

## License

JKVerifyCodeView is available under the MIT license. See the LICENSE file for more info.

## 版本记录
  - 0.1.8(2025.12.10)：增加在输入完成后是否自动收起键盘

    ```ruby
    /// 是否输入完自动隐藏键盘
    public var isAutoResignFirstResponder: Bool = true
    ```
  - 0.1.7(2025.10.23)：输入光标高度和宽度自定义
  - 0.1.6(2023.02.22)：支持输入框个数自定义
  - 0.1.2：新增方格类型的样式，支持数据是否加密
  - 0.1.0：支持下划线的样式
