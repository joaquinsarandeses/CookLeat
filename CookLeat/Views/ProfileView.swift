//
//  ProfileView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State var followers: Int = 0
    @State var followed: Int = 0
    @State var userName: String = "Aprobadme"
    var body: some View {
        ZStack{
            VStack{
                navBar
                
                HStack{
                    
                    Image("ProfilePic")
                        .padding(.trailing,20)
                    VStack{
                        Text("\(userName)")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .padding(.trailing,70)
                            .foregroundColor(Color("BackBut"))
                            .padding(.bottom,5)
                        
                        HStack{
                            
                            VStack{
                                Text("\(followers)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 30))
                                Text("Seguidores")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("BackBut"))
                            }
                            .padding(.trailing,40)
                            VStack{
                                Text("\(followers)")
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
                Spacer()
                
                ScrollView(.vertical){
                    
                    LazyVStack {
                        ForEach(data, id: \.id) { cell in
                            HStack {
                                cell.image
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                
                                VStack() {
                                    Text(cell.title)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("TextY"))
                                        .lineLimit(1)
                                    Text(cell.subtitle)
                                        .font(.subheadline)
                                    Text(cell.cat)
                                        .foregroundColor(Color.white)
                                        .frame(width: 60, height: 20)
                                        .background(.gray)
                                        .cornerRadius(10)
                                    
                                }
                                Spacer()
                                cell.examp
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
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 45)
                        .padding(.leading, 10)
                    Spacer()
                    
                    Button(action: {
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing,10)
                }
            }
            .frame(height: 50)
            .background(Color("BackB"))
            
            
            
        }
     }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
