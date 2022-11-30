//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Brian Nguyen on 2022-11-30.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
