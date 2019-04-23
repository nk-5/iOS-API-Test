//
//  ViewController.swift
//  FirstAR
//
//  Created by 中川 慶悟 on 2019/04/21.
//  Copyright © 2019年 中川 慶悟. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.session.delegate = self
    sceneView.delegate = self
        
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

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { fatalError() }
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        geometry.materials.first?.diffuse.contents = UIColor.yellow
        
        let planeNode = SCNNode(geometry: geometry)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1, 0, 0)
        DispatchQueue.main.async(execute: {node.addChildNode(planeNode)})
    }
}

