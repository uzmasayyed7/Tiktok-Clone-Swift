//
//  FirstViewController.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/8/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import RxSwift
import Lottie

class HomeViewController: BaseViewController {

    // MARK: - UI Components
    var mainTableView: UITableView!
    lazy var loadingAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "LoadingAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.8
        animationView.loopMode = .loop
        self.view.addSubview(animationView)
        self.view.bringSubviewToFront(animationView)
        animationView.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.width.height.equalTo(55)
        })
        return animationView
    }()
    
    // MARK: - Variables
    let cellId = "HomeCell"
    @objc dynamic var currentIndex = 0
    var oldAndNewIndices = (0,0)
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    var data = [Post]()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setAudioMode()
        setupView()
        setupBinding()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cell = mainTableView.visibleCells.first as? HomeTableViewCell {
            cell.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let cell = mainTableView.visibleCells.first as? HomeTableViewCell {
            cell.pause()
        }
    }
    
    /// Set up Views
    func setupView(){
        // Table View
        mainTableView = UITableView()
        mainTableView.backgroundColor = .black
        mainTableView.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
        mainTableView.tableFooterView = UIView()
        mainTableView.isPagingEnabled = true
        mainTableView.contentInsetAdjustmentBehavior = .never
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.separatorStyle = .none
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        mainTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.prefetchDataSource = self
    }

    /// Set up Binding
    func setupBinding(){
        // Posts
        viewModel.posts
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { posts in
                self.data = posts
                self.mainTableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.isLoading
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                if isLoading {
                    self.loadingAnimation.alpha = 1
                    self.loadingAnimation.play()
                } else {
                    self.loadingAnimation.alpha = 0
                    self.loadingAnimation.stop()
                }
            }).disposed(by: disposeBag)
        
        viewModel.error
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { err in
                self.showAlert(err.localizedDescription)
            }).disposed(by: disposeBag)
        
        ProfileViewModel.shared.cleardCache
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { cleard in
                if cleard {
                    //self.mainTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    func setupObservers(){
        
    }

}


// MARK: - Table View Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.configure(post: data[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HomeTableViewCell {
            oldAndNewIndices.1 = indexPath.row
            currentIndex = indexPath.row
            cell.pause()
        }
        
        // Load more posts if the last cell is about to be displayed
        if indexPath.row == data.count - 1 {
            viewModel.loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HomeTableViewCell {
            cell.pause()
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row >= data.count - 3 { // Prefetch more data when near bottom
                viewModel.loadMorePosts()
            }
        }
    }
}

// MARK: - ScrollView Extension
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let cell = self.mainTableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0)) as? HomeTableViewCell
        cell?.replay()
    }
}

extension HomeViewController: HomeCellNavigationDelegate {
    func navigateToProfilePage(uid: String, name: String) {
        // Initialize the ProfileViewController
        let profileViewController = ProfileViewController()
        
        // Set any necessary properties or data for the ProfileViewController
//        profileViewController.userID = uid
//        profileViewController.userName = name
        
        // Push the ProfileViewController onto the navigation stack
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

// MARK:
