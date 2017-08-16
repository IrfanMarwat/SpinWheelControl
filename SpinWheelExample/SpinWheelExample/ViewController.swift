//
//  ViewController.swift
//  SpinWheelExample
//
//  Created by Josh Henry on 5/17/17.
//  Copyright © 2017 Big Smash Software. All rights reserved.
//

import UIKit
import SpinWheelControl

class ViewController: UIViewController, SpinWheelControlDataSource, SpinWheelControlDelegate {
    
    var centerButton: UIButton!
    
    let colorPalette: [UIColor] = [UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.darkGray, UIColor.green, UIColor.magenta, UIColor.red, UIColor.orange, UIColor.black, UIColor.gray, UIColor.lightGray, UIColor.purple, UIColor.yellow, UIColor.white]

    
    func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge {
        let wedge = SpinWheelWedge()
        
        wedge.shape.fillColor = colorPalette[Int(index)].cgColor
        wedge.label.text = "Label #" + String(index)
        
        return wedge
    }

    var spinWheelControl:SpinWheelControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        spinWheelControl = SpinWheelControl(frame: frame)
        spinWheelControl.addTarget(self, action: #selector(spinWheelDidChangeValue), for: UIControlEvents.valueChanged)

        spinWheelControl.dataSource = self
        spinWheelControl.reloadData()
        
        spinWheelControl.delegate = self
        
        centerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        centerButton.backgroundColor = .groupTableViewBackground
        centerButton.center = spinWheelControl.center
        centerButton.setTitleColor(.black, for: .normal)
        
        centerButton.layer.cornerRadius = 40
        
        centerButton.addTarget(self, action:#selector(startSpinning), for: .touchUpInside)
        
        self.view.addSubview(spinWheelControl)
        spinWheelControl.addSubview(centerButton)
    }
    
    func startSpinning() {
        
        centerButton.isEnabled = false
        
        let _ = spinWheelControl.startSpinning()
        
        for i in 1..<10 {
            let tempRad = 0.1*CGFloat(i)
            let _ = spinWheelControl.continueTr(tempRad)
        }
        
        spinWheelControl.endTra()
    }
    
    
    func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt {
        return 6
    }
    
    
    //Target was added in viewDidLoad for the valueChanged UIControlEvent
    func spinWheelDidChangeValue(sender: AnyObject) {
        print("Value changed to " + String(self.spinWheelControl.selectedIndex))
    }
    
    
    func spinWheelDidEndDecelerating(spinWheel: SpinWheelControl) {
        print("The spin wheel did end decelerating.")
    }
    
    
    func spinWheelDidRotateByRadians(radians: Radians) {
        print("The wheel did rotate this many radians - " + String(describing: radians))
    }
}

