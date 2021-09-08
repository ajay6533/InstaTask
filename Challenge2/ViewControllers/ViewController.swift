//
//  ViewController.swift
//  Challenge2
//
//  Created by ajaykumar on 26/08/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let shotTableViewCellIdentifier = "ShotTableViewCell"
    let textTableViewCellIdentifier = "textTableViewCell"
    var refreshControl: UIRefreshControl!
    
// AJAY
    
    // kumar
    @IBOutlet weak var FeedsTableView: UITableView!
    
    var userData = [UserData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userData = DataLoader().userData
        print(userData)
        
        var cellNib = UINib(nibName:shotTableViewCellIdentifier, bundle: nil)
        self.FeedsTableView.register(cellNib, forCellReuseIdentifier: shotTableViewCellIdentifier)
        
        cellNib = UINib(nibName: textTableViewCellIdentifier, bundle: nil)
        self.FeedsTableView.register(cellNib, forCellReuseIdentifier: textTableViewCellIdentifier)


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayeVideos()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pausePlayeVideos()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let metaData = userData[indexPath.row]
        
        if metaData.itemType == ContentType.Video {
            let cell = tableView.dequeueReusableCell(withIdentifier: shotTableViewCellIdentifier, for: indexPath) as! ShotTableViewCell
            cell.configureCell(imageUrl: metaData.thumbnail, description: "\(metaData.userName)", videoUrl: metaData.data, profileUrl: metaData.profilePic, comment: "\(metaData.userName) Has been shared a \(metaData.itemType), \(metaData.comment)")
            return cell
        }else if metaData.itemType == ContentType.Image {
            let cell = tableView.dequeueReusableCell(withIdentifier: shotTableViewCellIdentifier, for: indexPath) as! ShotTableViewCell
            cell.configureCell(imageUrl: metaData.thumbnail, description: "\(metaData.userName)", videoUrl: nil, profileUrl: metaData.profilePic, comment: "\(metaData.userName) Has been shared a \(metaData.itemType), \(metaData.comment)")
            return cell
        }else if metaData.itemType == ContentType.Text{
                        
            let cell = tableView.dequeueReusableCell(withIdentifier: textTableViewCellIdentifier, for: indexPath) as! textTableViewCell
            cell.textLable.text = "\(metaData.comment)"
            cell.titleLabel.text = "FAMOUS QUOTES"
            
            return cell
        }else if metaData.itemType == ContentType.WebView{
            let cell = tableView.dequeueReusableCell(withIdentifier: textTableViewCellIdentifier, for: indexPath) as! textTableViewCell
            cell.textLable.text = "Open in default browser"
            cell.titleLabel.text = "Web Content"
            cell.accessoryType = .disclosureIndicator
            return cell

        }else{return UITableViewCell()}
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.FeedsTableView.deselectRow(at: indexPath, animated: true)
        let metaData = userData[indexPath.row]
        if metaData.itemType == ContentType.WebView{
            
            if let url = URL(string: metaData.data), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: nil)
            }

        }

    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayeVideos()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayeVideos()
        }
    }
    
    func pausePlayeVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: self.FeedsTableView)
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: self.FeedsTableView, appEnteredFromBackground: true)
    }
}
