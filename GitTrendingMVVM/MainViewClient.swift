//
//  MainViewClient.swift
//  GitTrendingMVVM
//
//  Created by Erick Gonzales on 1/15/18.
//  Copyright © 2018 erickgonzales. All rights reserved.
//

import UIKit

class MainViewClient: NSObject {
    
    //Github endpoint
    //https://api.github.com/search/repositories?q=sort=stars&order=desc&since=today
    
    func fetchTrendingRepositories(completition: @escaping ([NSDictionary]?) -> Void){
        guard let url = URL(string: "https://api.github.com/search/repositories?q=sort=stars&order=desc&since=today") else {
            print("Error, unable to unwarp URL"); return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { print("Error, unable to get data"); return}
            do {
                if let gitHubResponse = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary{
                    if let repos = gitHubResponse.value(forKeyPath: "items") as? [NSDictionary]{
                        completition(repos)
                    }
                }
            } catch {
                
                completition(nil)
                print("Error, Unable to get API Data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
