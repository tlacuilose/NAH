//
//  Animations.swift
//  [NAH]
//
//  Implementacion recuperada de: https://www.andrewcbancroft.com/2014/09/24/slide-in-animation-in-swift/
//

import UIKit

extension UIView {
    
    func slideIn(_ fromSubtype: CATransitionSubtype, duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        let slideInFromLeftTransition = CATransition()
        
        if let delegate = completionDelegate as? CAAnimationDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = fromSubtype
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
}
