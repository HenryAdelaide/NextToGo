//
//  UIView+Extension.swift
//  NextToGo
//
//  Created by Henry Liu on 30/10/2024.
//

import Foundation
import UIKit

/// Extension tools which can improve simplicity and reduce dumplicate work
extension UIView {
    
    /// Associated Bundle
    public static var associatedBundle: Bundle {
        Bundle(for: self.classForCoder())
    }
    
    
    /// Load Nib/Xib from Bundle into UIView
    /// - Parameter frame: frame you need to use
    /// - Returns: Loaded UIView from Nib/Xib
    public static func loadNibView(frame: CGRect? = nil) -> Self {
        let view = associatedBundle.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! Self
        if let frame {
            view.frame = frame
        }
        return view
    }
    
    /// Convenience to create UINib
    public static var loadNib: UINib {
        let nib = UINib(nibName: String(describing: self), bundle: associatedBundle)
        return nib
    }
    
    /**
        Identifier when register
        e.g UITableView.register
     */
    public static var reuseId: String {
        return String(describing: self)
    }
    
}
