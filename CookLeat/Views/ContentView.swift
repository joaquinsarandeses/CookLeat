//
//  ContentView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var name: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack{
            bgc
            VStack {
                
                Image("logo")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 200.0, height: 150.0)
                    .padding(.top,100)
                
                TextField("Nombre de usuario", text: $name)
                    .customDesign()
                    .padding(.top,80)
                TextField("Nombre de usuario", text: $name)
                    .customDesign()
                    .padding(.top,5)
                Text("¿Has olvidado tu contraseña?\(Text("Pulsa aquí.").underline())")
                    .foregroundColor(Color.white)
                    .underline()
                    .padding(.trailing, 30.0)
                    
                Button{
                    
                }label: {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color("BackBut"))
                        .cornerRadius(10)
                }.padding(.horizontal,30)
                    .padding(.top,30)
                
                Text("¿No estás registrado?\(Text("Pulsa aquí.").underline())")
                    .foregroundColor(Color.white)
                    .padding(.top,150)
                
            }
        }
        
    }
    var bgc: some View{
        
        Color("BackA")
            .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct TextFieldModifier : ViewModifier {
    
    func  body(content: Content) -> some View {
        content
            .frame( height: 44.0)
            .padding(.horizontal,10)
            .background(Color("BackTF"))
            .cornerRadius(10)
            .padding(.horizontal, 30)
        
    }
}

extension View{
    func customDesign() -> some View{
        self
            .modifier(TextFieldModifier())
    }
}
