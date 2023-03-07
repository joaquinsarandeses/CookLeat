//
//  PostView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct PostView: View {
    let viewModel: ViewModel
    var body: some View {
        ZStack{
            VStack (spacing: 20){
                navBar
                    .padding(.top,-20)
                HStack{
                    
                    Image("ProfilePic")
                        .padding(.leading)
                    
                    VStack{
                        Text(viewModel.user)
                            .font(.system(size: 20))
                            .lineLimit(1)
                            .padding(.trailing,70)
                            .foregroundColor(Color("BackBut"))
                        
                        Text(viewModel.name)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .padding(.trailing,70)
                            .foregroundColor(Color("BackBut"))
                        
                        Text(viewModel.category)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .padding(.trailing,70)
                            .foregroundColor(Color("BackA"))
                            .padding(.bottom,5)
                        
                        
                        
                        
                    }
                }
                
                
                VStack() {
                    ZStack{
                        
                        Rectangle()
                            .frame(height: 260.0)
                            .frame(width: 340)
                            .foregroundColor(Color("BackB"))
                            .cornerRadius(5)
                        
                        Text(viewModel.description)
                            
                            .multilineTextAlignment(.leading)
                            .scrollDisabled(false)
                            .padding(.bottom,200)
                            .frame(height: 250.0)
                            .frame(width: 320)
                            .padding(.horizontal, 10)
                            .scrollDisabled(false)
                        
                        
                            
                        
                    }
                  Image("Example")
                        .resizable()
                        .frame(height: .infinity)
                        .frame(width: 350)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
    private  var navBar: some View {
        ZStack {
            Text("Receta")
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
            }
        }
        .frame(height: 50)
        .background(Color("BackB"))
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(viewModel: .init())
    }
}
