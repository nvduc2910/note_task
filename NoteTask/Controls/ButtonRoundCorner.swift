//
//  ButtonRoundCorner.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/21/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import UIKit

import UIKit
@IBDesignable
class ButtonRoundCorner: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
