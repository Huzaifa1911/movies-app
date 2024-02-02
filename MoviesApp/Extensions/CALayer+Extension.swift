//
//  CALayer+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 01/02/2024.
//

import UIKit

extension CALayer {
    
    func addBorder(edge: UIRectEdge, thickness: CGFloat, color: UIColor?) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            
        case .bottom:
            border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height: thickness)
            
        case .left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)
            
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            
        default:
            break
        }
        
        guard let borderColor = color?.cgColor else { return }
        border.backgroundColor = borderColor
        
        addSublayer(border)
    }
}
