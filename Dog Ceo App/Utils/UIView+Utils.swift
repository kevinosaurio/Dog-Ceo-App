//
//  UIView+Utils.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import Foundation
import UIKit

extension UIView {
    /// Add subview, with constraints to make frame equal to a referenceView.
        ///
        /// - Parameters:
        ///   - subView: The subView to add
        ///   - equalTo: The referenceView
        ///   - padding: Padding with referenceView. By default .zero
        func addSubView(_ subView: UIView, equalTo referenceView: UIView, padding: UIEdgeInsets = .zero) {
            self.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: subView,
                               attribute: NSLayoutConstraint.Attribute.bottom,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: referenceView,
                               attribute: NSLayoutConstraint.Attribute.bottom,
                               multiplier: 1,
                               constant: padding.bottom).isActive = true
            NSLayoutConstraint(item: subView,
                               attribute: NSLayoutConstraint.Attribute.top,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: referenceView,
                               attribute: NSLayoutConstraint.Attribute.top,
                               multiplier: 1,
                               constant: padding.top).isActive = true
            NSLayoutConstraint(item: subView,
                               attribute: NSLayoutConstraint.Attribute.left,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: referenceView,
                               attribute: NSLayoutConstraint.Attribute.left,
                               multiplier: 1,
                               constant: padding.left).isActive = true
            NSLayoutConstraint(item: subView,
                               attribute: NSLayoutConstraint.Attribute.right,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: referenceView,
                               attribute: NSLayoutConstraint.Attribute.right,
                               multiplier: 1,
                               constant: padding.right).isActive = true
        }
    
    func addSubViewWithEqualCenter(_ subView: UIView) {
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: centerYAnchor)
          ])
    }
}
