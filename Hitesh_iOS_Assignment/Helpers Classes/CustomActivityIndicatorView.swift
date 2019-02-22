//
//  CustomActivityIndicatorView.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 21/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit
import QuartzCore

class CustomActivityIndicatorView: UIView {
    
    // MARK: - @vars
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    lazy private var animationLayer : CALayer = {
        return CALayer()
    }()
    
    // MARK: - @init
    init(image : UIImage) {
        let frame : CGRect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        super.init(frame: frame)
        animationLayer.frame = frame
        animationLayer.contents = image.cgImage
        animationLayer.masksToBounds = true
        self.layer.addSublayer(animationLayer)
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        self.isHidden = true
        self.backgroundColor = UIColor(red: 65/255, green: 175/255, blue: 93/255, alpha: 0.7)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom methods
    /*
     Custom methods for anication and rolation of custom activitiy controller view
     */
    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: 3.14 * 2.0)
        layer.add(rotation, forKey: "rotate")
    }
    
    private func pause(layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        isAnimating = false
    }
    
    private func resume(layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isAnimating = true
    }
    
    // MARK: - Custom methos
    /*
     This will start custom activity indicator animation
     */
    func startAnimating () { // show
        if isAnimating {
            return
        }
        if hidesWhenStopped {
            self.isHidden = false
        }
        resume(layer: animationLayer)
    }
    
    /*
     This will stop custom activity indicator animation
     */
    func stopAnimating () { // stop
        if hidesWhenStopped {
            self.isHidden = true
        }
        pause(layer: animationLayer)
    }
}
