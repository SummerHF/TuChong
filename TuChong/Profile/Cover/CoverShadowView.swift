//  CoverShadowView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/7.
//
//
//  Copyright (c) 2019 SummerHF(https://github.com/summerhf)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
