//
//  HomeView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct Cell: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let subtitle: String
    let examp: Image
    let cat: String
}

let data: [Cell] = [
    Cell(image: Image("logo"), title: "Title 1", subtitle: "Subtitle 1",examp: Image("Example"), cat: "Postre"),
    Cell(image: Image("logo"), title: "Title 2", subtitle: "Subtitle 2",examp: Image("Example"),cat: "Postre"),
    Cell(image: Image("logo"), title: "Title 3", subtitle: "Subtitle 3",examp: Image("Example"),cat: "Postre"),
    Cell(image: Image("logo"), title: "Title 4", subtitle: "Subtitle 4",examp: Image("Example"),cat: "Postre"),
    Cell(image: Image("logo"), title: "Title 5", subtitle: "Subtitle 5",examp: Image("Example"),cat: "Postre"),
    Cell(image: Image("logo"), title: "Title 6", subtitle: "Subtitle 6",examp: Image("Example"),cat: "Postre"),
    Cell(image: Image("logo"), title: "Title 7", subtitle: "Subtitle 7",examp: Image("Example"),cat: "Postre")
]

struct Recent: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let subtitle: String
    let examp: Image
    let cat: String
}


struct HomeView: View {
    @ObservedObject var viewModel = ViewModel()
    @Binding var selectedTab: TabViewList
    
    var body: some View {
        ZStack{
            VStack{
                navBar
                //MARK: Primera tabla
                HStack(alignment: .bottom) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("BackA"))
                        .padding(5)
                    //                        .onTapGesture {
                    //                            selectedTab = .search
                    //                        }
                    // ejemplo navegación tab
                    
                    
                    Text("Añadidos recientemente")
                        .fontWeight(.bold)
                        .foregroundColor(Color("BackA"))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(5)
                    
                    Spacer()
                    
                }
                
                ScrollView(.horizontal){
                    LazyHStack {
                        ForEach(viewModel.recents, id: \.id) { recent in
                            VStack(alignment: .leading) {
                                Image("logo")
                                    .resizable()
                                    .frame(width: 150, height: 100)
                                    .cornerRadius(10)
                                Text(recent.name)
                                    .font(.headline)
                                    .foregroundColor(Color("TextY"))
                                    .padding(5)
                                
                                Text(recent.category)
                                    .font(.subheadline)
                                    .padding([.leading, .bottom], 5.0)
                            }
                            .background()
                            .cornerRadius(10)
                            
                        }
                        .shadow(radius: 3)
                    }
                    .padding(.leading,10)
                    .frame(height: 170)
                    
                }
                //MARK: Segunda tabla
                HStack(alignment: .bottom) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("BackA"))
                        .padding(5)
                    
                    Text("Recetas que te gustan")
                        .fontWeight(.bold)
                        .foregroundColor(Color("BackA"))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(5)
                    
                    Spacer()
                    
                }
                
                .padding(.trailing,120)
                ScrollView(.vertical){
                    
                    LazyVStack {
                        ForEach(viewModel.liked, id: \.id) { likes in
                            HStack{
                                Image("logo")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                
                                VStack() {
                                    Text(likes.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("TextY"))
                                        .lineLimit(1)
                                    Text(likes.user)
                                        .font(.subheadline)
                                    Text(likes.category)
                                        .foregroundColor(Color.white)
                                        .frame(width: 60, height: 20)
                                        .background(.gray)
                                        .cornerRadius(10)
                                    
                                }
                                
                                Spacer()
                                
                                Image("logo")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                            }
                            .background(.white)
                            .cornerRadius(15)
                            
                        }
                        
                    }
                    .shadow(radius: 2)
                }
                
                .padding(10)
                
                
            }
        }
        .onAppear(){
            viewModel.getRecent()
            viewModel.getLiked()
        }
    }
    private  var navBar: some View {
        ZStack {
            Text("Home")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            HStack()  {
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 45)
                    .padding(.leading, 10)
                Spacer()
            }
        }
        .frame(height: 50)
        .background(Color("BackB"))
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.home))
    }
}
