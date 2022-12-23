//
//  ContentModel.swift
//  LearningApp
//
//  Created by Brian Nguyen on 2022-11-30.
//

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lessons?
    var currentLessonIndex = 0
    
    // Current lesson explination
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    
    func getLocalData() {
        // Parse the json data
        // Get the url of the file in the bundle
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Access the data with the URL
            let jsonData = try Data(contentsOf: jsonURL!)
            // Init the decoder
            let decoder = JSONDecoder()
            // State how we want to decode, and from where
            let modules = try decoder.decode([Module].self, from: jsonData)
            // Setting the modules in the top scope of the class
            self.modules = modules
        } catch {
            print(error)
        }
        
        
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleURL!)
            self.styleData = styleData
        } catch {
            print(error)
        }
       
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleid:Int) {
        
        // Find the module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    // MARK: - Lesson navigation
    
    func beginLesson(_ lessonindex:Int) {
        
        if lessonindex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonindex
        }
        else {
            currentLessonIndex = 0
        }
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
        
    }
    
    func hasNextLesson() -> Bool {
        
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
        
    }
    
    func nextLesson() {
        // Advance lesson index and check within range
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
            
        } else {
            // Reset the lesson state
            currentLesson = nil
            currentLessonIndex = 0
        }
    }
    
    // MARK: Make string to attributed text
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultStrings = NSAttributedString()
        var data = Data()
        // Add styling
        if styleData != nil {
            data.append(self.styleData!)
        }
        // Add the html data
        data.append(Data(htmlString.utf8))
        // Convert to attributed strings
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
            resultStrings = attributedString
        }
        
        return resultStrings
    }
}
