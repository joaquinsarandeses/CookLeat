//
//  RegisterView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 13/2/23.
//

import SwiftUI

struct RegisterView: View {
    @State var name: String = ""
    @State var password: String = ""
    @State var reppassword: String = ""
    @State var mail: String = ""
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
                TextField("Correo electrónico", text: $mail)
                    .customDesign()
                    .padding(.top,5)
                TextField("Contraseña", text: $password)
                    .customDesign()
                    .padding(.top,5)
                TextField("Repite tu contraseña", text: $reppassword)
                    .customDesign()
                    .padding(.top,5)
                    
                Button{
                    
                }label: {
                    Text("Register")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color("BackBut"))
                        .cornerRadius(10)
                }.padding(.horizontal,30)
                    .padding(.top,30)
                
                Text("¿Ya estás registrado?\(Text("Pulsa aquí.").underline())")
                    .foregroundColor(Color.white)
                    .padding(.top,100)
                
            }
        }
        
    }
    var bgc: some View{
        
        Color("BackA")
            .ignoresSafeArea()
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
    
    
    
}
