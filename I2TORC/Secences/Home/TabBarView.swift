//
//  CustomTabBar.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/6/23.
//


import SwiftUI

struct TabBarView: View {
    let viewControllers: [UIViewController] = [
           UIHostingController(rootView: Text("Page 1")),
           UIHostingController(rootView: Text("Page 2")),
           UIHostingController(rootView: Text("Page 3"))
       ]
    
    var body: some View {
        
        ZStack {
            backgroundView
            TabsLayoutView()
                .frame(height: 70, alignment: .center)
                .clipped()
        }
        .frame(height: 80, alignment: .center)
        .padding(.horizontal)
    }
    
    @ViewBuilder private var backgroundView: some View {
        
        LinearGradient(colors: [.init(white: 0.4), .black], startPoint: .top, endPoint: .bottom)
        
            .mask {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(lineWidth: 6)
            }
        Color(uiColor: Colors.graylight)
            .ignoresSafeArea()
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 8)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

fileprivate struct TabsLayoutView: View {
    @State var selectedTab: Tab = .home
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .frame(width: 55, height: 55, alignment: .center)
                
                Spacer(minLength: 0)
            }
        }
    }
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        @State private var selectedIndex = 0
        
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)) {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(
                                Color.white
                            )
                            .overlay(content: {
                                LinearGradient(colors: [Color(uiColor: Colors.graylight).opacity(0.0001), tab.color.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                            })
                            .shadow(color: .white, radius: 10, x: -7, y: -7)
                            .shadow(color: tab.color.opacity(0.7), radius: 10, x: 8, y: 8)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? tab.color : Color(uiColor: Colors.grayDark))
                        .scaleEffect(isSelected ? 1.3 : 0.9)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                }
            }
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
