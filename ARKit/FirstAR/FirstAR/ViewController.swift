//
//  ViewController.swift
//  FirstAR
//
//  Created by 中川 慶悟 on 2019/04/21.
//  Copyright © 2019年 中川 慶悟. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }


}

