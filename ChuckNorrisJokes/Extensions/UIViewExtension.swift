//
//  UIViewExtension.swift
//  ChuckNorrisJokes
//
//  Created by Apple on 07/05/2018.
//  Copyright © 2018 Apple. All rights reserved.
//


import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.lightGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 0.5),
                   shadowOpacity: Float = 0.6,
                   shadowRadius: CGFloat = 1) {
        
       
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}
