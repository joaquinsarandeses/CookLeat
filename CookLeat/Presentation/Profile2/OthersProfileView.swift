//
//  Profile2View.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct OthersProfileView: View {

    
    @ObservedObject var viewModel : ViewModel
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    navBar
                    
                    HStack{
                        
                        Image("ProfilePic")
                            .padding(.trailing,20)
                        VStack{
                            Text(viewModel.name)
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .padding(.trailing,70)
                                .foregroundColor(Color("BackBut"))
                                .padding(.bottom,5)
                            
                            HStack{
                                
                                VStack{
                                    Text("\(viewModel.otherProfile.followers)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                    Text("Seguidores")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BackBut"))
                                }
                                .padding(.trailing,40)
                                VStack{
                                    Text("\(viewModel.otherProfile.follows )")
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                    Text("Seguidos")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("BackBut"))
                                }
                                .padding(.trailing,20)
                            }
                        }
                    }
                    Button{
                        
                    }label: {
                        Text("Seguir")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(Color("BackA"))
                            .cornerRadius(30)
                    }.padding(.horizontal,70)
                    
                    
                    
                    ScrollView(.vertical){
                        //MARK: Posts
                        LazyVStack {
                            ForEach(viewModel.othersEvents, id: \.id) { followed in
                                NavigationLink(destination: PostView(viewModel: .init(otherPost: followed))) {
                                    userItem(followed)
                                        .background(.white)
                                        .cornerRadius(15)
                                }
                            }
                        }
                        .shadow(radius: 2)
                    }
                    .padding(10)
                    .padding(10)
                    
                }
            }
        }.navigationBarHidden(true)
            .onAppear(){
                viewModel.getOtherEvents()
            }
    }
    private  var navBar: some View {
        //MARK: TopBar
        VStack{
            ZStack {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                HStack()  {
                    Image(systemName: "arrowshape.left.fill")
                        .resizable()
                        .foregroundColor(Color("BackB"))
                        .frame(width: 60, height: 45)
                        .padding(.leading, 10)
                    Spacer()
                    
                        .padding(.trailing,10)
                }
            }
            .frame(height: 50)
            .background(Color("BackB"))
            
            
            
        }
    }
}

struct OthersProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OthersProfileView(viewModel: .init())
    }
}

private func userItem (_ followed: OthersEventsPresentationModel) -> some View{
    HStack {
        Image("Food")
            .resizable()
            .frame(width: 90, height: 90)
        
        VStack() {
            Text(followed.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("TextY"))
                .lineLimit(1)
            Text(followed.description)
                .font(.subheadline)
                .foregroundColor(Color.black)
            Text(followed.category)
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
}
