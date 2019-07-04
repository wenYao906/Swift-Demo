//
//  WYViewStayleValue1.swift
//  WYWeather
//
//  Created by study on 2019/7/1.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit

/// 左侧图片，右侧 上 主标题，右侧下 副标题
///
/// - Parameters:
///   - frame: frame 值
///   - image: 图片
///   - mainTitle: 主标题
///   - subTitle: 副标题
class WYViewStayleValue1: UIView {

    /// 左侧图片
    private let img = UIImageView()
    /// 右侧 主标题
    private let mtemp = UILabel()
    /// 右侧 副标题
    private let sTemp = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// 左侧图片
        let aIY:CGFloat = (frame.height - 18) / 2
        img.frame = CGRect(x: 0, y: aIY, width: 8, height: 18)
        
        /// 右侧 主标题
        let amTX: CGFloat = img.frame.maxX + 10
        print("frame.width = \(frame.width)")
        let amTW: CGFloat = frame.width - img.frame.width - 5
        mtemp.frame = CGRect(x: amTX, y: 0, width: amTW, height: 15)
        
        /// 右侧 副标题
        let aSTY: CGFloat = mtemp.frame.maxY + 5
        sTemp.frame = CGRect(x: amTX, y: aSTY, width: amTW, height: 15)
    }
}

// MARK:- 外界传值
extension WYViewStayleValue1 {
    public func setImage(image: String) {
        img.image = UIImage(named: image)
    }
    
    public func setMainTitle(title: String) {
        mtemp.text = title
    }
    
    public func setSubTitle(title: String) {
        sTemp.text = title
    }
}

extension WYViewStayleValue1 {
    /// 左侧图片，右侧 上 主标题，右侧下 副标题
    ///
    /// - Parameters:
    ///   - frame: frame 值
    ///   - image: 图片
    ///   - mainTitle: 主标题
    ///   - subTitle: 副标题
    private func setupUIView() {
        
        /// 左侧图片
        self.addSubview(img)
        
        
        /// 右侧 主标题
        mtemp.textColor = aTextColor
        mtemp.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(mtemp)
        
       
        /// 右侧 副标题
        
        sTemp.textColor = aTextColor
        sTemp.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(sTemp)
        
    }
}

extension WYViewStayleValue1 {
    
}
