//
//  ViewController.swift
//  CABasicAnimation
//
//  Created by mac on 7/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var exampleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        view.frame = CGRect(x: 0, y: self.view.center.y - 60, width: 100, height: 100)
        return view
    }()
    
    lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.frame = CGRect(x: view.center.x - 50, y: view.center.y - 80, width: 100, height: 60)
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .blue
        startButton.addTarget(self, action: #selector(startAnimating), for: .touchUpInside)
        return startButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(exampleView)
        view.addSubview(startButton)
        
        print("model layer \(exampleView.layer.model())")
        print("presentation layer \(String(describing: exampleView.layer.presentation()))")
    }
    
    @objc func startAnimating() {
        let basicanimation = CABasicAnimation(keyPath: "position.x")
        
        basicanimation.fromValue = exampleView.frame.width / 2
        
        basicanimation.toValue = 250.0
        
        basicanimation.duration = 1.0
        
        basicanimation.beginTime = CACurrentMediaTime() + 2.0
        
        basicanimation.delegate = self
        
        
        
        exampleView.layer.add(basicanimation, forKey: nil)
    }
    
    /*
     @objc func startAnimating() {
             // 创建一个 CABasicAnimation 对象用于位置变化
             let moveAnimation = CABasicAnimation(keyPath: "position")
             moveAnimation.fromValue = NSValue(cgPoint: CGPoint(x: 50, y: 100))
             moveAnimation.toValue = NSValue(cgPoint: CGPoint(x: 250, y: 100))
             moveAnimation.duration = 1.0
             
             // 创建另一个 CABasicAnimation 对象用于透明度变化
             let opacityAnimation = CABasicAnimation(keyPath: "opacity")
             opacityAnimation.fromValue = 1.0
             opacityAnimation.toValue = 0.2
             opacityAnimation.duration = 1.0
             
             // 创建旋转动画
             let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
             rotateAnimation.fromValue = 0
             rotateAnimation.toValue = CGFloat(Double.pi) // 旋转180度
             rotateAnimation.duration = 1.0
             
             // 创建一个动画组，组合多个动画
             let animationGroup = CAAnimationGroup()
             animationGroup.animations = [moveAnimation, opacityAnimation, rotateAnimation]
             animationGroup.duration = 1.0
             animationGroup.fillMode = .forwards
             animationGroup.isRemovedOnCompletion = false
             
             // 将动画组添加到 exampleView 的层
             exampleView.layer.add(animationGroup, forKey: "multiAnimation")
         }
     
     
     exampleView.layer.removeAnimation(forKey: "basicAnimation")
     */


}

extension ViewController: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        
        exampleView.layer.position.x = 250.0
        print("Start")
        print("model layer \(exampleView.layer.model())")
        print("presentation layer \(String(describing: exampleView.layer.presentation()))")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        print("Stop")
        print("model layer \(exampleView.layer.model())")
        print("presentation layer \(String(describing: exampleView.layer.presentation()))")
    }
}

