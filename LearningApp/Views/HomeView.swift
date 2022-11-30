//
//  ContentView.swift
//  LearningApp
//
//  Created by Brian Nguyen on 2022-11-30.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model:ContentModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
