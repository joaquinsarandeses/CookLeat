//
//  PassForView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct PassForView: View {
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
                
                Text("Te enviaremos a tu correo electrónico una contraseña con la que volver a entrar")
                    .multilineTextAlignment(.leading)
                    .frame(height: 80)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30.0)
                
                TextField("Correo electrónico", text: $name)
                    .customDesign()
                    .padding(.top,80)
                
                
                Button{
                    
                }label: {
                    Text("Enviar correo")
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

struct PassForView_Previews: PreviewProvider {
    static var previews: some View {
        PassForView()
    }
}
