//
//  ViewController.swift
//  RingGraph
//
//  Created by mac on 7/14/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ringGraph: RingGraphView!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ringGraph.progress = CGFloat(slider.value)
    }

    @IBAction func sliderDidChange(_ sender: UISlider) {
        ringGraph.progress = CGFloat(sender.value)
    }
    
}

