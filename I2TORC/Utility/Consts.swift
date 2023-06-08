//
//  Consts.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI
import UIKit

// Enums
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
            return "bolt.fill"
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
            return Color(uiColor: Colors.lightedBlue)
        case .camera:
            return Color(uiColor: Colors.lightedBlue)
        case .home:
            return Color(uiColor: Colors.lightedBlue)
        }
    }
}

// Colors
struct Colors {
    static let white           = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let black           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let clear           = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    static let grey2           = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    static let grey3           = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
    static let grey4           = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    static let grey5           = #colorLiteral(red: 0.2156862745, green: 0.2196078431, blue: 0.2431372549, alpha: 1)
    static let grey6           = #colorLiteral(red: 0.1333333333, green: 0.137254902, blue: 0.1529411765, alpha: 1)
    static let grey7           = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
    static let grey9           = #colorLiteral(red: 0.3647058824, green: 0.3450980392, blue: 0.3294117647, alpha: 1)
    static let grey1           = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    static let grey8           = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2034770637)
    
    static let lightBlue       = #colorLiteral(red: 0.431372549, green: 0.7215686275, blue: 1, alpha: 1)
    static let blue            = #colorLiteral(red: 0.09803921569, green: 0.5764705882, blue: 1, alpha: 1)
    static let highlightedBlue = #colorLiteral(red: 0.003921568627, green: 0.4352941176, blue: 0.8470588235, alpha: 1)
    static let green           = #colorLiteral(red: 0.6, green: 0.7568627451, blue: 0.3019607843, alpha: 1)
    static let darkGreen       = #colorLiteral(red: 0.4509803922, green: 0.568627451, blue: 0.2274509804, alpha: 1)
    static let yellow          = #colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1)
    static let orange          = #colorLiteral(red: 0.9411764706, green: 0.5176470588, blue: 0.3254901961, alpha: 1)
    static let lightRed        = #colorLiteral(red: 0.9209958911, green: 0.6254754663, blue: 0.6171939373, alpha: 1)
    static let red             = #colorLiteral(red: 0.8509803922, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
    static let darkRed         = #colorLiteral(red: 0.6705882353, green: 0.2823529412, blue: 0.2823529412, alpha: 1)
    
    static let grayDark        = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.137254902, alpha: 1)
    static let graylight       = #colorLiteral(red: 0.1882352941, green: 0.2117647059, blue: 0.2705882353, alpha: 1)
    static let lightedBlue     = #colorLiteral(red: 0.2352941176, green: 0.4274509804, blue: 0.9607843137, alpha: 1)
    static let blackDark       = #colorLiteral(red: 0.09411764706, green: 0.1019607843, blue: 0.1137254902, alpha: 1)
}
