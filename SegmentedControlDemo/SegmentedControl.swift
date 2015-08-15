//
//  SegmentedControl.swift
//  SegmentedControlDemo
//
//  Created by 张青明 on 15/8/11.
//  Copyright (c) 2015年 极客栈. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedControl: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    
    private var labels = [UILabel]()
    
    var thumbView = UIView()
    
    var items:[String]  = ["Item 1", "Item 2", "Item 3"] {
        didSet {
            setupLabels()
        }
    }
    
    
    /// 当前选中的UILabel在labels的下标
    var selectedIndex:Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    func setupView() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor  = UIColor(white: 1.0, alpha: 0.5).CGColor
        layer.borderWidth  = 2
        
        backgroundColor    = UIColor.clearColor()
        setupLabels()
        
        // 把thumbView放到最底层
        insertSubview(thumbView, atIndex: 0)
    }
    
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepCapacity: true)
        
        for index in 0...items.count-1 {
            let label = UILabel(frame: CGRectZero)
            label.text = items[index]
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor(white: 0.5, alpha: 1.0)
            self.addSubview(label)
            self.labels.append(label)
        }
    }
    
    
    
    
    func displayNewSelectedIndex() {
        var label = labels[selectedIndex]
        thumbView.frame = label.frame
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        var selectFrame        = self.bounds
        let newWidth           = CGRectGetWidth(selectFrame) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        
        
        thumbView.frame              = selectFrame
        thumbView.backgroundColor    = UIColor.whiteColor()
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        
        let labelHeight = self.bounds.height
        let labelWidth  = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            let label     = labels[index]
            let xPosition = CGFloat(index) * labelWidth
            label.frame   = CGRectMake(xPosition, 0, labelWidth, labelHeight)
        }
        
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let location = touch.locationInView(self)
        var calculatedIndex:Int?
        
        // 遍历labels
        for (index, item) in enumerate(labels) {
            // 判断选中
            if item.frame.contains(location)
            {
                calculatedIndex = index
            }
            
        }
        
        if let calculatedTemp = calculatedIndex
        {
            selectedIndex = calculatedTemp
            sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
        
        return false
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
