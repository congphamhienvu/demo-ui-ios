//
//  MRActivitiIndicator.swift
//  ui-kit-demo
//
//  Created by Phạm Công on 12/09/2023.
//

import UIKit

public class MRActivityIndicator: UIView {
    public static var shared = MRActivityIndicator()
    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    private var spinnerBehavior: UIDynamicItemBehavior?
    private var animator: UIDynamicAnimator?
    private var imageView: UIImageView?
    private var centerImageView: UIImageView?
    private var titleLabel: UILabel?
    private var viewBlur: UIView?
    private var loaderImageName = ""
    private var title: String = ""
    private var timeOut: Double?
    private var colorBlur: UIColor?
        
    public func show(with image: String = "elipse_animation", title: String = "", timeOut: Double? = nil, colorBlur: UIColor? = .black.withAlphaComponent(0.8)) {
        loaderImageName = image
        self.title = title
        self.timeOut = timeOut
        self.colorBlur = colorBlur
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            if self?.imageView == nil {
                self?.setupView()
                DispatchQueue.main.async {[weak self] in
                    self?.showLoadingActivity()
                    if let timeOut = self?.timeOut {
                        let _ = Timer.scheduledTimer(withTimeInterval: timeOut, repeats: false) { timer in
                            self?.hide()
                        }
                    }
                    
                }
            }
        }
    }
    
    public func hide() {
        DispatchQueue.main.async {[weak self] in
            self?.stopAnimation()
        }
    }
    
    private func setupView() {
        center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        let theImage = UIImage(named: loaderImageName)
        imageView = UIImageView(image: theImage)
        imageView?.frame = CGRect(x: self.center.x - 34, y: self.center.y - 34, width: 68, height: 68)
        
        let centerImage = UIImage(named: "ocb-coin-logo")
        
        centerImageView = UIImageView(image: centerImage)
        centerImageView?.frame = CGRect(x: self.center.x - 14, y: self.center.y - 14, width: 28, height: 28)
        var itemms: [UIDynamicItem] = []
        if let imageView = imageView {
            itemms.append(imageView)
            
        }
        
        if let centerImageView = self.centerImageView {
            itemms.append(centerImageView)
        }
        
        self.spinnerBehavior = UIDynamicItemBehavior(items: itemms)
        animator = UIDynamicAnimator(referenceView: self)
        titleLabel = UILabel()
        titleLabel?.text = self.title
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel?.textColor = .white
        
        viewBlur = UIView(frame: UIScreen.main.bounds)
        viewBlur?.backgroundColor = colorBlur
    }
    
    private func showLoadingActivity() {
        if let imageView = imageView, let centerImageView = self.centerImageView, let titleLabel = self.titleLabel {
            addSubview(imageView)
            addSubview(centerImageView)
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
            ])
            startAnimation()
            UIApplication.shared.windows.first?.addSubview(self)
            UIApplication.shared.beginIgnoringInteractionEvents()
            if let viewBlur = self.viewBlur {
                addSubview(viewBlur)
                sendSubviewToBack(viewBlur)
            }
        }
    }
    
    private func startAnimation() {
        guard let imageView = imageView,
              let spinnerBehavior = spinnerBehavior,
              let animator = animator else { return }
        if !animator.behaviors.contains(spinnerBehavior) {
            spinnerBehavior.allowsRotation = true
            spinnerBehavior.angularResistance = 0
            spinnerBehavior.addAngularVelocity(10.0, for: imageView)
            animator.addBehavior(spinnerBehavior)
        }
        
    }
    
    private func stopAnimation() {
        animator?.removeAllBehaviors()
        imageView?.removeFromSuperview()
        centerImageView?.removeFromSuperview()
        titleLabel?.removeFromSuperview()
        viewBlur?.removeFromSuperview()
        imageView = nil
        centerImageView = nil
        titleLabel = nil
        viewBlur = nil
        self.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
