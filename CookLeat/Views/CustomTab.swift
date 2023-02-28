//
//  CustomTab.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI
enum TabViewList{
    case home
    case search
    case addPost
    case profile
    
}
struct CustomTab: View {
    
    @State private var selectedTab: TabViewList = .home
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("BackA"))
    }
    
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab){
                HomeView(selectedTab: $selectedTab)
                    .tag(TabViewList.home)
                    .tabItem {
                        Label {
                            Text("Home")
                        } icon: {
                            Image(systemName: "homekit")
                        }
                        
                    }
                
                SearchView()
                    .tag(TabViewList.search)
                    .tabItem {
                        Label {
                            Text("Search")
                        } icon: {
                            Image(systemName: "magnifyingglass")
                        }
                        
                    }
                
                AddPostView()
                    .tag(TabViewList.addPost)
                    .tabItem {
                        Label {
                            Text("Add Post")
                        } icon: {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                
                ProfileView()
                    .tag(TabViewList.profile)
                    .tabItem {
                        Label {
                            Text("Profile")
                        } icon: {
                            Image(systemName: "person.fill")
                        }
                    }
            }
            
            .accentColor(.white)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CustomTab_Previews: PreviewProvider {
    static var previews: some View {
        CustomTab()
    }
}
