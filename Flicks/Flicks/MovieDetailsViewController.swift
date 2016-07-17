//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Abhinav Mathur on 7/17/16.
//  Copyright © 2016 Abhinav Mathur. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var posterURL: String!
    var releaseDate: String!
    var popularity: Int!
    var voteCount: Int!
    var voteAvg: String!
    var titleValue: String!
    var synopsis: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterView.setImageWithURL(NSURL(string:posterURL)!)
        //posterView.sizeToFit()
        titleLabel.text = titleValue
        releaseDateLabel.text = releaseDate
        popularityLabel.text = String(popularity)
        voteCountLabel.text = String(voteCount)
        synopsisLabel.text = synopsis

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
