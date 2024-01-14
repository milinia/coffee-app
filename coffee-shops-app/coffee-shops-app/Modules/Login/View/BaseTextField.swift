//
//  BaseTextField.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import Foundation


import UIKit

class BaseTextField: UITextField {

    let inset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 10)
       
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
       
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
}
