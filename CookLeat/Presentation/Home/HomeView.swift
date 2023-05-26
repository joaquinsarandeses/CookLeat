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
                            NavigationLink(destination: PostView(viewModel: .init(recent: recent))) {
                                recentItem(recent)
                                .background()
                                .cornerRadius(10)
                            }
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
                        ForEach(viewModel.liked, id: \.id) { like in
                            NavigationLink(destination: PostView(viewModel: .init(like: like))) {
                                item(like)
                            }
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
    
    
    private func recentItem (_ recent: RecentPresentationModel) -> some View{
        VStack(alignment: .leading) {
            if let imageUrlString = recent.image as? String,
                           let imageUrl = URL(string: imageUrlString) {
                            RemoteImage(imageUrl: imageUrl)
                                .frame(width: 150, height: 100)
                                .cornerRadius(10)
                        } else {
                            Image("food")
                                .foregroundColor(.red)
                                .frame(width: 150, height: 100)
                                .cornerRadius(10)
                        }
            Text(recent.name)
                .font(.headline)
                .foregroundColor(Color("TextY"))
                .padding(5)
                .foregroundColor(Color.black)
            
            Text(recent.category)
                .font(.subheadline)
                .padding([.leading, .bottom], 5.0)
                .foregroundColor(Color.black)
        }
    }
    
    private func item(_ likes: LikePresentationModel) -> some View {
        HStack {
            if let imageUrlString = likes.image as? String,
                           let imageUrl = URL(string: imageUrlString) {
                            RemoteImage(imageUrl: imageUrl)
                                .frame(width: 90, height: 90)
                        } else {
                            Image("food")
                                .foregroundColor(.red)
                                .frame(width: 90, height: 90)
                        }
                        Spacer()
            
            VStack  {
                Text(likes.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextY"))
                    .lineLimit(1)
                Text(likes.user)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                Text(likes.category)
                    .foregroundColor(Color.white)
                    .frame(width: 65, height: 25)
                    .background(.gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
                
            }
            
            Spacer()
            
            Image("Example")
                .resizable()
                .frame(width: 90, height: 90)
        }
        .background(.white)
        .cornerRadius(15)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.home))
    }
}

struct RemoteImage: View {
    @ObservedObject private var imageLoader: ImageLoader
    private var placeholder: Image
    
    init(imageUrl: URL?, placeholder: Image = Image(systemName: "photo")) {
        self._imageLoader = ObservedObject(wrappedValue: ImageLoader(imageUrl: imageUrl))
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            placeholder
                .resizable()
                .scaledToFill()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    init(imageUrl: URL?) {
        guard let imageUrl = imageUrl else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch image data:", error ?? "Unknown error")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
