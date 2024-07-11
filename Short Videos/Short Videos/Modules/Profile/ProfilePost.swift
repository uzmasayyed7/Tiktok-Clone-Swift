//
//  ProfilePost.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 05/07/24.
//  Copyright © 2024 Uzma. All rights reserved.
//

struct ProfilePost {
    let imageUrl: String
    let title: String
    var videoURL: String = ""
}

let sampleProfilePosts = [
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/2027647555/photo/lovely-woman-doing-a-manicure-at-a-beauty-salon.jpg?s=2048x2048&w=is&k=20&c=XpzNYnEh7kDhEHGXvNGxvZIH2TdQKNL2cPGQ1SgI_Wk=", title: "Post 1",videoURL: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1454729512/photo/african-american-nail-salon.jpg?s=2048x2048&w=is&k=20&c=lkCkjqKquF7gmB_MYFREYm50tUqSRMoKu0Ut0BhzOeI=", title: "Post 2",videoURL: "https://images.unsplash.com/photo-1593642634367-d91a135587b5"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1917061672/photo/moon-nails.jpg?s=2048x2048&w=is&k=20&c=GAkLBmy4NMkGlxKlCGraqea3bmeRAxm31cvYF0yvnpQ=", title: "Post 3",videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1273978367/photo/3d-image-of-an-environmentally-friendly-coworking-office-space.jpg?s=2048x2048&w=is&k=20&c=-qvGNpWOpwG16hjv_dpl_s01lHdrOY8Ee3amihwTu4w=", title: "Post 4",videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1605676658/photo/mehndi-artist-making-mehndi-bridal-hand-in-india-mehndi-design.jpg?s=2048x2048&w=is&k=20&c=cDu9sKzWu0qPhUzbAPBKf0FsFJXCq6lF-RCF23rjMJk=", title: "Post 5",videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/115868883/photo/entrance-of-kuchaman-fort-rajasthan-india.jpg?s=2048x2048&w=is&k=20&c=04YFdmewl-ZzaT_DGO6AFmjM4MQCjCChiibj586AKx0=", title: "Post 6",videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/2030273156/photo/teacher-talking-to-fashion-design-students-about-some-design-sketches.jpg?s=2048x2048&w=is&k=20&c=FHOt7Dli2Ceu9xRxGgmo-5mRVcG4VGOqyXAJSJmNuoQ=", title: "Post 7",videoURL: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/618976674/photo/fashion-woman-shopping.jpg?s=2048x2048&w=is&k=20&c=7n8zvWncY6MDUPqRSDpW6NRnlwRozWuhL_me0DNUqug=", title: "Post 8",videoURL: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/183382423/photo/entrance-peacock-door-jaipur-city-palace.jpg?s=2048x2048&w=is&k=20&c=Y3l4OBgvzeP6d05yFL6PiHPIKH5J6pzlZaQO-w1CD4E=", title: "Post 9",videoURL: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1352907784/photo/architect-wearing-virtual-reality-headset-for-detail-project-house-model.jpg?s=2048x2048&w=is&k=20&c=zDNcu-1BJHUapptp2NUCPgD30hqpy5ilEGrcw02tVwE=", title: "Post 10",videoURL: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4")
]

let sampleFeeds = [
    ProfilePost(imageUrl: "https://plus.unsplash.com/premium_photo-1664304423623-4f9d5ed90b4f?q=80&w=2068&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", title: "Feed 1"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1397030090/photo/colorful-pastel-sky-with-clouds-at-beautiful-sunset-as-natural-background.jpg?s=2048x2048&w=is&k=20&c=BiBSra2q5_osM9qHr_k2bxCcvQxNprk6iUrz24m_VWM=", title: "Feed 2"),
    // Add more sample feeds
]

let sampleLikes = [
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/482954331/photo/solar-system.jpg?s=2048x2048&w=is&k=20&c=5WQvf6BkNSFi-6hjH9tAkfM2ZN760QZSmB1_otsH1N8=", title: "Like 1"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/1088863384/photo/abstract-space-wallpaper-black-hole-with-nebula-over-colorful-stars-and-cloud-fields-in-outer.jpg?s=2048x2048&w=is&k=20&c=rruLhM9XdbUUjiVP4Xkp8mVZs3RpOoBJKvCAOhSOK74=", title: "Like 2"),
    ProfilePost(imageUrl: "https://media.istockphoto.com/id/91633822/photo/space-galaxy.jpg?s=2048x2048&w=is&k=20&c=feKohzUNm2kLU5LtmdibuHFrrCi2PEdrSamOGn0tfEg=", title: "Like 3"),
    // Add more sample likes
]
