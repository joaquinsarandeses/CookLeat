//
//  FollowedView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct FollowedView: View {
    @State var search: String = ""
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack(spacing: 20) {
                    navBar
                    
                    TextField("Buscar...", text: $search)
                        .customDesign()
                        .shadow(radius: 2)
                    //MARK: aquí tenemos la tabla donde aparece todo lo que busquemos
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
    }
    private  var navBar: some View {
         ZStack {
             Text("Seguidos")
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
