//
//  ViewController.swift
//  LeftView
//
//  Created by study on 2017/6/30.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 声明一个动画实例
    let transition = FadeAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.delegate = self
        
        
        let btn = UIButton(type: .contactAdd)
        btn.frame = view.bounds
        btn.setTitle("跳转第二页", for: .normal)
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    func clickBtn(){
        let secod = SecondVC()
        
        /// 半透明效果
        self.modalPresentationStyle = .custom
        self.definesPresentationContext = true

        secod.view.backgroundColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
        /// 半透明效果
        secod.modalPresentationStyle = .overCurrentContext
        
        /// 转场动画的代理，在 A类中实现
        secod.transitioningDelegate = self
        /// 使用 present 进行跳转
        present(secod, animated: true, completion: nil)
        
        
//        self.navigationController?.pushViewController(secod, animated: true)
        //        presentDetailFromeLeftToRight(secod)

    }
}


extension ViewController: UIViewControllerTransitioningDelegate {
     // 提供弹出时的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.animationType = AnimationType.present
        return transition
    }
    
    // 提供消失时的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.animationType = AnimationType.dismiss
        return transition
    }
}


//extension ViewController: UINavigationControllerDelegate {
//
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//
//        if operation == UINavigationControllerOperation.push {
//            return transition
//        }else {
//            return nil
//        }
//    }
//}

