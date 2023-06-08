//
//  DataListView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/7/23.
//

import SwiftUI

struct DataListView: View {
    @State private var simpleData = FileOCR.simple
    var body: some View {
        ZStack {
            Color(uiColor: Colors.grayDark)
                .ignoresSafeArea()
            
//            Table(simpleData) {
//                TableColumn("name", value: \.name)
//            }
        }
    }
}

struct DataListView_Previews: PreviewProvider {
    static var previews: some View {
        DataListView()
    }
}
