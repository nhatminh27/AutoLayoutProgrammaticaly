//
//  ViewController.swift
//  AutoLayoutProgrammaticaly
//
//  Created by HaoLe on 5/13/19.
//  Copyright © 2019 BTS. All rights reserved.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    var redView: UIView!
    var blueView: UIView!
    var expandButton: UIButton!
    var blueConstraintTop: NSLayoutConstraint!
    var greenView: UIView!
    var inputCustomView = InputView.fromNib()
    
    var didUpdateViewConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        redView = UIView()
        redView.backgroundColor = UIColor.red
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        
        blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueView)
        
        expandButton = UIButton()
        expandButton.backgroundColor = .gray
        expandButton.setTitleColor(.white, for: .normal)
        expandButton.setTitle("Expand", for: .normal)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.addTarget(self, action: #selector(self.expandButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(expandButton)
        
        greenView = UIView()
        greenView.backgroundColor = UIColor.green
        greenView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greenView)
        
        inputCustomView.translatesAutoresizingMaskIntoConstraints = false
        inputCustomView.layer.borderWidth = 1.0
        inputCustomView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(inputCustomView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func updateViewConstraints() {
        if !didUpdateViewConstraints {
            let redViewConstraints = [
                NSLayoutConstraint(item: redView!, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: redView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: redView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0),
                NSLayoutConstraint(item: redView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
            ]
            NSLayoutConstraint.activate(redViewConstraints)
            
            blueConstraintTop = NSLayoutConstraint(item: blueView!, attribute: .top, relatedBy: .equal, toItem: redView, attribute: .bottom, multiplier: 1.0, constant: 0)
            let blueViewConstraints = [
                blueConstraintTop!,
                NSLayoutConstraint(item: blueView!, attribute: .centerX, relatedBy: .equal, toItem: redView, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: blueView!, attribute: .width, relatedBy: .equal, toItem: redView, attribute: .width, multiplier: (1/2), constant: 0),
                NSLayoutConstraint(item: blueView!, attribute: .height, relatedBy: .equal, toItem: redView, attribute: .height, multiplier: (1/2), constant: 0)
            ]
            NSLayoutConstraint.activate(blueViewConstraints)
            
            let buttonConstraints = [
                NSLayoutConstraint(item: expandButton!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: expandButton!, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: expandButton!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: expandButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
            ]
            NSLayoutConstraint.activate(buttonConstraints)
            
            greenView.snp.makeConstraints { (make) in
                make.width.height.equalTo(100.0)
                make.top.equalTo(blueView!.snp.bottom).offset(30.0)
                make.centerX.equalTo(self.view.snp.centerX)
            }
            
            inputCustomView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.view)
                make.centerY.equalTo(self.view)
                make.left.equalTo(self.view.snp.left).offset(16.0)
                make.right.equalTo(self.view.snp.right).offset(-16.0)
            }
            didUpdateViewConstraints = true
        }
        super.updateViewConstraints()
    }
    
    @IBAction func expandButtonPressed(_ sender: Any) {
//        blueConstraintTop.constant = 30.0
//        UIView.animate(withDuration: 1.0) {
//            self.view.layoutIfNeeded()
//        }
        let controller = SecondViewController.init(nibName: "SecondViewController", bundle: nil)
//        self.navigationController?.show(controller, sender: nil)
        self.navigationController?.pushViewController(controller, animated: true)
//        self.present(controller, animated: true, completion: nil)
    }

}

