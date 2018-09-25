//
//  ViewController.swift
//  JCCustomDonutGraph
//
//  Created by Jason Chan on 11/07/2016.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var donut: JCDonutGraphView! {
        didSet {
            donut.backgroundColor = .clear
            donut.arcWidth = 10
            donut.startAngle = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        donut.segments = [
            .init(color: .blue, ratio: 0.2),
            .init(color: .green, ratio: 0.2),
            .init(color: .red)
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

