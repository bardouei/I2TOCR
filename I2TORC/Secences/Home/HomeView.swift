//
//  Home.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab = "house"
    var body: some View {
        VStack {
            DataListView()
            TabBarView()
        }
        .background(Color(uiColor: Colors.grayDark))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
