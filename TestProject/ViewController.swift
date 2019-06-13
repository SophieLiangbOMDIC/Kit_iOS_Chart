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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chart = GMCharts(frame: CGRect(x: 0, y: 60, width: 375, height: 200))
        chart.chartBottom = 10
        chart.edge = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20)

        chart.redraw()
        chart.drawLine(array: array, color: .red)
        
        chart.drawSeparators(distance: 8, array: [1, 2, 3, 4, 5, 6, 7, 8.24], unit: .km)
        
        view.addSubview(chart)
    }


}

