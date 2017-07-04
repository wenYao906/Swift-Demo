//
//  WYExt_UIViewController.swift
//  LeftView
//
//  Created by study on 2017/6/30.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

extension UIViewController {
    /// 从左到右
    func presentDetailFromeLeftToRight(_ viewControllerToPresent: UIViewController) {
        let animation = CATransition()
        animation.duration = 0.5
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        
        self.view.window?.layer.add(animation, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    /// 从右到左
    func dismissDetailFromeRightToLeft(){
        let animation = CATransition()
        animation.duration = 0.5
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromRight
        self.view.window?.layer.add(animation, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }

}
