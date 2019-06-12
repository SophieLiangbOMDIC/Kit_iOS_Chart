//
//  ChartView.swift
//  Charts
//
//  Created by Sophie Liang on 2019/6/12.
//  Copyright © 2019 Sophie Liang. All rights reserved.
//

import UIKit

public class ChartView: UIView {
    
    enum Direction {
        case right, left
    }
    
    public var edge = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 60)
    public var chartBottom: CGFloat = 60.0
    public var labelColor: UIColor = .white
    public var labelSize: CGFloat = 10
    public var space: CGFloat = 10
    
    var rTopLabel: UILabel = UILabel()
    var rMidLabel: UILabel = UILabel()
    var rBottomLabel: UILabel = UILabel()
    
    var lTopLabel: UILabel = UILabel()
    var lBottomLabel: UILabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    func drawBorder() {
        
        let path = UIBezierPath()
        // 畫左邊的線
        path.move(to: CGPoint(x: edge.left, y: edge.top))
        path.addLine(to: CGPoint(x: edge.left, y: self.frame.height))
        
        // 畫右邊的線
        path.move(to: CGPoint(x: self.frame.width - edge.right, y: edge.top))
        path.addLine(to: CGPoint(x: self.frame.width - edge.right, y: self.frame.height - edge.bottom))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2).cgColor
        layer.addSublayer(shapeLayer)
    }
    
    func setLabels() {
        drawLabel(label: rTopLabel, rl: .right, y: edge.top - space)
        drawLabel(label: rMidLabel, rl: .right, y: (self.frame.height - chartBottom) / 2)
        drawLabel(label: rBottomLabel, rl: .right, y: self.frame.height - chartBottom)
        
        drawLabel(label: lTopLabel, rl: .left, y: edge.top - space)
        drawLabel(label: lBottomLabel, rl: .left, y: self.frame.height - chartBottom)
    }
    
    func drawLabel(label: UILabel, rl: Direction, y: CGFloat) {
        let x = (rl == .right) ? (self.frame.width - edge.right) : 5
        let width = (rl == .right) ? (edge.right - 5) : edge.left
        
        label.frame = CGRect(x: x, y: y - labelSize, width: width, height: 40)
        label.textColor = labelColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Avenir", size: labelSize)
        label.text = ""
        self.addSubview(label)
    }
    
    func drawLine(array: [Double], color: UIColor) {
        
        let minY = edge.top
        let maxY = self.frame.height - chartBottom
        let height = maxY - minY
        
        let maxData = array.max() ?? 0
        let minData = array.min() ?? 0

        // 每個點的x間距
        let disX = (self.frame.width - edge.left - edge.right) / CGFloat(array.count)
        
        let path = UIBezierPath()
        var minX: Double = 0
        
        for (index, item) in array.enumerated() {
            var y = Double(height) / (maxData - minData) * (maxData - item)
            var disY = CGFloat(y) - edge.top
        }
    }
    
}
