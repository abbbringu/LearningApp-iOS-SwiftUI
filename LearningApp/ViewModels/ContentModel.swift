//
//  ContentModel.swift
//  LearningApp
//
//  Created by Brian Nguyen on 2022-11-30.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    var styleData: Data?
    init() {
        getLocalData()
    }
    
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
}
