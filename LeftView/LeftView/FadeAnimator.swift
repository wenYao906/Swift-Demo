//
//  FadeAnimator.swift
//  LeftView
//
//  Created by study on 2017/6/30.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit


enum AnimationType {
    case present
    case dismiss
}

class FadeAnimator: NSObject , UIViewControllerAnimatedTransitioning {
    
    let duration = 1.5
    var animationType: AnimationType?
    
    
    // 指定转场动画持续的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let toView = toViewController?.view
        let fromView = fromViewController?.view
        
        let transitionTime = transitionDuration(using: transitionContext)
        let aDelay: TimeInterval = 0
        let aUsing: CGFloat = 0.5
        let aInitSprVel: CGFloat = 0
        
        if animationType == AnimationType.present {
            
            //snapshot方法是很高效的截屏

            // first 放下面
            let snap = fromView?.snapshotView(afterScreenUpdates: true)
            transitionContext.containerView.addSubview(snap!)
            
            //Third放上面
            let snap2 = toView?.snapshotView(afterScreenUpdates: true)
            transitionContext.containerView.addSubview(snap2!)
            
            snap2?.transform = CGAffineTransform(translationX: -320, y: 0)
            
            UIView.animate(withDuration: transitionTime, delay: aDelay, usingSpringWithDamping: aUsing, initialSpringVelocity: aInitSprVel, options: UIViewAnimationOptions.curveLinear, animations: {
                
                snap2?.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                
                // 删掉截图
                snap?.removeFromSuperview()
                snap2?.removeFromSuperview()
                
                // 添加视图
                transitionContext.containerView.addSubview(toView!)
                
                // 结束 Transition
                let aDidCom = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!aDidCom)
            })
        }
        else {
            // Third 放下面
            let snap = toView?.snapshotView(afterScreenUpdates: true)
            transitionContext.containerView.addSubview(snap!)
            
            // first 放上面
            let snap2 = fromView?.snapshotView(afterScreenUpdates: true)
            transitionContext.containerView.addSubview(snap2!)
            
            //进行动画
            UIView.animate(withDuration: transitionTime, delay: aDelay, usingSpringWithDamping: aUsing, initialSpringVelocity: aInitSprVel, options: UIViewAnimationOptions.curveLinear, animations: { 
                
                snap2?.transform = CGAffineTransform(translationX: -320, y: 0);

            }, completion: { (finished) in
                
                
                // 删掉截图
                snap?.removeFromSuperview()
                snap2?.removeFromSuperview()
                
                //添加视图
                transitionContext.containerView.addSubview(fromView!)
                
                //结束Transition
                let aDidCom = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!aDidCom)
                
            })
        }
    }
}
