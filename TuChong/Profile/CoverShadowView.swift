//
//  CoverShadowView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/7.
//  Copyright © 2019 Summer. All rights reserved.
//

import UIKit

class CoverShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGradientLayer()
    }
    
    private func addGradientLayer() {
        let alpha: CGFloat = 0.1
        let color_one = RGBA(R: 179, G: 179, B: 179, A: alpha).cgColor
        let color_two = RGBA(R: 189, G: 189, B: 189, A: alpha).cgColor
        let color_three = RGBA(R: 201, G: 201, B: 201, A: alpha).cgColor
        let color_four = RGBA(R: 211, G: 211, B: 211, A: alpha).cgColor
        let color_five = RGBA(R: 243, G: 243, B: 243, A: alpha).cgColor
        let color_six = Color.flatWhite.cgColor
        /// layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [color_one, color_two, color_three, color_four, color_five, color_six]
        gradientLayer.locations = [0, 0.1, 0.3, 0.6, 0.7, 1.0]
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
