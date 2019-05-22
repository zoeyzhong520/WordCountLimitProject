//
//  ToolBar.swift
//  WordCountLimitProject
//
//  Created by zhifu360 on 2019/5/22.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ToolBar: UIView {
    
    ///创建工具栏
    lazy var toolBar: UIView = {
        let bar = UIView(frame: CGRect(x: 0, y: self.limitLabel.frame.height, width: self.bounds.size.width, height: self.bounds.size.height-self.limitLabel.frame.height))
        bar.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        return bar
    }()
    
    ///创建字数显示文本
    lazy var limitLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.bounds.size.width-100-10, y: 0, width: 100, height: 14))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(limitLabel)
        addSubview(toolBar)
    }

}
