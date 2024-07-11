//
//  DiscoverViewModel.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma  on 04/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import FirebaseFirestore
import AVFoundation

class DiscoverViewModel: NSObject {
    
    private(set) var currentVideoIndex = 0
    private var currentPageNumber = 1
    private var isFetching = false
    
    let isLoading = BehaviorSubject<Bool>(value: true)
    let posts = PublishSubject<[Post]>()
    private var allPosts = [Post]()
    let error = PublishSubject<Error>()

    private var docs = [Post]()
    
    override init() {
        super.init()
    }
    
    func getPosts(){
        getPosts(pageNumber: currentPageNumber, size: 10)
    }
    
    // Setup Audio
    func setAudioMode() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch (let err) {
            print("setAudioMode error:" + err.localizedDescription)
        }
    }
    
    func getPosts(pageNumber: Int, size: Int) {
        self.posts.onNext(samplePosts)
        self.allPosts = samplePosts
        self.isFetching = false
//        guard !isFetching else { return }
//        self.isLoading.onNext(true)
//        self.isFetching = true
//        PostsRequest.getPostsByPages(pageNumber: pageNumber, size: size, success: { [weak self] data in
//            guard let self = self else { return }
//            if let data = data as? QuerySnapshot {
//                for document in data.documents {
//                    var post = Post(dictionary: document.data())
//                    post.id = document.documentID
//                    self.docs.append(post)
//                }
//                self.posts.onNext(self.docs)
//                self.isLoading.onNext(false)
//                self.isFetching = false
//                self.currentPageNumber += 1
//            }
//        }, failure: { [weak self] error in
//            guard let self = self else { return }
//            self.isLoading.onNext(false)
//            self.isFetching = false
//            self.error.onNext(error)
//        })
    }
    
    func loadMorePosts() {
        getPosts(pageNumber: currentPageNumber, size: 10)
    }
    
    func searchPosts(query: String) {
        if query.isEmpty {
            self.posts.onNext(self.allPosts)
        } else {
            let filteredPosts = self.allPosts.filter { $0.title.lowercased().contains(query.lowercased()) }
            self.posts.onNext(filteredPosts)
        }
    }
}
