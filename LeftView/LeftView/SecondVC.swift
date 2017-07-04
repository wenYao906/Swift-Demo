//
//  SecondVC.swift
//  LeftView
//
//  Created by study on 2017/6/30.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

let screen_W = UIScreen.main.bounds.width
let screen_H = UIScreen.main.bounds.height

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.orange
        bgView.frame = CGRect(x: 0, y: 0, width: screen_W / 2, height: screen_H)
        self.view.addSubview(bgView)
        
        
        // 放在bgView 上
        let btn = UIButton(type: .contactAdd)
        
        let btnX:CGFloat = 20
        let btnW:CGFloat = bgView.frame.maxX - btnX * 2
        let btnH:CGFloat = 100
        let btnY:CGFloat = (screen_H - btnH) / 2
        btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        
        btn.setTitle("回到第一页", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        bgView.addSubview(btn)
    }
    
    func clickBtn(){
        dismiss(animated: true, completion: nil)
    }
}
