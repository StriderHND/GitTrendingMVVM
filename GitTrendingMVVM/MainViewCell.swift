//
//  MainViewCell.swift
//  GitTrendingMVVM
//
//  Created by ClinPaysiOSDev on 1/16/18.
//  Copyright © 2018 erickgonzales. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    @IBOutlet weak var repoName:UILabel?
    @IBOutlet weak var repoDescription:UILabel?
    @IBOutlet weak var repoStars:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
