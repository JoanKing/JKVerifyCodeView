
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

## Author

JoanKing, chongwang27@creditease.cn

## License

JKVerifyCodeView is available under the MIT license. See the LICENSE file for more info.
