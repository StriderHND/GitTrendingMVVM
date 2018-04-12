//
//  ViewController.swift
//  GitTrendingMVVM
//
//  Created by Erick Gonzales on 1/15/18.
//  Copyright © 2018 erickgonzales. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {

    @IBOutlet var mainViewModel:MainViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 11.0, *) {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.delegate = self
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            definesPresentationContext = true
        }
        mainViewModel.getRepos {
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewDelegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.numberOfReposToDisplay(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! MainViewCell
        cell.repoName?.text = mainViewModel.repoTitleToDisplay(for: indexPath)
        cell.repoStars?.text = cell.repoStars?.text?.replacingOccurrences(of: "#stars#", with: String(mainViewModel.repoStarsCount(for: indexPath)))
        cell.repoDescription?.text = mainViewModel.repoDescription(for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showRepoDetail", sender: mainViewModel.repoSelected(for: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepoDetail" {
            let DestinationViewController = segue.destination as! RepoDetailViewController
            DestinationViewController.repoData = sender as! NSDictionary
        }
    }
}

extension ReposTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Methods
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: - Private instance Methods
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
            mainViewModel.filterRepos(completition: { (filteredRepos) in
                print(filteredRepos!)
                self.tableView.reloadData()
            }, filter: searchText)
    }
    
    // MARK: - UISearchBarDelegate Methods
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainViewModel.getRepos {
            self.tableView.reloadData()
        }
    }
}

