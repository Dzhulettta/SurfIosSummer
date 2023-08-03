//
//  UILabelWithInsets.swift
//  SurfIosSummer
//
//  Created by Юлия Чужинова on 03.08.2023.
//

import UIKit

class UILabelWithInsets: UILabel {
    public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay() // вызывает drawText после установки отступов
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
