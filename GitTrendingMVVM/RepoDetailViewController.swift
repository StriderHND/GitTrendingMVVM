//
//  RepoDetailViewController.swift
//  GitTrendingMVVM
//
//  Created by ClinPaysiOSDev on 1/16/18.
//  Copyright © 2018 erickgonzales. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    var repoData:NSDictionary!
    @IBOutlet var userName:UILabel!
    @IBOutlet var userProfilePicture:UIImageView!
    @IBOutlet var repoDescription:UILabel!
    @IBOutlet var repoReadme:UILabel!
    @IBOutlet var forksAndStars:UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(repoData)
        
        //repo name
        navigationItem.title = repoData.value(forKeyPath: "name") as? String
        // Do any additional setup after loading the view.
        
        //user Name and repo description
        userName.text = repoData.value(forKeyPath: "owner.login") as? String
        repoDescription.text = repoData.value(forKeyPath: "description") as? String
        
        //Stars
        let stars = repoData.value(forKeyPath: "stargazers_count") as? Int
        forksAndStars.setTitle("\(stars!) Stars", forSegmentAt: 0)
        
        //Forks
        let forks = repoData.value(forKeyPath: "forks_count") as? Int
        forksAndStars.setTitle("\(forks!) Forks", forSegmentAt: 1)
        
        //User Profile Picture
        let url = URL(string: repoData.value(forKeyPath: "owner.avatar_url") as! String )
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.userProfilePicture.image = UIImage(data: data!)
            }
        }
        
        //UIimageLayer settings
        userProfilePicture.layer.borderColor = UIColor.white.cgColor
        userProfilePicture.layer.borderWidth = 2
        userProfilePicture.layer.cornerRadius = userProfilePicture.frame.width/2
        userProfilePicture.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
