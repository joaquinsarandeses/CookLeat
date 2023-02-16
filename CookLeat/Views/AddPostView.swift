//
//  AddPostView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct AddPostView: View {
    @State var postname: String = ""
    @State var description: String = ""
    let options = ["Vegana", "Carne", "Repostería", "Mar", "Pasta","Dulce", "Otro"]
    @State  var selectedOption = 0
    
    
    var body: some View {
        ZStack{
            VStack (spacing: 20){
                navBar
                
                
                TextField("Buscar receta o categoría", text: $postname)
                    .customDesign()
                    .shadow(radius: 2)
                
                
                VStack() {
                    TextField("Descripción de tu nueva receta", text: $description)
                        .padding(.bottom,200)
                        .frame(height: 250.0)
                        .padding(.horizontal, 10)
                        .background(Color("BackTF"))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .scrollDisabled(false)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: UIScreen.main.bounds.size.width-18, height: 32)
                            .foregroundColor(Color("BackBut"))
                        Picker(selection: $selectedOption, label: Text("Escoge una categoría:")) {
                            ForEach(0..<options.count) { index in
                                Text(options[index])
                                
                            }
                            .foregroundColor(.white)
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                        
                    }
                    .background(Color("BackPick"))
                    .cornerRadius(20)
                    .frame(width:UIScreen.main.bounds.size.width-18)
                    .padding(.top,20)
                    
                    
                    HStack{
                        Button(action: {
                        }) {
                            Image("PostPic")
                                .foregroundColor(.red)
                                .frame(width: 150, height: 150)
                        }
                        .background(Color("BackA"))
                        .cornerRadius(15)
                        .padding(.leading)
                        
                        Button{
                            
                        }label: {
                            Text("Publicar")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(height: 110)
                                .frame(width: 110)
                                .frame(maxWidth: .infinity)
                                .background(Color("BackBut"))
                                .cornerRadius(10)
                                .padding(.trailing)
                        }
                        .frame(height: 100)
                    }
                    .padding(.top,20)
                }
                
                Spacer()
            }
        }
    }
    private  var navBar: some View {
        ZStack {
            Text("Crear Post")
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

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}
