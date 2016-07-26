//
//  ViewController.swift
//  JCCustomDonutGraph
//
//  Created by Jason Chan on 11/07/2016.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var donut: JCDonutGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGrayColor()
        
        donut.backgroundColor = .clearColor()
        donut.arcWidth = 40
        donut.startAngle = 0
        donut.segments = [
            JCDonutGraphView.Segment(ratio: 0.5, color: .blueColor()),
            JCDonutGraphView.Segment(ratio: 1, color: .greenColor()),
            JCDonutGraphView.Segment(ratio: 2, color: .redColor())
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

