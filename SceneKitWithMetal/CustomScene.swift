//
//  HologramShadersScene.swift
//  HologramShader
//
//  Created by qe on 3/22/22.
//

import SceneKit

final class CustomScene: SCNScene {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        let node = SCNNode()
        node.castsShadow = false
        node.position = SCNVector3(0,0,0)
        node.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.25)
        rootNode.addChildNode(node)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        rootNode.addChildNode(ambientLightNode)
        
        let program = SCNProgram()
        program.vertexFunctionName = "textureSamplerVertex"
        program.fragmentFunctionName = "textureSamplerFragment"
        node.geometry?.firstMaterial?.program = program
        
        guard let textureImage = NSImage(named: "texture") else {
            return
        }
        let materialProperty = SCNMaterialProperty(contents: textureImage)
        node.geometry?.firstMaterial?.setValue(materialProperty, forKey: "customTexture")
    }
}
