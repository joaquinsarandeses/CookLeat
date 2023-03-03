//
//  Profile2View.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct Profile2View: View {
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
                    Image(systemName: "arrowshape.left.fill")
                        .resizable()
                        .foregroundColor(Color.white)
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

struct Profile2View_Previews: PreviewProvider {
    static var previews: some View {
        Profile2View()
    }
}
