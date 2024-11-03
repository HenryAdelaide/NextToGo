//
//  UIView+Extension.swift
//  NextToGo
//
//  Created by Henry Liu on 30/10/2024.
//

import Foundation
import UIKit

extension UIView {
    
    public static var associatedBundle: Bundle {
        Bundle(for: self.classForCoder())
    }
    
    public static func loadNibView(frame: CGRect? = nil) -> Self {
        let view = associatedBundle.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! Self
        if let frame {
            view.frame = frame
        }
        return view
    }
    
    public static var loadNib: UINib {
        let nib = UINib(nibName: String(describing: self), bundle: associatedBundle)
        return nib
    }
    
    public static var reuseId: String {
        return String(describing: self)
    }
    
}
