//
//  WYViewStayValue2.swift
//  WYWeather
//
//  Created by study on 2019/7/3.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit

/// 左侧图片 右侧文字
class WYViewStayValue2: UIView {
    
    /// 图片
    private let img = UIImageView()
    /// 文字
    private let temp = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTempView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WYViewStayValue2 {
    /// 图片赋值
    public func setImage(image: String) {
        self.img.image = UIImage(named: image)
    }
    
    /// 文字赋值
    public func setTemp(text: String) {
        temp.text = text
    }
}

extension WYViewStayValue2 {
    /// 左侧图片 右侧文字
    ///
    /// - Parameters:
    ///   - frame: frame 值
    ///   - imageString: 图片
    ///   - textString: 温度值
    private func setTempView(){
        
        img.frame = CGRect(x: 0, y: 0, width: 8, height: 16)
        self.addSubview(img)
        

        let aTX: CGFloat = img.frame.maxX + 10
        let aTW: CGFloat = 60
        temp.frame = CGRect(x: aTX, y: 0, width: aTW, height: 16)
        temp.textColor = aTextColor
        temp.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(temp)
    }
}
