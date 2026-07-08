//
//  VendoredAirbnbHomeView.swift
//  SwiftUI-List
//
//  Created by Keerthi on 07/08/20.
//  Copyright © 2020 Hxtreme. All rights reserved.
//

import SwiftUI

struct VendoredAirbnbCategory: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}

struct VendoredAirbnbExperiences: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var price: String
}

struct VendoredAirbnbHomeView: View {
    
    let categories: [VendoredAirbnbCategory] = [VendoredAirbnbCategory(image: "property1", name: "Home"), VendoredAirbnbCategory(image: "property2", name: "Experience"), VendoredAirbnbCategory(image: "property3", name: "Restaurant"), VendoredAirbnbCategory(image: "property4", name: "For Rent")]
    let experiences: [VendoredAirbnbExperiences] = [VendoredAirbnbExperiences(image: "property1", name: "Paris Best Kept Secrets Tour", price: "$170 per person"), VendoredAirbnbExperiences(image: "property2", name: "Silent Disco Beach yoga", price: "$180 per person"), VendoredAirbnbExperiences(image: "property3", name: "Miamo - Amazing view", price: "$100 per person"), VendoredAirbnbExperiences(image: "property4", name: "Comfy Artist's Home", price: "$80 per person")]
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VendoredAirbnbSearchView().shadow(color: Color.gray.opacity(0.4), radius: 4)
                    .padding(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("What can we help you find, Keerthi?")
                            .font(.custom("Helvetica Neue", size: 21))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black.opacity(0.9))
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(self.categories) { item in
                                    VendoredAirbnbCategoriesView(item: item)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        Text("Introducing Airbnb Plus")
                            .font(.custom("Helvetica Neue", size: 21))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black.opacity(0.9))
                        Text("A new selection of homes verified for quality & control")
                            .font(.custom("Helvetica Neue", size: 16))
                            .fontWeight(.regular)
                            .foregroundColor(Color(UIColor.darkGray))
                            .padding(.top, 8)
                        
                        List(self.experiences) { item in
                            NavigationLink(destination: VendoredAirbnbPropertyDetailsView(item: item)) {
                                VendoredAirbnbPropertyView(item: item)
                                    .padding(.horizontal, -10.0)
                            }
                        }
                        .frame(height: CGFloat(self.experiences.count) * CGFloat(270))
                    }.padding(.horizontal, 20)
                }.environment(\.defaultMinListRowHeight, 270)
            }
            .navigationBarTitle(Text("Airbnb Clone").bold(), displayMode: .inline)
        }
    }
}

struct VendoredAirbnbPropertyView: View {
    var item: VendoredAirbnbExperiences
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(self.item.image)
                    .resizable()
                    .cornerRadius(6.0)
                    .frame(height: 180)
                Text("ENTIRE HOUSE - 1 BED")
                    .foregroundColor(Color.red)
                    .font(.system(size: 10))
                .fontWeight(.medium)
                Text(self.item.name)
                    .font(.system(size: 18))
                    .fontWeight(.regular)
                Text(self.item.price)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor.darkGray))
                HStack(alignment: .top) {
                    ForEach((0...4), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12.0, height: 12.0)
                            .foregroundColor(Color.red.opacity(0.8))
                            .padding(.horizontal, -4.0)
                    }
                    Text("5")
                        .font(.system(size: 11))
                    .fontWeight(.regular)
                    .foregroundColor(Color(UIColor.darkGray))
                }.padding(.leading, -20.0)
                .frame(width: 90.0, height: 0.0)
                
            }
            .frame(height: geometry.size.height)
        }
    }
}

struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredAirbnbPropertyView(item: VendoredAirbnbExperiences(image: "property1", name: "1", price: "2"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredAirbnbHomeView()
    }
}

struct VendoredAirbnbCategoriesView: View {
    var item: VendoredAirbnbCategory
    var body: some View {
        VStack(spacing: 0) {
            Image(item.image)
                .resizable()
                .frame(width: 130, height: 90)
            Text(item.name)
                .font(.custom("Helvetica Neue", size: 15))
                .foregroundColor(Color.black.opacity(0.9))
                .fontWeight(.regular)
                .padding(.all, 12)
        }
        .background(Color.white)
        .cornerRadius(4.0)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
        .padding(.leading, 2)
    }
}
