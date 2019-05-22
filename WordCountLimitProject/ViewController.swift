//
//  ViewController.swift
//  WordCountLimitProject
//
//  Created by zhifu360 on 2019/5/22.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    ///底部工具栏的高度
    let ToolBarH: CGFloat = 60
    
    ///创建UITextView
    lazy var textView: UITextView = {
        let tv = UITextView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: view.bounds.size.height - self.ToolBarH), textContainer: nil)
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = RandomColor
        tv.delegate = self
        tv.returnKeyType = UIReturnKeyType.done
        //自动判断有无输入文字
//        tv.enablesReturnKeyAutomatically = true
        return tv
    }()
    
    ///创建底部的工具栏
    lazy var toolBar: ToolBar = {
        let bar = ToolBar(frame: CGRect(x: 0, y: view.bounds.size.height-self.ToolBarH, width: ScreenSize.width, height: self.ToolBarH))
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setPage()
        addNotification()
    }

    func setPage() {
        title = "发微博"
        view.addSubview(textView)
        view.addSubview(toolBar)
    }
    
    func setNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendAction))
    }

    func addNotification() {
        //监听UITextView输入
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChangeText(_:)), name: UITextView.textDidChangeNotification, object: nil)
        //监听键盘弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        //监听键盘收起
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    @objc func textViewDidChangeText(_ noti: Notification) {
        //设置输入文字上限
        let Limit = 140
        if textView.text.count > 0 {
            let inputStr = textView.text.trimmingCharacters(in: .whitespaces)
            if inputStr.count <= 140 {
                //修改ToolBar的输入字数统计
                toolBar.limitLabel.text = "\(inputStr.count)"
                toolBar.limitLabel.textColor = UIColor.gray
            } else {
                //截取字符串
                let subStr = (inputStr as NSString).substring(to: Limit)
                textView.text = subStr
                toolBar.limitLabel.text = "\(Limit)"
                toolBar.limitLabel.textColor = UIColor.orange
            }
        }
    }
    
    @objc func keyboardWillShow(_ noti: Notification) {
        handleKeyboardStatus(noti: noti, isShow: true)
    }
    
    @objc func keyboardWillHide(_ noti: Notification) {
        handleKeyboardStatus(noti: noti, isShow: false)
    }
    
    func handleKeyboardStatus(noti: Notification, isShow: Bool) {
        guard let userInfo = noti.userInfo else { return }
        //获取键盘尺寸
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //获取动画时间
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        //执行动画
        UIView.animate(withDuration: duration) {
            self.toolBar.transform = isShow ? CGAffineTransform(translationX: 0, y: -keyboardFrame.size.height) : CGAffineTransform.identity
        }
    }
    
    @objc func sendAction() {
        //发送
        textView.resignFirstResponder()
        if textView.text.count > 0 {
            showAlertWith(message: textView.text)
        } else {
            showAlertWith(message: "发送内容不可为空")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
