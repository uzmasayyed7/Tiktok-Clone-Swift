//
//  SecondViewController.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/8/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
fileprivate let cellReuseIdentifier = "cellReuseIdentifier"
fileprivate let headerReuseIdentifier = "headerReuseIdentifier"
fileprivate let footerReuseIdentifier = "footerReuseIdentifier"


class DiscoverViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DiscoverCellDelegate {
    
    private var filteredItems: [DiscoverItem] = []
    private var isSearching = false
    
    private var items: [DiscoverItem] = [
        DiscoverItem(iconUrl: "https://cdn.logojoy.com/wp-content/uploads/20200402144612/smoshlogo.png", hashtag: "IndigeousPride", trending: "Trending", postCount: "230.4M >", videos: [Video(thumbnailUrl: "https://media.istockphoto.com/id/1031430214/photo/young-woman-kayaking-through-the-backwaters-of-monroe-island.jpg?s=2048x2048&w=is&k=20&c=PdfRF9VqMu2q-i_tH74CWVfROwzPAByhfkD5xXeCDBU=", videoUrl: "https://media.istockphoto.com/id/1341252720/video/skyscraper-tower-buildings-in-financial-business-district-at-marina-bay-singapore-city-center.mp4?s=mp4-640x640-is&k=20&c=kRwWxGtg4nBiCBmY-iQKOftCMr_nTHWBtvxs9Wej-tw="), Video(thumbnailUrl: "https://media.istockphoto.com/id/505793128/photo/couple-walking-on-the-road.jpg?s=2048x2048&w=is&k=20&c=Kdrkbh06_uRAQx24vkmKcjBntkTWockwb_Uibt__D6M=", videoUrl: "https://media.istockphoto.com/id/1464801423/video/slow-motion-beautiful-horses-running-in-sunny-ocean-at-sunrise.mp4?s=mp4-640x640-is&k=20&c=4XFywQ3hl6NVyqq--h981337XpgYqVj6DajsbSX_Z_s="), Video(thumbnailUrl: "https://media.istockphoto.com/id/1347088244/photo/kerala-most-beautiful-place-of-india.jpg?s=2048x2048&w=is&k=20&c=VBxHEvZ5c5VRVAr5ZweO8XS0utGwdAd0BsDU0oOQyy0=", videoUrl: "https://media.istockphoto.com/id/1497707688/video/brain-getting-hot-and-explodes-with-fire.mp4?s=mp4-640x640-is&k=20&c=ciVcVmpR1YONziODXmU3-2GwsCXpaOU6dso7W0zKhf0="), Video(thumbnailUrl: "https://media.istockphoto.com/id/905049262/photo/varanasi-at-sunrise.jpg?s=2048x2048&w=is&k=20&c=EeVqfXoVEB81yOGpR3dSoOzsJBQ47tG_gNInbjHH0Po=", videoUrl: "https://media.istockphoto.com/id/994586448/video/whitewater-kayaker-in-a-yellow-kayak-dropping-a-waterfall.mp4?s=mp4-640x640-is&k=20&c=xYSdMWJkdmbhudlDWmY7wNxMVAHoEsyROe4MmJjEVH0="), Video(thumbnailUrl: "https://media.istockphoto.com/id/146812172/photo/sunrise-at-taj-mahal-on-jamuna-river.jpg?s=2048x2048&w=is&k=20&c=z41YqooAwprcyMfusB-27p_mMHEC2xhe56l4X2gmpjY=", videoUrl: "https://media.istockphoto.com/id/1140675444/video/young-surfer-ripping-gnarly-turn.mp4?s=mp4-640x640-is&k=20&c=Y8S6HPimKxeMPx8DPAbqrjayjLvxlkScIuNO5lkcLXM=")]),
        DiscoverItem(iconUrl: "https://static.rfstat.com/renderforest/images/v2/landing-pics/youtube-logo/4359.jpg", hashtag: "NatureLovers", trending: "Trending", postCount: "150.2M >", videos: [Video(thumbnailUrl: "https://media.istockphoto.com/id/526297482/photo/indian-peacock-in-ranthambhore-national-park-rajasthan-india.jpg?s=2048x2048&w=is&k=20&c=TPim7imO9lAP1yA1z2Rt1T23w0BJhv4Wa9ZJu2euNC0=", videoUrl: "https://media.istockphoto.com/id/1450313535/video/eco-friendly-cars-drive-on-elevated-roads.mp4?s=mp4-640x640-is&k=20&c=yLkIiF5a7XWHfqnmSHOuXL-gy5D3UNlwGpzzh7dXWKw="), Video(thumbnailUrl: "https://media.istockphoto.com/id/1267076588/photo/common-kingfisher.jpg?s=2048x2048&w=is&k=20&c=oexNhZtDi7xqGmjz1XqNEGed_jHj-fSReBgPJbxeS_A=", videoUrl: "https://media.istockphoto.com/id/1469018003/video/pink-hairy-3d-cartoon-character-dancing-on-pink-background-person-wearing-furry-costume-funny.mp4?s=mp4-640x640-is&k=20&c=tr0kAL25uPDwmmamQ9CNoG67Qg0O8X1Ew6Tw5dWypDY="), Video(thumbnailUrl: "https://media.istockphoto.com/id/489348944/photo/tomb-of-isa-khan-at-humayuns-tomb-delhi-india-cngltrv1109.jpg?s=2048x2048&w=is&k=20&c=97ViSOV5GS71gGd0oQTnKLGjB6B-3YwQq2NeFQKx1Pc=", videoUrl: "https://media.istockphoto.com/id/1499384294/video/underwater-footage-of-dolphins-swimming-in-the-ocean.mp4?s=mp4-640x640-is&k=20&c=PeUlPeSTqSPWr3gKjkb7oWwnk9h6099PncQPM2mDy8E="), Video(thumbnailUrl: "https://media.istockphoto.com/id/1161698440/photo/great-horn-bill-flight-shot-from-the-western-ghats-of-india.jpg?s=2048x2048&w=is&k=20&c=78hUUnZtRNFcqTiUN9NCY-ih9_aLERQgFnr7uPIJiTE=", videoUrl: "https://media.istockphoto.com/id/481413373/video/apricot-flower.mp4?s=mp4-640x640-is&k=20&c=FadMjuJcuwg_p5BoekPCXnP3NQtYf4FdkSZHENISHjk="), Video(thumbnailUrl: "https://media.istockphoto.com/id/1258120232/photo/greater-flamingos-are-famous-pink-birds-can-be-found-in-warm-watery-regions-on-many-continents.jpg?s=2048x2048&w=is&k=20&c=_EHdIma87UdqnWKc_H9wc3Vzb0-nnv7BLQ_djeaGpCg=", videoUrl: "https://media.istockphoto.com/id/1500620339/video/a-close-up-of-a-little-owl.mp4?s=mp4-640x640-is&k=20&c=E-eBUUBLcO6KtO7dzB2Ek-k6uwWDUDyrPMxhe3v2KoU=")]),
        DiscoverItem(iconUrl: "https://images-platform.99static.com//UlYwsjlwAEE6_5XrIVsN8JT0mkA=/0x0:1401x1403/fit-in/590x590/99designs-contests-attachments/122/122808/attachment_122808870", hashtag: "TechTalk", trending: "Trending", postCount: "320.1M >" , videos: [Video(thumbnailUrl: "https://media.istockphoto.com/id/858053178/photo/digital-electronic-components-circuit-boards-technology-era-india-map.jpg?s=2048x2048&w=is&k=20&c=ZxbMfxa3cjnRF2oENVj4DbZnz_nMMOH5-rGF7LNYDSg=", videoUrl: "https://media.istockphoto.com/id/540464346/video/chasing-the-herd-across-the-plain.mp4?s=mp4-640x640-is&k=20&c=CYHyq90gF0sCY4C8BtjA-tGLzIDZa6K-BHlpl5nyqF8="), Video(thumbnailUrl: "https://media.istockphoto.com/id/1144302932/photo/female-and-male-entrepreneurs-working-at-office.jpg?s=2048x2048&w=is&k=20&c=C7mQXLdTvsM-P_OtkISx8l-ku5UbN3dYXTL8obKYXpE=", videoUrl: "https://media.istockphoto.com/id/1926074362/video/2-gen-z-friends-hanging-out-together-wide-angle-shot.mp4?s=mp4-640x640-is&k=20&c=G_rNlZb20wJuv2tOTlIMRqT2I4cfNrX5oRzfdKLhf6o="), Video(thumbnailUrl: "https://media.istockphoto.com/id/922593814/photo/agronomist-consulting-with-farmer-outdoor-in-the-field.jpg?s=2048x2048&w=is&k=20&c=p5dX-HbifenwzyCOZWmpSh4o52d2uOWlqh9feHiGOR4=", videoUrl: "https://media.istockphoto.com/id/1473973347/video/glass-exploding.mp4?s=mp4-640x640-is&k=20&c=yZExFRyu3I-pgQovweHxP7kh9cLC4LK5dt7JPp8CrXo="), Video(thumbnailUrl: "https://media.istockphoto.com/id/477135580/photo/mother-and-daughter-holding-laptop-at-home.jpg?s=2048x2048&w=is&k=20&c=tUyEbeqNuzN203tUj_Bgf81eJEAlMfHa6OI3Ddkt8_Y=", videoUrl: "https://media.istockphoto.com/id/1343475994/video/time-lapse-of-car-traffic-transportation-above-bus-terminal-station-in-singapore-city.mp4?s=mp4-640x640-is&k=20&c=t3pPj_rSWoc6hb3XePUGy2m6Vf_VJe1-lGYeNjYgD-I="), Video(thumbnailUrl: "https://media.istockphoto.com/id/1280838980/photo/indian-people-on-market.jpg?s=2048x2048&w=is&k=20&c=cARUoS3Qr5ZZDGv2x33K_rN2yH9OvJUFOTPKJygW88E=", videoUrl: "https://media.istockphoto.com/id/1758082051/video/business-professionals-engage-in-office-meeting.mp4?s=mp4-640x640-is&k=20&c=qS6b150v2TUjL0dg2hwG3oJIMeDEULr0oL-WbysSZQw=")])
        // Add more sample items here
    ]
    
    private var bannerItem = ["https://media.istockphoto.com/id/1404167377/vector/5th-august-india-independence-day-indian-flag.jpg?s=2048x2048&w=is&k=20&c=pLOQ6HjI6jA61qDzSbQoYVLFYm5STXPL7-Xb4g6BVKg=", "https://media.istockphoto.com/id/1281010691/photo/little-girl-meditating-outdoors-at-park.jpg?s=2048x2048&w=is&k=20&c=2z2ltwc7aFqJmvJZ5RqMrMi40yY4SXEGlUGh9LcPnnk=", "https://media.istockphoto.com/id/522397658/photo/cheerful-children-lying-dawn-on-grass.jpg?s=2048x2048&w=is&k=20&c=rz7D4cevAJYeIOyQ_WqceTUs9FubyugVW2520w0FPPU=", "https://media.istockphoto.com/id/1184561513/photo/fireworks.jpg?s=2048x2048&w=is&k=20&c=eEOJxBEckfMBgWQbfq5Pz3CLFCALc93R7rvfwn3fCH8=", "https://media.istockphoto.com/id/888546204/photo/indian-kids-celebrating-christmas-with-decorated-tree-and-gifts.jpg?s=2048x2048&w=is&k=20&c=VMFvmRKPQbo0tNB3USUVYk22zwijA6GaBzaNoMxY3Do="]
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        handleSetUpNavItems()
        searchBar.delegate = self
    }
    
    
    //MARK: - Properties
    
    fileprivate lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.searchBarStyle = .prominent
        sb.isTranslucent = false
        var textFieldInsideSearchBar = sb.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.rgb(red: 237, green: 237, blue: 238)
        sb.barTintColor = .black
        sb.tintColor = .lightGray
        sb.keyboardAppearance = .dark
        
        let glassIconView = textFieldInsideSearchBar?.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = .black
        
        //        sb.setLeftImage(magnifyIconInsideSearchbar!.withRenderingMode(.alwaysOriginal), with: 8, tintColor: .black)
        var cancelButton = sb.value(forKey: "cancelButton") as? UIButton
        cancelButton?.setTitleColor(.black, for: .normal)
        textFieldInsideSearchBar?.clipsToBounds = true
        textFieldInsideSearchBar?.layer.cornerRadius = 4
        textFieldInsideSearchBar?.borderStyle = .none
        return sb
    }()
    
    
    
    fileprivate let barCodeButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold, scale: .medium)
        let normalImage = UIImage(systemName: "plus.viewfinder", withConfiguration: symbolConfig)!
        button.setImage(normalImage.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    fileprivate let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    
    
    
    //MARK: - Handlers
    fileprivate func setUpCollectionView() {
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(DiscoverHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        collectionView.backgroundColor = .black
    }
    
    
    fileprivate func handleSetUpNavItems() {
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.isUserInteractionEnabled = true
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .blackTranslucent
        navBar.addSubview(coverView)
        coverView.addSubview(barCodeButton)
        coverView.addSubview(searchBar)
        
        coverView.fillSuperview()
        barCodeButton.constrainToRight(paddingRight: -15)
        barCodeButton.centerYInSuperview()
        
        searchBar.anchor(top: coverView.topAnchor, leading: coverView.leadingAnchor, bottom: coverView.bottomAnchor, trailing: barCodeButton.leadingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15))
        
        
    }
    
    func playVideo(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    
    
    //MARK: - CollectionView Protocols
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! DiscoverCell
        let currentItem = isSearching ? filteredItems[indexPath.item] : items[indexPath.item]
        cell.item = currentItem // Pass the data to the cell
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 215)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredItems.count : items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if isSearching {
                // Return an empty reusable view
                let emptyHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "emptyHeader", for: indexPath)
                emptyHeader.isHidden = true
                return emptyHeader
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! DiscoverHeader
                header.imageUrls = bannerItem
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return isSearching ? .zero : CGSize(width: view.frame.width, height: 200)
    }
}

//MARK: - UISearchBarDelegate

extension DiscoverViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredItems.removeAll()
            collectionView.reloadData()
        } else {
            isSearching = true
            filteredItems = items.filter { $0.hashtag.lowercased().contains(searchText.lowercased()) }
            collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        filteredItems.removeAll()
        searchBar.text = ""
        searchBar.resignFirstResponder()
        collectionView.reloadData()
    }
}

