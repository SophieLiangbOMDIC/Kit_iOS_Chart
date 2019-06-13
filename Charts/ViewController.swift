//
//  ViewController.swift
//  Charts
//
//  Created by Sophie Liang on 2019/6/12.
//  Copyright © 2019 Sophie Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let chart = ChartView(frame: CGRect(x: 0, y: 60, width: 375, height: 200))
    let array: [Double] = {
        var arr: [Double] = []
        for i in 0...20 {
            arr.append(Double.random(in: 0...5))
        }
        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.edge = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20)
        chart.chartBottom = 20
        chart.redraw()
        chart.drawLine(array: array, color: .red)
        
        view.addSubview(chart)
        
    }


}

