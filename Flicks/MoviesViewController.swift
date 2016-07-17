//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Abhinav Mathur on 7/17/16.
//  Copyright © 2016 Abhinav Mathur. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD



class MoviesViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var networkErrorView: UITextView!
    
    var movies:[NSDictionary] = []
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        let request = NSURLRequest(URL:url!)
        let session = NSURLSession( configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),delegate:nil,delegateQueue:NSOperationQueue.mainQueue())
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (dataOrNil, responseOrNil, errorOrNil) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                    // NSLog("response: \(responseDictionary)")
                    self.movies = responseDictionary["results"] as! [NSDictionary]
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.tableView.reloadData()
                }
            } else {
                self.networkErrorView.hidden = false
            }
        }
        task.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        networkErrorView.hidden = true
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        let request = NSURLRequest(URL:url!)
        let session = NSURLSession( configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),delegate:nil,delegateQueue:NSOperationQueue.mainQueue())
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (dataOrNil, responseOrNil, errorOrNil) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                   // NSLog("response: \(responseDictionary)")
                    self.movies = responseDictionary["results"] as! [NSDictionary]
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.tableView.reloadData()
                }
            } else {
                self.networkErrorView.hidden = false
            }
        }
        task.resume()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        
        if let movie = movies[indexPath.row] as? NSDictionary {
            // handle title
            if let title = movie["title"] as? String {
                cell.titleLabel.text = title
            } else {
                cell.titleLabel.text = "NO TITLE FOUND"
            }
            // handle synopsis
            if let synposis = movie["overview"] as? String {
                cell.synopsisLabel.text = synposis
            } else {
                cell.synopsisLabel.text = "NO OVERVIEW FOUND"
            }
            if let posterPath = movie["poster_path"] as? String {
                var posterPath1 = "https://image.tmdb.org/t/p/original"+posterPath
                cell.posterImageView.setImageWithURL(NSURL(string:posterPath1)!)
                
            } else {
                NSLog("no poster found")
            }
            
        } else {
            NSLog("Failed to cast row \(indexPath.row) into Movie cell")
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    

  
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var vc = segue.destinationViewController as! MovieDetailsViewController
        if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            if let movie = movies[indexPath.row] as? NSDictionary {
                // handle title
                if let title = movie["title"] as? String {
                    vc.titleValue = title
                } else {
                    //cell.titleLabel.text = "NO TITLE FOUND"
                }
                // handle synopsis
                if let synposis = movie["overview"] as? String {
                    vc.synopsis = synposis
                    //cell.synopsisLabel.text = synposis
                } else {
                    //cell.synopsisLabel.text = "NO OVERVIEW FOUND"
                }
                if let posterPath = movie["poster_path"] as? String {
                    var posterPath1 = "https://image.tmdb.org/t/p/original"+posterPath
                    vc.posterURL = posterPath1
                    
                } else {
                    NSLog("no poster found")
                }
                if let releaseDate = movie["release_date"] as? String {
                    vc.releaseDate = releaseDate
                }
                if let popularity = movie["popularity"] as? Int {
                    vc.popularity = popularity
                }
                if let voteCount = movie["vote_count"] as? Int {
                    vc.voteCount = voteCount
                }
                
            } else {
                NSLog("Failed to cast row \(indexPath.row) into Movie cell")
            }

        }
        
        
    }
   

}
