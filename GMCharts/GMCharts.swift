//
//  GMCharts.swift
//  GMCharts
//
//  Created by Sophie Liang on 2019/6/13.
//  Copyright © 2019 Sophie Liang. All rights reserved.
//

import UIKit

public class GMCharts: UIView {
    
    enum Direction {
        case right, left
    }
    
    public enum Unit: String {
        case km, mile
    }
    
    public var edge = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 60)
    public var chartBottom: CGFloat = 60.0
    public var labelColor: UIColor = .white
    public var labelSize: CGFloat = 10
    public var space: CGFloat = 10
    
    private var rTopLabel: UILabel = UILabel()
    private var rMidLabel: UILabel = UILabel()
    private var rBottomLabel: UILabel = UILabel()
    
    private var lTopLabel: UILabel = UILabel()
    private var lBottomLabel: UILabel = UILabel()
    
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    private var chartMinX: CGFloat = 0
    private var chartMaxX: CGFloat = 0
    private var chartMinY: CGFloat = 0
    private var chartMaxY: CGFloat = 0
    private var chartHeight: CGFloat = 0
    private var chartWidth: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    public func redraw() {
        width = frame.width
        height = frame.height
        chartMinX = edge.left
        chartMaxX = width - edge.right
        chartMinY = edge.top
        chartMaxY = height - edge.bottom - chartBottom
        chartHeight = chartMaxY - chartMinY
        chartWidth = chartMaxX - chartMinX
        
        drawBorder()
    }
    
    func drawBorder() {
        
        let path = UIBezierPath()
        // 畫左邊的線
        path.move(to: CGPoint(x: chartMinX, y: chartMinY))
        path.addLine(to: CGPoint(x: chartMinX, y: chartMaxY))
        
        // 畫右邊的線
        path.move(to: CGPoint(x: chartMaxX, y: chartMinY))
        path.addLine(to: CGPoint(x: chartMaxX, y: chartMaxY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2).cgColor
        layer.addSublayer(shapeLayer)
        
    }
    
    func setLabels() {
        drawLabel(label: rTopLabel, rl: .right, y: chartMinY - space)
        drawLabel(label: rMidLabel, rl: .right, y: (height - chartBottom) / 2)
        drawLabel(label: rBottomLabel, rl: .right, y: height - chartBottom)
        
        drawLabel(label: lTopLabel, rl: .left, y: chartMinY - space)
        drawLabel(label: lBottomLabel, rl: .left, y: height - chartBottom)
    }
    
    func drawLabel(label: UILabel, rl: Direction, y: CGFloat) {
        let x = (rl == .right) ? chartMaxX : 5
        let width = (rl == .right) ? (chartMaxX - 5) : chartMinX
        
        label.frame = CGRect(x: x, y: y - labelSize, width: width, height: 40)
        label.textColor = labelColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Avenir", size: labelSize)
        label.text = ""
        self.addSubview(label)
    }
    
    public func drawLine(array: [Double], color: UIColor, isFilled: Bool = false) {
        
        let maxData = array.max() ?? 0
        let minData = array.min() ?? 0
        
        // 每個點的x間距
        let disX = chartWidth / CGFloat(array.count)
        
        let path = UIBezierPath()
        var startY: CGFloat = 0
        
        for (index, item) in array.enumerated() {
            let a = Double(chartHeight) / (maxData - minData) * (maxData - item)
            let y = CGFloat(a) + edge.top
            
            var x: CGFloat = 0
            if index == 0 {
                startY = y
                x = chartMinX
                path.move(to: CGPoint(x: x, y: y))
                
            } else if index == array.count - 1 {
                x = chartMaxX
                path.addLine(to: CGPoint(x: x, y: y))
                
            } else {
                x = chartMinX + disX * CGFloat(index)
                path.addLine(to: CGPoint(x: x, y: y))
                
            }
        }
        
        if isFilled {
            path.addLine(to: CGPoint(x: chartMaxX, y: chartMaxY))
            path.addLine(to: CGPoint(x: chartMinX, y: chartMaxY))
            path.addLine(to: CGPoint(x: chartMinX, y: startY))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = isFilled ? color.cgColor : nil
        
        layer.addSublayer(shapeLayer)
    }
    
    public func drawSeparators(distance: Int, array: [Double], unit: Unit) {
        
        //每個點的x間距
        let disX = chartWidth / CGFloat(array.count)
        
        for (index, item) in array.enumerated() {
            let x = edge.left + disX * CGFloat(index) - 10
            
            if index == 0 {
                drawBottomLabel(text: "", x: x, width: 20)
            } else if index == array.count - 1 {
                drawBottomLabel(text: String(format: "%.2f %@", item, unit.rawValue), x: x, width: 50)
            } else {
                //如果很靠近右邊就不要畫
                if (x) < chartMaxX - 30 {
                    let path = UIBezierPath()
                    path.move(to: CGPoint(x: x + 10, y: chartMinY))
                    path.addLine(to: CGPoint(x: x + 10, y: height - edge.bottom))
                    
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path = path.cgPath
                    shapeLayer.lineWidth = 1.0
                    shapeLayer.strokeColor = labelColor.cgColor
                    layer.addSublayer(shapeLayer)
                    
                    drawBottomLabel(text: "\(item)", x: x, width: 20)
                    
                }
            }
        }
        
        
    }
    
    func drawBottomLabel(text: String, x: CGFloat, width: CGFloat) {
        let label = UILabel(frame: CGRect(x: x, y: height - edge.bottom, width: width, height: 20))
        label.textColor = .yellow
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 10)
        label.text = text
        self.addSubview(label)
    }

}
