//
//  ViewController.swift
//  MultiplicationTable
//
//  Created by Brian Lim on 7/1/15.
//  Copyright (c) 2015 LimTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberLabel: UILabel!
    var numberBarView: UIView!
    var sliderBarView: UIView!
    var numberSlider: UISlider!
    var textView: UITextView!
    
    var number:Int = 10
    var minValue = 1
    var maxValue = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup UI in code
        createMultiplicationTableUI()
        
    }
    
    func createMultiplicationTableUI() {
        
        // Size information (Screen size)
        print("Bounds: \(UIScreen.mainScreen().bounds)")
        print("Scale: \(UIScreen.mainScreen().scale)")
        
        // Width
        // Height
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        // Text label
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        numberLabel.backgroundColor = UIColor(red: 50.0 / 255.0, green: 179.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.text = "\(number)"
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.font = UIFont.boldSystemFontOfSize(38)
        
        numberLabel.layer.cornerRadius = 15
        numberLabel.clipsToBounds = true
        
        // View behind text label
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        numberBarView = UIView(frame: CGRect(x: 0, y: statusBarHeight, width: screenWidth, height: 80))
        numberBarView.backgroundColor = UIColor.darkGrayColor()

        numberBarView.addSubview(numberLabel)
        
        numberLabel.center = CGPoint(x: numberBarView.bounds.size.width / 2, y: numberBarView.bounds.size.height / 2)

        // Slider view
        sliderBarView = UIView(frame: CGRect(x: 0, y:numberBarView.frame.origin.y + numberBarView.frame.height, width: screenWidth, height: 40))
        sliderBarView.backgroundColor = UIColor.lightGrayColor()
        
        let sliderBarEndY = sliderBarView.frame.origin.y
        let sliderBarStartY = sliderBarEndY - sliderBarView.frame.size.height
        sliderBarView.frame.origin.y = sliderBarStartY
        
        // Animate
        UIView.animateWithDuration(1.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            
            self.sliderBarView.frame.origin.y = sliderBarEndY
            
            }, completion: nil)
        
        view.addSubview(sliderBarView)
        view.addSubview(numberBarView) // Add on top of slider bar
        
        // UISlider
        numberSlider = UISlider(frame: sliderBarView.bounds)
        numberSlider.minimumValue = Float(minValue)
        numberSlider.maximumValue = Float(maxValue)
        numberSlider.value = Float(number)
        
        sliderBarView.addSubview(numberSlider)
        
        // Target action to connect the event
        numberSlider.addTarget(self, action: Selector("numberSliderChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Text view
        let textAreaY = sliderBarView.frame.origin.y + sliderBarView.frame.size.height
        let textAreaHeight = screenHeight - textAreaY
        
        textView = UITextView(frame: CGRect(x: 0, y: textAreaY , width: screenWidth, height: textAreaHeight))
        textView.text = "line 1 \nline 2"
        textView.font = UIFont.systemFontOfSize(20)
        textView.textAlignment = NSTextAlignment.Center
        textView.editable = false
        
        view.addSubview(textView)
        
        textView.text = generateMultiplicationTable(number)
    }
    
    func numberSliderChanged(slider: UISlider) {
        
        number = Int(slider.value)
        numberLabel.text = "\(number)"
        textView.text = generateMultiplicationTable(number)
    }
    
    func generateMultiplicationTable(value: Int) -> String {
        var output = ""
        
        for i in minValue...maxValue {
            
            output += "\(i) x \(value) = \(i * value)\n"
            
        }
        return output
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

