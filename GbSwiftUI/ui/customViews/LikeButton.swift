//
//  LikeButton.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 10.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    var liked = false {
        didSet {
            if liked {
                setLiked()
            } else {
                disableLike()
            }
        }
    }
    
    var likeCount = 0
    
    func setLiked() {
        likeCount += 1
        setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
    }
    
    func disableLike() {
        likeCount -= 1
        setImage(UIImage(named: "disLike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
    }
}
