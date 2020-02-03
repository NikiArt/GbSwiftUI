//
//  RoundedView.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 09.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addImage()
    }
    
    func addImage() {
        image = UIImageView(frame: frame)
        addSubview(image)
    }
    
    override func layoutSubviews() {
        image.frame = bounds
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.backgroundColor = UIColor.clear.cgColor
        
        image.layer.cornerRadius = bounds.size.height/2
        image.layer.masksToBounds = true
    }
}
