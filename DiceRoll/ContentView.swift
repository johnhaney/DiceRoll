//
//  ContentView.swift
//  DiceRoll
//
//  Created by John Haney on 8/19/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var die: Entity?
    @State var baseEntity: Entity = Entity()
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            content.add(baseEntity)
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(scene)
                die = scene.findEntity(named: "Dice")
            }
        }
        .realityViewCameraControls(.orbit)
        .onReceive(timer) { _ in
            guard let die else { return }
            let direction = die.convert(direction: [0,1,0], from: baseEntity)
            switch (direction.x, direction.y, direction.z) {
            case (...(-0.9), _, _):
                print("1")
            case (0.9..., _, _):
                print("6")
            case (_, ...(-0.9), _):
                print("3")
            case (_, 0.9..., _):
                print("4")
            case (_, _, ...(-0.9)):
                print("2")
            case (_, _, 0.9...):
                print("5")
            default:
                print("????")
            }
        }
    }
}
