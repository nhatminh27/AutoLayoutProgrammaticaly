//
//  UIView+Extension.swift
//  IFonePC-iOS
//
//  Created by HaoLe on 7/3/18.
//  Copyright © 2018 HaoLe. All rights reserved.
//

import UIKit

extension UIView {

    /*
    class func loadViewFromNib(_ nibName: String! = nil, bundle: Bundle! = nil) -> UIView! {
        var defaultNibName: String! = nil
        if nibName == nil {
            let fullClassName = NSStringFromClass(self)
            if let className = fullClassName.components(separatedBy: ".").last {
                defaultNibName = className
            }
        } else {
            defaultNibName = nibName
        }
        let nib = UINib(nibName: defaultNibName, bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    class func loadViewFromNib(_ nibName: String) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    */

    public class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }

    public class func fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let view: T? = fromNib(nibNameOrNil, type: T.self)
        return view!
    }

    public class func fromNib<T: UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for nibView in nibViews! {
            if let tog = nibView as? T {
                view = tog
            }
        }
        return view
    }

    public class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }

    public class var nib: UINib? {
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }

    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }

    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }

    func setBackgroundImage(_ imageName: String) {
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(named: imageName)?.draw(in: self.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.backgroundColor = UIColor(patternImage: image)
    }

}

internal extension UIView {

    class func viewFromNib() -> Self {
        return self.viewFromNib(withOwner: nil)
    }

    class func viewFromNib(withOwner owner: Any?) -> Self {
        let name = NSStringFromClass(self as AnyClass).components(separatedBy: ".").last!
        let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil).first!
        // assert((view is self), nil)
        return cast(view)!
    }

    func loadFromNibIfEmbeddedInDifferentNib() -> Self {
        // based on: http://blog.yangmeyer.de/blog/2012/07/09/an-update-on-nested-nib-loading
        let isJustAPlaceholder = self.subviews.count == 0
        if isJustAPlaceholder {
            let theRealThing = type(of: self).viewFromNib(withOwner: nil)
            theRealThing.frame = self.frame
            self.translatesAutoresizingMaskIntoConstraints = false
            theRealThing.translatesAutoresizingMaskIntoConstraints = false
            return theRealThing
        }
        return self
    }

}

private func cast<T, U>(_ value: T) -> U? {
    return value as? U
}

extension UIView {

    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}
