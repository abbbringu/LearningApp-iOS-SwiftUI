//
//  ContentView.swift
//  LearningApp
//
//  Created by Brian Nguyen on 2022-11-30.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach (model.modules) { module in
                            
                            VStack (spacing: 20){
                                
                                NavigationLink {
                                    ContentView()
                                        .onAppear {
                                            model.beginModule(module.id)
                                        }
                                } label: {
                                    // Learning Card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) lessons", time: module.content.time)
                                }
                                // Test card
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) questions", time: module.test.time)
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
