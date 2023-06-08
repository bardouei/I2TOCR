//
//  DataModel.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import Foundation

struct FileOCR: Identifiable {
    var id: Int
    var name: String
    var date: String
    var image: String
    
    static var simple: [FileOCR] {
        [
            FileOCR(id: 1, name: "1", date: "", image: ""),
            FileOCR(id: 2, name: "2", date: "", image: ""),
            FileOCR(id: 3, name: "3", date: "", image: ""),
            FileOCR(id: 4, name: "4", date: "", image: "")
        ]
    }
}
