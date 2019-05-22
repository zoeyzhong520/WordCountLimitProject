//
//  UIViewController+Alert.swift
//  MapKitProject
//
//  Created by zhifu360 on 2019/4/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    ///提示弹框
    func showAlertWith(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "关闭", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
