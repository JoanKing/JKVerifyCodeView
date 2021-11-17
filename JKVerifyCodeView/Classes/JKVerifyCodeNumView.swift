//
//  JKVerifyCodeNumView.swift
//  JKVerifyCodeView
//
//  Created by IronMan on 2021/6/7.
//

import UIKit
import SnapKit

public class JKVerifyCodeNumView: UIView {
    /// 光标颜色
    private var cursorColor: UIColor {
        return style.cursorColor
    }
    
    /// 方格类型输入内容后的小圆点
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = style.circleViewColor
        view.layer.cornerRadius = style.circleViewDiameter / 2.0
        view.clipsToBounds = false
        return view
    }()
    
    /// 验证码
    fileprivate lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = style.numLabelTextColor
        if style.verifyCodeStyleType == .checkered {
            label.layer.borderColor = style.borderColor.cgColor
            label.layer.borderWidth = style.borderWidth
            label.font = style.secureTextEntry ? UIFont.systemFont(ofSize: 1) : style.numLabelFontSize
        } else {
            label.font = style.numLabelFontSize
        }
        return label
    }()
    
    fileprivate lazy var lineView: UIView = {
        let line = UIView()
        return line
    }()
    
    /// 光标
    lazy var cursor: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = cursorColor.cgColor
        shapeLayer.add(opacityAnimation, forKey: "kOpacityAnimation")
        return shapeLayer
    }()
    
    /// 闪烁动画
    fileprivate var opacityAnimation: CABasicAnimation = {
        let opacityAnimation = CABasicAnimation.init(keyPath: "opacity")
        // 属性初始值
        opacityAnimation.fromValue = 1.0
        // 属性要到达的值
        opacityAnimation.toValue = 0.0
        // 动画时间
        opacityAnimation.duration = 0.9
        // 重复次数(无穷大)
        opacityAnimation.repeatCount = HUGE
        /*
         removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
         */
        opacityAnimation.isRemovedOnCompletion = true
        // 决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后
        opacityAnimation.fillMode = .forwards
        // 速度控制函数，控制动画运行的节奏
        /*
         kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
         kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
         kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
         kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
         */
        opacityAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
        return opacityAnimation
    }()
    /// 样式
    fileprivate var style: JKVerifyCodeStyle = JKVerifyCodeStyle()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(style: JKVerifyCodeStyle = JKVerifyCodeStyle()) {
        self.init()
        self.style = style
        initUI()
        commonUI()
        updateTheme()
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enterBack), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    /// 创建控件
    private func initUI() {
        self.addSubview(numLabel)
        self.addSubview(lineView)
        self.layer.addSublayer(cursor)
    }
    
    /// 添加控件和设置约束
    private func commonUI() {
        // 1像素线的高度（为解决在Plus上标记为0.5时高度不一样的情况）
        let kPixel: CGFloat = (1.0 / UIScreen.main.scale)
        numLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kPixel)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(kPixel)
        }
        // 方各类型：添加隐藏圆点
        if style.verifyCodeStyleType == .checkered {
            // 方格，隐藏下划线
            lineView.isHidden = true
            if style.secureTextEntry {
                self.addSubview(circleView)
                circleView.snp.makeConstraints { make in
                    make.width.height.equalTo(style.circleViewDiameter)
                    make.center.equalToSuperview()
                }
                circleView.isHidden = true
            }
        }
    }
    
    /// 更新控件的颜色，字体，背景色等等
    private func updateTheme() {
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(rect: CGRect.init(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.1, width: 1, height: self.frame.size.height * 0.7))
        cursor.path = path.cgPath
    }
    
    /// 去后台
    @objc fileprivate func enterBack() {
        // 移除动画
        cursor.removeAnimation(forKey: "kOpacityAnimation")
    }
    
    /// 回前台
    @objc fileprivate func becomeActive() {
        // 重新添加动画
        cursor.add(opacityAnimation, forKey: "kOpacityAnimation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 供外部调用方法
public extension JKVerifyCodeNumView {
    
    // MARK: 设置光标是否隐藏
    /// 设置光标是否隐藏
    /// - Parameter isHidden: 是否隐藏
    func setCursorStatus(_ isHidden: Bool) {
        if isHidden {
            cursor.removeAnimation(forKey: "kOpacityAnimation")
        } else {
            cursor.add(opacityAnimation, forKey: "kOpacityAnimation")
        }
        UIView.animate(withDuration: 0.25) {
            self.cursor.isHidden = isHidden
        }
    }
    
    // MARK: 验证码赋值，并修改线条颜色
    /// 验证码赋值，并修改线条颜色
    /// - Parameter num: 验证码
    func setNum(num: String?) {
        numLabel.text = num
        
        guard style.verifyCodeStyleType == .checkered, style.secureTextEntry else { return }
        if let _ = num {
            circleView.isHidden = false
        } else {
            circleView.isHidden = true
        }
    }
    
    // MARK: 设置底部线条是否为焦点
    /// 设置底部线条是否为焦点
    /// - Parameter isFocus: 是否是焦点
    func setBottomLineFocus(isFocus: Bool) {
        if isFocus {
            lineView.backgroundColor = style.lineViewFocusColor
        } else {
            lineView.backgroundColor = style.lineViewNormalColor
        }
    }
    
    // MARK: 获取当前的验证码
    /// 获取当前的验证码
    /// - Returns: 验证码
    func getNum() -> String {
        return numLabel.text ?? ""
    }

    // MARK: 返回验证码值
    /// 返回验证码值
    /// - Returns:  验证码数值
    func getNum() -> String? {
        return numLabel.text
    }
}

