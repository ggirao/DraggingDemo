//
//  ViewController.swift
//  Dragging Demo
//
//  Created by Gonçalo Girão on 31/01/2017.
//  Copyright © 2017 Gonçalo Girão. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
        
        label.text = "Drag me!"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.wasDragged(_:)))
        label.addGestureRecognizer(gesture)
        
        label.isUserInteractionEnabled = true
        
    }
    
    func wasDragged(_ gesture: UIPanGestureRecognizer!) {
        
        let translation = gesture.translation(in: self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        var stretchAndRotate = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotate
        if gesture.state == UIGestureRecognizerState.ended {
            
            if label.center.x < 100 {
                print(("Not chosen"))
            } else if label.center.x > self.view.bounds.width - 100 {
                print("Chosen")
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotate = rotation.scaledBy(x: 1, y: 1)
            
            label.transform = stretchAndRotate
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

