//
//  FollowedView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct FollowedView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack(spacing: 20) {
                    navBar
                        .padding(.top,-20)
                    
                    
                    //MARK: aquí tenemos la tabla donde aparece todo lo que busquemos
                    ScrollView(.vertical){

                        LazyVStack {
                            ForEach(viewModel.followed, id: \.uuid) { followed in
                                NavigationLink(destination: OthersProfileView(viewModel: .init(followed: followed))) {
                                    HStack {
                                        
                                        if let imageUrlString = followed.image as? String,
                                           let imageUrl = URL(string: imageUrlString) {
                                            RemoteImage(imageUrl: imageUrl)
                                                .frame(width: 90, height: 90)
                                        } else {
                                            Image("Example")
                                                .foregroundColor(.red)
                                                .frame(width: 90, height: 90)
                                        }

                                        VStack() {
                                            Text(followed.name)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("TextY"))
                                                .lineLimit(1)
                                            
                                        }
                                        Spacer()
                                        
                                    }
                                    .background(.white)
                                    .cornerRadius(15)
                                }
                            }
                        }
                        .shadow(radius: 2)
                    }
                    .padding(10)
                }
            }
            .onAppear(){
                viewModel.getFollowed()
            }

        }
            }
    private  var navBar: some View {
         ZStack {
             HStack()  {
                 Image(systemName: "arrowshape.left.fill")
                     .resizable()
                     .foregroundColor(Color("BackB"))
                     .frame(width: 60, height: 45)
                     .padding(.leading, 10)
                 
                 Spacer()
             }
         }
         .frame(height: 50)
         .background(Color("BackB"))
     }
}



struct FollowedView_Previews: PreviewProvider {
    static var previews: some View {
        FollowedView()
    }
}
