//
//  I2TORCApp.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import SwiftUI

@main
struct I2TORCApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}



enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case doc, camera, home
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .doc:
            return "doc.fill"
        case .camera:
            return "doc.fill"
        case .home:
            return "person.crop.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .doc:
            return "Home"
        case .camera:
            return "Doc"
        case .home:
            return "Account"
        }
    }
    
    var color: Color {
        switch self {
        case .doc:
            return Color(uiColor: Colors.highlightedBlue2)
        case .camera:
            return Color(uiColor: Colors.highlightedBlue2)
        case .home:
            return Color(uiColor: Colors.highlightedBlue2)
        }
    }
}
