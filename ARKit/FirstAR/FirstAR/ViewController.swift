//
//  ViewController.swift
//  FirstAR
//
//  Created by 中川 慶悟 on 2019/04/21.
//  Copyright © 2019年 中川 慶悟. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("add plane")
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        print("remove plane")
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        print("update plane")
    }


}

