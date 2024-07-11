//
//  HomeViewModel.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/8/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseFirestore
import AVFoundation

class HomeViewModel: NSObject {
    
    private(set) var currentVideoIndex = 0
    private var currentPageNumber = 1
    private var isFetching = false
    
    let isLoading = BehaviorSubject<Bool>(value: true)
    let posts = PublishSubject<[Post]>()
    let error = PublishSubject<Error>()

    private var docs = [Post]()
    
    override init() {
        super.init()
        getPosts(pageNumber: currentPageNumber, size: 10)
    }
    
    // Setup Audio
    func setAudioMode() {
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch (let err) {
            print("setAudioMode error:" + err.localizedDescription)
        }
    }
    
    /**
     * First, if videos exist in cache, acquire the cached video
     * Second, if videos don't exist in cache, make a request to firebase and download the video
     */
    func getPosts(pageNumber: Int, size: Int) {
        guard !isFetching else { return }
        self.isLoading.onNext(true)
        self.isFetching = true
        PostsRequest.getPostsByPages(pageNumber: pageNumber, size: size, success: { [weak self] data in
            guard let self = self else { return }
            if let data = data as? QuerySnapshot {
                for document in data.documents {
                    // Convert data into Post Entity
                    var post = Post(dictionary: document.data())
                    post.id = document.documentID
                    self.docs.append(post)
                }
                
                self.posts.onNext(self.docs)
                self.isLoading.onNext(false)
                self.isFetching = false
                self.currentPageNumber += 1
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            self.isFetching = false
            self.error.onNext(error)
        })
    }
    
    // Load more posts when the user scrolls to the bottom
    func loadMorePosts() {
        getPosts(pageNumber: currentPageNumber, size: 10)
    }
    
    // TODO: Create a cache manager to store videos in cache
}

// MARK: - Manage User Interaction in the screen
extension HomeViewModel {
    // Like a video
    func likeVideo() {
        
    }
    
    // Commenting a video
    func commentVideo(comment: String) {
        
    }
}
