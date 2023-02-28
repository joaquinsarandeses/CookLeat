//
//  RegisterView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 13/2/23.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State var name: String = ""
    @State var password: String = ""
    @State var reppassword: String = ""
    @State var email: String = ""
    @State var showAlert: Bool = false
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
                TextField("Correo electrónico", text: $email)
                    .customDesign()
                    .padding(.top,5)
                TextField("Contraseña", text: $password)
                    .customDesign()
                    .padding(.top,5)
                TextField("Repite tu contraseña", text: $reppassword)
                    .customDesign()
                    .padding(.top,5)
                    
                Button{
                        viewModel.register(name: name,email: email, password: password)
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
                    .padding(.top,60)
                    .padding(.bottom,50)
                
            }
            ZStack {
                NavigationLink(destination: CustomTab(), isActive: $viewModel.shouldShowHome) {
                    EmptyView()
                }
                .hidden()
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
