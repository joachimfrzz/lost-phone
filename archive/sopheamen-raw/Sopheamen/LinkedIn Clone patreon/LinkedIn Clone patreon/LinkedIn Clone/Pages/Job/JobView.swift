//
//  JobView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 8/5/24.
//

import SwiftUI

struct JobView: View {
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack (spacing: 10){
                    // my jobs and post job
                    MyjobAndPostJob()
                    
                    // recommendedforyou
                    RecommendedForYouView()
                    
                    // premium account
                    PremiumAccountView()
                    
                    // remote opportunities
                    RemoteOpportunitiesView()
                    
                    // still hiring
                    StillHiringView()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.backgroundColor)
            
        }
    }
}

#Preview {
    JobView()
}

struct MyjobAndPostJob:View {
    var body: some View {
        HStack (spacing:60){
            HStack (spacing:10){
                Image(systemName: "bookmark")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.black.opacity(0.5))
                    .fontWeight(.semibold)
                Text("My jobs")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.7))
            }
            
            HStack (spacing:5){
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.black.opacity(0.5))
                    .fontWeight(.semibold)
                Text("Post a job")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.7))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

struct RecommendedForYouView: View {
    var recommendedData:[JobResponse] = recommendedForYouData
   
    var body: some View {
        VStack(spacing:10) {
            Text("Recommended For You")
                .font(.headline)
                .frame(maxWidth: .infinity,alignment: .leading)
            // list item
            LazyVStack (spacing:5){
                ForEach(recommendedData, id: \.self) { job in
                    HStack (spacing: 14){
                        ProfileImageRectangleView(profileImage: job.companyLogoUrl, size: 55)
                        VStack (alignment: .leading,spacing:0){
                            
                            Text(job.jobTitle)
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text(job.companyName)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.8))
                            
                            Text(job.location)
                                .font(.subheadline)
                                .foregroundStyle(.black.opacity(0.8))
                            Text(job.salaryRange)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.5))
                            Text(job.subTitle)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Divider()
                                .padding(.top,8)
                        }
                        Spacer()
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            // see all
            Button {
                
            }label: {
                HStack (spacing: 10){
                    Text("Show all")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primaryColor)
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.primaryColor)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom,10)
        }
        .padding(.horizontal)
        .padding(.top,12)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.white)
    }
}

struct PremiumAccountView: View {
    var body: some View {
        HStack {
            ProfileImageView(profileImage: userDataCurrent.profileImage, size: 50)
            VStack (alignment: .leading,spacing:8){
                Text("Try Premium to see jobs where you would be a top applicant")
                    .font(.subheadline)
                    .lineSpacing(-20)
                // button
                Button {
                    
                }label: {
                    Text("Try Free for 1 Month")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal,14)
                        .padding(.vertical,6)
                        .background(Color.buttonPremiumColor)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                   
                
            }
            Spacer()
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.black.opacity(0.6))
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.white)
    }
}


struct RemoteOpportunitiesView: View {
    var remoteData:[JobResponse] = remoteOpportunitiesData
   
    var body: some View {
        VStack(spacing:10) {
            VStack(alignment: .leading,spacing:-2) {
                Text("Remote opportunities")
                    .font(.headline)
                Text("because you expressed intested in remote work")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            // list item
            LazyVStack (spacing:5){
                ForEach(remoteData, id: \.self) { job in
                    HStack (spacing:14){
                        ProfileImageRectangleView(profileImage: job.companyLogoUrl, size: 55)
                        VStack (alignment: .leading,spacing:0){
                            
                            Text(job.jobTitle)
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text(job.companyName)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.8))
                            
                            Text(job.location)
                                .font(.subheadline)
                                .foregroundStyle(.black.opacity(0.8))
                            Text(job.salaryRange)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.5))
                            Text(job.subTitle)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Divider()
                                .padding(.top,8)
                        }
                        Spacer()
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            // see all
            Button {
                
            }label: {
                HStack (spacing: 10){
                    Text("Show all")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primaryColor)
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.primaryColor)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom,10)
        }
        .padding(.horizontal)
        .padding(.top,12)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.white)
    }
}


struct StillHiringView: View {
    var hiringData:[JobResponse] = stillHiringData
    var body: some View {
        VStack(spacing:10) {
            VStack(alignment: .leading,spacing:-2) {
                Text("Still Hiring")
                    .font(.headline)
                Text("Jobs you may have missed")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            // list item
            LazyVStack (spacing:5){
                ForEach(hiringData, id: \.self) { job in
                    HStack (spacing:14){
                        ProfileImageRectangleView(profileImage: job.companyLogoUrl, size: 55)
                        VStack (alignment: .leading,spacing:0){
                            
                            Text(job.jobTitle)
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text(job.companyName)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.8))
                            
                            Text(job.location)
                                .font(.subheadline)
                                .foregroundStyle(.black.opacity(0.8))
                            Text(job.salaryRange)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.5))
                            Text(job.subTitle)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Divider()
                                .padding(.top,8)
                        }
                        Spacer()
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            // see all
            Button {
                
            }label: {
                HStack (spacing: 10){
                    Text("Show all")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primaryColor)
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.primaryColor)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom,10)
        }
        .padding(.horizontal)
        .padding(.top,12)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.white)
    }
}
