//
//  ImageView+Extension.swift
//  MoviesApp
//
//  Created by Huzaifa Arshad on 07/02/2024.
//

import UIKit
import Kingfisher

extension Indicator {
    func setIndicatorColor(color: UIColor) {
        (self.view as? UIActivityIndicatorView)?.color = color
    }
}

extension UIImageView {
    func setImage(urlString: String?, placeholderImage: UIImage? = nil, downsamplingSize: CGSize? = nil, tintColor: UIColor? = nil) {
        var options: KingfisherOptionsInfo? = nil
        if let downsamplingSize = downsamplingSize {
            let processor = DownsamplingImageProcessor(size: downsamplingSize)
            options = [.processor(processor)]
        }
        self.tintColor = tintColor
        self.kf.setImage(
            with: URL(string: urlString ?? ""),
            placeholder: placeholderImage,
            options: options
        )
        
    }
}

