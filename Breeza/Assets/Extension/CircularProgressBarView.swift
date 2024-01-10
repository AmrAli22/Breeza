//
//  CircularProgressBarView.swift
//  iDriver App
//
//  Created by Hesham Donia on 29/05/2021.
//

import UIKit

class CircularProgressBarView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       makeCircularPath()
    }
    
    var progressLyr = CAShapeLayer()
    var trackLyr = CAShapeLayer()
    var progressClr = UIColor.white {
       didSet {
          progressLyr.strokeColor = progressClr.cgColor
       }
    }
    var trackClr = UIColor.white {
       didSet {
          trackLyr.strokeColor = trackClr.cgColor
       }
    }
    
    var backgroundClr = UIColor.white {
       didSet {
          backgroundColor = backgroundClr
       }
    }
    
    func makeCircularPath() {
       self.backgroundColor = UIColor.clear
       self.layer.cornerRadius = self.frame.size.width/2
       let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
       trackLyr.path = circlePath.cgPath
       trackLyr.fillColor = UIColor.clear.cgColor
       trackLyr.strokeColor = trackClr.cgColor
       trackLyr.lineWidth = 5.0
       trackLyr.strokeEnd = 1.0
       layer.addSublayer(trackLyr)
       progressLyr.path = circlePath.cgPath
       progressLyr.fillColor = UIColor.clear.cgColor
       progressLyr.strokeColor = progressClr.cgColor
       progressLyr.lineWidth = 5.0
       progressLyr.strokeEnd = 0.0
       layer.addSublayer(progressLyr)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
       let animation = CABasicAnimation(keyPath: "strokeEnd")
       animation.duration = duration
       animation.fromValue = 0
       animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
       progressLyr.strokeEnd = CGFloat(value)
       progressLyr.add(animation, forKey: "animateprogress")
    }


}
