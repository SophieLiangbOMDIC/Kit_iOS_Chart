//
//  ViewController.swift
//  TestProject
//
//  Created by Sophie Liang on 2019/6/13.
//  Copyright © 2019 Sophie Liang. All rights reserved.
//

import UIKit
import GMCharts

class ViewController: UIViewController {
    
    let array: [Double] = {
        var arr: [Double] = []
        for i in 0...20 {
            arr.append(Double.random(in: 0...5))
        }
        return arr
    }()
    
    var models: [GMChartModel] {
        var arr: [GMChartModel] = []
        for i in 0...50 {
            arr.append(GMChartModel(distance: CGFloat(i) / 5.0, data: CGFloat.random(in: 0...5)))
        }
        for i in 50...82 {
            arr.append(GMChartModel(distance: CGFloat(i) / 10.0, data: CGFloat.random(in: 0...5)))
        }
        return arr
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chart = GMCharts(frame: CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height / 2))
        chart.chartBottom = 50
        chart.edge = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20)
        chart.borderColor = .green
        chart.labelSize = 15

        chart.redraw()
        chart.drawLine(array: models, color: .red, unit: .km)
        chart.setRightLabels(top: "100%", mid: "50%", bottom: "0%", color: .orange)
//        chart.drawLine(array: models, color: .yellow, unit: .km)

        let distance = models.max { $0.distance < $1.distance }!.distance
        chart.drawSeparators(distance: distance, unit: .km)
                
        view.addSubview(chart)
    }


}

