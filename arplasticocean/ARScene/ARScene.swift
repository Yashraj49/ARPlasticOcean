//
//  ARScene.swift
//  arplasticocean
//
//  Created by Yasuhito NAGATOMO on 2022/02/22.
//

import Foundation
import RealityKit

class ARScene {
    private(set) var isCleaned = false
    enum State {
        case collecting // collecting refuses
        case cleaned    // cleaned
    }
    private(set) var state: State = .collecting
    private let stageIndex: Int
    private let assetManager: AssetManager
    private var arView: ARView!
    private var anchor: AnchorEntity!
    private var stageEntity: Entity!

    private var stage: Stage!
    private var boat: Boat!
    private var fishes: [Fish] = []
    private var refuses: [Refuse] = []

    init(stageIndex: Int, assetManager: AssetManager) {
        self.stageIndex = stageIndex
        self.assetManager = assetManager
    }

    func prepare(arView: ARView, anchor: AnchorEntity) {
        self.arView = arView
        self.anchor = anchor
        // load entities and place them in the AR world.
        prepareStage()
        // load entities and place them in the AR world.
        prepareBoat()
        // load entities and place them in the AR world.
        prepareFishes()
        // load entities and place them in the AR world.
        prepareRefuses()
    }

    func startSession() {
        // start playing entity's animations
        // start playing sounds
        // start handling gestures
        // start handling AR runloop
    }

    func stopSession() {
        // stop handling AR runloop
        // stop handling gestures
        // stop playing sounds
        // stop playing entity's animations
    }

    private func prepareStage() {
        // instantiate the stage object
        stage = Stage(constant: AssetConstant.stageAssets[stageIndex])
        // load the entity
        if let entity = assetManager.loadStageEntity(name: stage.constant.modelFile) {
            // adjust position and scale
            entity.position = SceneConstant.origin  // scene origin
            entity.scale = SceneConstant.scale      // scene scale
            // set the entity
            stage.setEntity(entity: entity)
            // add CollisionComponent and PhysicsBodyComponent
            stage.addPhysics()
            // place it in the AR world
            anchor.addChild(entity)
            stageEntity = entity
        }
    }

    private func prepareBoat() {
        let boatAssetIndex = SceneConstant.stageConstants[stageIndex].boatAssetIndex
        // instantiate the boat object
        let surfaceY = AssetConstant.stageAssets[stageIndex].offset
                       - AssetConstant.stageAssets[stageIndex].surface
        boat = Boat(constant: AssetConstant.boatAssets[boatAssetIndex],
                    position: SIMD3<Float>([0.0, surfaceY, 0.0])) // initial boat position
        // load the entity
        if let entity = assetManager.loadBoatEntity(name: boat.constant.modelFile) {
            // set the entity (The initial position will be set.)
            boat.setEntity(entity: entity)
            // add CollisionComponent and PhysicsBodyComponent
            boat.addPhysics()
            // place it in the AR world
//            anchor.addChild(entity)
            stageEntity.addChild(entity)
        }
    }

    private func prepareFishes() {
        // choose fish (type and number)
        // instantiate the fish objects
        // load and clone their entities
        // add a collision shape each fish
        // set position
        // place them in the AR world (add as a stage's child)
    }

    private func prepareRefuses() {
        // choose fish (type and number)
        // instantiate the fish objects
        // load and clone their entities
        // add a collision shape each refuse
        // set position
        // place them in the AR world (add as a stage's child)
    }
}
