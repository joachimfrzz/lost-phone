//
//  VendoredDisneyHorizontalList.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

struct VendoredDisneyHorizontalList: View {
    @EnvironmentObject var homeVM: VendoredDisneyHomeViewModel
    private let _group: VendoredDisneyListGroup
    private var moviePosters = [Image]()
    
    init(group: VendoredDisneyListGroup) {
        self._group = group
        self.moviePosters = group.list
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: -5) {
            Text(_group.title)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(moviePosters, id: \.id) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 140, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width,
            height: 160)
            .padding(.horizontal, -15)
        }
    }
}

struct HorizontalList_Previews: PreviewProvider {
    static var previews: some View {
        VendoredDisneyHorizontalList(group: VendoredDisneyListGroup.recommendation)
    }
}
