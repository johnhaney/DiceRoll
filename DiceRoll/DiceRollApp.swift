//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by John Haney on 8/19/25.
//

import SwiftUI

@main
struct DiceRollApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        #if os(visionOS)
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        .windowStyle(.volumetric)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        #else
        WindowGroup {
            ContentView()
        }
        #endif
    }
}
