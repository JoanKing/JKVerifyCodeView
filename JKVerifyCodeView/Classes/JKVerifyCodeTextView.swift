//
//  JKVerifyCodeTextView.swift
//  JKVerifyCodeView
//
//  Created by IronMan on 2021/6/7.
//

import Foundation

public typealias JKVerifyCodeTextViewClosure = (_ isTrigger: Bool) -> Bool

public class JKVerifyCodeTextView: UITextField {
    
    /// 是否隐藏所有菜单
    var isHiddenAllMenu = false
    
    /// 粘贴 - 会调用两次此闭包  当isTrigger = true的时候才为实际粘贴
    var pasteClouruse: JKVerifyCodeTextViewClosure?
    
    /// 选择 - 会调用两次此闭包  当isTrigger = true的时候才为实际选择
    var selectClouruse: JKVerifyCodeTextViewClosure?
    
    /// 选择全部 - 会调用两次此闭包  当isTrigger = true的时候才为实际选择全部
    var selectAllClouruse: JKVerifyCodeTextViewClosure?
    
    /// 复制 - 会调用两次此闭包  当isTrigger = true的时候才为实际复制
    var copyClouruse: JKVerifyCodeTextViewClosure?
    
    /// 剪切 - 会调用两次此闭包  当isTrigger = true的时候才为实际剪切
    var cutClouruse: JKVerifyCodeTextViewClosure?
    
    /// 删除 - 会调用两次此闭包  当isTrigger = true的时候才为实际删除
    var deleteClouruse: JKVerifyCodeTextViewClosure?
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if isHiddenAllMenu {
            UIMenuController.shared.isMenuVisible = false
            return false
        }
        
        // 菜单是否隐藏
        var isTrigger = false
        
        if let vc = sender as? UIMenuController {
            isTrigger = vc.isMenuVisible
        }
        
        switch action {
        case #selector(UIResponderStandardEditActions.paste(_:)):
            if let pasteClouruse = pasteClouruse {
                return pasteClouruse(isTrigger)
            } else {
                return super.canPerformAction(action, withSender: sender)
            }
        case #selector(UIResponderStandardEditActions.select(_:)):
            if let selectClouruse = selectClouruse {
                return selectClouruse(isTrigger)
            } else {
                return super.canPerformAction(action, withSender: sender)
            }
        case #selector(UIResponderStandardEditActions.selectAll(_:)):
            if let selectAllClouruse = selectAllClouruse {
                return selectAllClouruse(isTrigger)
            } else {
                return super.canPerformAction(action, withSender: sender)
            }
        case #selector(UIResponderStandardEditActions.copy(_:)):
            if let copyClouruse = copyClouruse {
                return copyClouruse(isTrigger)
            } else {
                return super.canPerformAction(action, withSender: sender)
            }
        case #selector(UIResponderStandardEditActions.cut(_:)):
            if let cutClouruse = cutClouruse {
                return cutClouruse(isTrigger)
            } else {
                return super.canPerformAction(action, withSender: sender)
            }
        case #selector(UIResponderStandardEditActions.delete(_:)):
            if let deleteClouruse = deleteClouruse {
                return deleteClouruse(isTrigger)
            } else {
                return super.canPerformAction(action, withSender: sender)
            }
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
}

