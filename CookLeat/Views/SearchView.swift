//
//  SearchView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct SearchView: View {
    let options = ["Recetas", "Categorías"]
    @State  var selectedOption = 0
    
    @State var search: String = ""
    @State var showCat: Bool = true
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack(spacing: 20) {
                    navBar
                    
                    TextField("Buscar receta o categoría", text: $search)
                        .customDesign()
                        .shadow(radius: 2)
                    
                    Picker(selection: $selectedOption, label: Text("Escoge una categoría:")) {
                        ForEach(0..<options.count) { index in
                            Text(options[index])
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                        

                              
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
             Text("Buscador")
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
