//
//  File.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 23/10/23.
//

import SwiftUI

extension UIImage {
    
    // Retorna uma UIImage com apenas uma cor do tamanho especificado.
    class func imageFromColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale: CGFloat) -> UIImage? {
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        
        let img = renderer.image { (ctx) in
            color.setFill()
            ctx.fill(CGRect(origin: CGPoint.zero, size: size))
        }
        
        return img
    }
}
