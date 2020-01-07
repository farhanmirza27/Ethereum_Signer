//
//  UIComponents.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 05/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class UIComponents {
    static let shared = UIComponents()
    
    // MARK: App Colors
    
    
    // MARK: UITextField
    func textField(placeHolder : String = "", addShadow : Bool = true) -> UITextField {
        let textField = UITextField()
        textField.placeholder =  placeHolder
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor  = .white
        textField.returnKeyType = .done
        if addShadow {
        textField.addShadow()
        }
        return textField
    }
    
    
    // MARK: UIButton
    func button(text: String? = nil, backgroundColor : UIColor = UIColor.AppColor.defaultBlue, titleColor : UIColor = .white) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont(name: FontName.Medium, size: 16)
        button.layer.cornerRadius = 10
        return button
    }
    
    // MARK: UILabel
    func label(text: String? = nil, alignment: NSTextAlignment = .left, color: UIColor = UIColor.black, fontName : String = FontName.Regular ,fontSize : CGFloat = 14) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.font = UIFont(name: fontName, size: fontSize)
        return label
    }
    
    func labelSecondary(text: String? = nil, alignment: NSTextAlignment = .left, color: UIColor = UIColor(r: 168, g: 168, b: 168),fontSize : CGFloat = 14) -> UILabel {
        return label(text:text, alignment: alignment, color:color,fontSize: fontSize)
    }
    
    
    // MARK: UIView
    func container(bgColor : UIColor = .white, cornerRadius : CGFloat = 0, addShadow : Bool = false) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        view.layer.cornerRadius = cornerRadius
        if addShadow {
            view.addShadow()
        }
        
        return view
    }
    
    
    // MARK: UIImageView
    func imageView(imageName : String = "", contentMode : UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = contentMode
        return imageView
    }
    
}
