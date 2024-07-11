//
//  VideoPlayerViewController.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma  on 04/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    var post: Post?
    var playerView: VideoPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        playerView = VideoPlayerView(frame: view.bounds)
        view.addSubview(playerView)
        
        if let post = post {
            playerView.configure(url: post.videoURL, fileExtension: post.videoFileExtension, size: (post.videoWidth, post.videoHeight))
            playerView.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.pause()
    }
}
