//
//  MainViewModel.swift
//  GitTrendingMVVM
//
//  Created by ClinPaysiOSDev on 1/15/18.
//  Copyright © 2018 erickgonzales. All rights reserved.
//

import UIKit


// View Model Setup
class MainViewModel: NSObject {

    //create instance of MainViewClient
    @IBOutlet var mainViewClient: MainViewClient!
    
    //definition of repo property
    var repos:[NSDictionary]?
    var filteredRepos:[NSDictionary]?
    
    //MARK: ModelFunctions
    func getRepos(completition: @escaping () -> Void) {
        mainViewClient.fetchTrendingRepositories { (reposDictionary) in
            DispatchQueue.main.async {
                self.repos = reposDictionary
                completition()
            }
        }
    }
    
    func filterRepos(completition: @escaping ([NSDictionary]?) -> Void , filter:String){
        DispatchQueue.main.async {
            self.filteredRepos = self.repos?.filter({( repo  : NSDictionary) -> Bool in
                return ((repo.value(forKeyPath: "name") as? String)?.lowercased().contains(filter.lowercased()))!
            })
            completition(self.filteredRepos)
        }
    }
    
    func numberOfReposToDisplay(in section: Int ) -> Int {
        if (self.filteredRepos == nil || (self.filteredRepos?.isEmpty)!){
            return repos?.count ?? 0
        }
        return filteredRepos?.count ?? 0
    }
    
    func repoTitleToDisplay(for indexPath:IndexPath) -> String {
        if (self.filteredRepos == nil || (self.filteredRepos?.isEmpty)!){
            return repos?[indexPath.row].value(forKeyPath: "name") as? String ?? "No name available"
        }
        return filteredRepos?[indexPath.row].value(forKeyPath: "name") as? String ?? "No name available"
    }
    
    func repoStarsCount(for indexPath:IndexPath) -> Int{
        if (self.filteredRepos == nil || (self.filteredRepos?.isEmpty)!){
            return repos?[indexPath.row].value(forKeyPath: "stargazers_count") as? Int ?? 0
        }
        return filteredRepos?[indexPath.row].value(forKeyPath: "stargazers_count") as? Int ?? 0
    }
    
    func repoDescription(for indexPath:IndexPath) -> String{
        if (self.filteredRepos == nil || (self.filteredRepos?.isEmpty)!){
            return repos?[indexPath.row].value(forKeyPath: "description") as? String ?? "No description available"
        }
        return filteredRepos?[indexPath.row].value(forKeyPath: "description") as? String ?? "No description available"
    }
    
    func repoSelected(for indexPath:IndexPath) -> NSDictionary{
        if (self.filteredRepos == nil || (self.filteredRepos?.isEmpty)!){
            return (repos?[indexPath.row])!
        }
        return (filteredRepos?[indexPath.row])!
    }
}
