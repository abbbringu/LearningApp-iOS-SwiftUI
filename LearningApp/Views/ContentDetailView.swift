//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Brian Nguyen on 2022-12-01.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostURL + (lesson?.video ?? ""))

        VStack {
            
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            
            // Next lesson button
            if model.hasNextLesson() {
                
                Button {
                    
                    model.nextLesson()
                    
                } label: {
                    
                    ZStack {
                        
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                }
            }
        }
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
