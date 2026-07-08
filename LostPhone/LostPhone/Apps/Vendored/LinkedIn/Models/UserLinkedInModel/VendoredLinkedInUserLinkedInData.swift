//
//  UserLinkedInData.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 16/5/24.
//

import Foundation


var userDataCurrent: VendoredLinkedInUserLinkedInResponse = VendoredLinkedInUserLinkedInResponse(
    id: UUID(),
    fullname: "Samantha Carter",
    type: 1,
    profileImage: "https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?auto=compress&cs=tinysrgb&w=600",
    imageCover: "https://images.pexels.com/photos/256381/pexels-photo-256381.jpeg?auto=compress&cs=tinysrgb&w=600",
    headLineBio: "Astrophysicist and Engineer | Exploring the stars",
    companyName: "Deep Space Research Center",
    companyLocation: "Colorado Springs, CO",
    gender: "Female",
    totalFollowers: 34000
)

var userLinkedInData: [VendoredLinkedInUserLinkedInResponse] = [
    VendoredLinkedInUserLinkedInResponse(
        id: UUID(),
        fullname: "Alice Johnson",
        type: 1,
        profileImage: "https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=600",
        imageCover: "https://images.pexels.com/photos/4458554/pexels-photo-4458554.jpeg?auto=compress&cs=tinysrgb&w=600",
        headLineBio: "iOS Developer and Blogger",
        companyName: "TechBlogs Inc.",
        companyLocation: "San Francisco, CA",
        gender: "Female",
        totalFollowers: 1200
    ),
    VendoredLinkedInUserLinkedInResponse(
        id: UUID(),
        fullname: "Bob Smith",
        type: 1,
        profileImage: "https://images.pexels.com/photos/3785079/pexels-photo-3785079.jpeg?auto=compress&cs=tinysrgb&w=600",
        imageCover: "https://images.pexels.com/photos/4974914/pexels-photo-4974914.jpeg?auto=compress&cs=tinysrgb&w=600",
        headLineBio: "Freelance UI/UX Designer",
        companyName: "Designs by Bob",
        companyLocation: "New York, NY",
        gender: "Male",
        totalFollowers: 980
    ),
    VendoredLinkedInUserLinkedInResponse(
        id: UUID(),
        fullname: "Creative Solutions",
        type: 2,
        profileImage: "https://media.licdn.com/dms/image/C4D0BAQFpsE-uoqDUHQ/company-logo_100_100/0/1676990232808/fram_creative_solutions_logo?e=1723680000&v=beta&t=iYWvHmKtGOcrjqPGpn5hUD10S65YjOk2xM1zQlZ8ULs",
        imageCover: "https://media.licdn.com/dms/image/D4D3DAQHVzc-wfcswhg/image-scale_191_1128/0/1679390959017/fram_creative_solutions_cover?e=1716440400&v=beta&t=0jKfdTAUwbsVtg4cuhUiCU78NHWgxIYq6aFK6mpxuyo",
        headLineBio: "Innovative Tech Solutions for Modern Businesses",
        companyName: "Creative Solutions Ltd.",
        companyLocation: "Los Angeles, CA",
        gender: nil,
        totalFollowers: 4500
    ),
    VendoredLinkedInUserLinkedInResponse(
        id: UUID(),
        fullname: "Diana Greene",
        type: 1,
        profileImage: "https://images.pexels.com/photos/1547971/pexels-photo-1547971.jpeg?auto=compress&cs=tinysrgb&w=600",
        imageCover: "https://images.pexels.com/photos/4158/apple-iphone-smartphone-desk.jpg?auto=compress&cs=tinysrgb&w=600",
        headLineBio: "Digital Marketing Expert",
        companyName: "Green Marketing Works",
        companyLocation: "Austin, TX",
        gender: "Female",
        totalFollowers: 1520
    ),
    VendoredLinkedInUserLinkedInResponse(
        id: UUID(),
        fullname: "EnviroBuild",
        type: 2,
        profileImage: "https://media.licdn.com/dms/image/C4D0BAQEMdqcr0jnpng/company-logo_100_100/0/1631333680279?e=1723680000&v=beta&t=UFoVyqNn61M0xQouH3EIhjRh11Px-01MlHj2XnkT0Zg",
        imageCover: "https://media.licdn.com/dms/image/D4E3DAQF4sO2zM3uK5g/image-scale_191_1128/0/1714479227798/envirobuild_cover?e=1716440400&v=beta&t=lqPUbndo7eI9bp1Wlrq3XAzMxajzEH5tuX5P520JTj4",
        headLineBio: "Building Sustainable Future Together",
        companyName: "EnviroBuild Construction",
        companyLocation: "Seattle, WA",
        gender: nil,
        totalFollowers: 3000
    ),
    VendoredLinkedInUserLinkedInResponse(
            id: UUID(),
            fullname: "Evan Rogers",
            type: 1,
            profileImage: "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg?auto=compress&cs=tinysrgb&w=600",
            imageCover: "https://images.pexels.com/photos/256502/pexels-photo-256502.jpeg?auto=compress&cs=tinysrgb&w=600",
            headLineBio: "Machine Learning Enthusiast and Speaker",
            companyName: "AI Innovations",
            companyLocation: "Boston, MA",
            gender: "Male",
            totalFollowers: 1980
        ),
    VendoredLinkedInUserLinkedInResponse(
            id: UUID(),
            fullname: "Fiona Chen",
            type: 1,
            profileImage: "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=600",
            imageCover: "https://images.pexels.com/photos/1181354/pexels-photo-1181354.jpeg?auto=compress&cs=tinysrgb&w=600",
            headLineBio: "Data Scientist & Researcher",
            companyName: "DataWiz Corp.",
            companyLocation: "San Diego, CA",
            gender: "Female",
            totalFollowers: 2650
        ),
    VendoredLinkedInUserLinkedInResponse(
            id: UUID(),
            fullname: "GadgetFlow",
            type: 2,
            profileImage: "https://media.licdn.com/dms/image/C4D0BAQFUvfvXv56hNw/company-logo_100_100/0/1630522132091/gadgetflow_logo?e=1723680000&v=beta&t=abjM97y-7Xw4zD-fHSL1o1Vcuz6jkxO2VNbk9Mz3EJA",
            imageCover: "https://media.licdn.com/dms/image/C4D1BAQHVN3KvfYRrMw/company-background_10000/0/1583518232850/gadgetflow_cover?e=1716440400&v=beta&t=OFtcaOWV6o_ekYUh7RJzL9NHhB1VR233uFMBZi4hq-A",
            headLineBio: "Latest Tech and Gadgets",
            companyName: "GadgetFlow Inc.",
            companyLocation: "Chicago, IL",
            gender: nil,
            totalFollowers: 5200
        ),
    VendoredLinkedInUserLinkedInResponse(
            id: UUID(),
            fullname: "Henry Wade",
            type: 1,
            profileImage: "https://images.pexels.com/photos/1462980/pexels-photo-1462980.jpeg?auto=compress&cs=tinysrgb&w=600",
            imageCover: "https://images.pexels.com/photos/4974915/pexels-photo-4974915.jpeg?auto=compress&cs=tinysrgb&w=600",
            headLineBio: "Full-Stack Developer and Open Source Contributor",
            companyName: "CodeForge",
            companyLocation: "Miami, FL",
            gender: "Male",
            totalFollowers: 1370
        ),
    VendoredLinkedInUserLinkedInResponse(
            id: UUID(),
            fullname: "InnovateX",
            type: 2,
            profileImage: "https://media.licdn.com/dms/image/C4D0BAQE25NM1ioeW8w/company-logo_200_200/0/1630559821243/innovate1_logo?e=1723680000&v=beta&t=cCg4eHVh6xmC-HSj60ks7bke7iakkG2gPhuzSodtjb0",
            imageCover: "https://media.licdn.com/dms/image/C4D1BAQH0duOogVreGg/company-background_10000/0/1586045540468/innovate1_cover?e=1716440400&v=beta&t=fuSNFTHItArDfFbD3AKMv_qK3Gi2Dm0oU3TkSzRAzks",
            headLineBio: "Pioneering Software Solutions for Next-Gen Enterprises",
            companyName: "InnovateX Technologies",
            companyLocation: "Palo Alto, CA",
            gender: nil,
            totalFollowers: 4550
        )
]


