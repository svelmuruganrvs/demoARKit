//
//  ARDemoViewController.swift
//  ARKitDemo
//
//  Created by velmurugan on 31/12/17.
//  Copyright © 2017 Velmurugan. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARDemoViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        let text = SCNText(string: "AR Kit Demo", extrusionDepth: 1)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.purple
        text.materials = [material]
        
        
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y : 0.02, z: -0.1)
        node.scale = SCNVector3(x: 0.01, y:0.01, z: 0.01)
        node.geometry = text
        
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.automaticallyUpdatesLighting = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
