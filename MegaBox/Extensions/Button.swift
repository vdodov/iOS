//
//  Button.swift
//  MegaBox
//
//  Created by Fury on 19/07/2019.
//  Copyright © 2019 Fury. All rights reserved.
//

import UIKit

public extension UIButton {
  func touchUpButton(isTouched: Bool, width: CGFloat) {
    self.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    self.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    let border = CALayer()
    let width = UIScreen.main.bounds.width
    border.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.1215686275, blue: 0.5568627451, alpha: 1)
    if isTouched {
      border.frame = CGRect(x: 0, y: 37, width: width, height: 3)
      self.setTitleColor(#colorLiteral(red: 0.2392156863, green: 0.1215686275, blue: 0.5568627451, alpha: 1), for: .normal)
      self.layer.addSublayer(border)
    } else {
      border.frame = .zero
      self.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
  }
}
