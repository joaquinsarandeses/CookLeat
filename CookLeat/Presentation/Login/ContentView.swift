//
//  ContentView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    @State var name: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView { // wrap the VStack in a NavigationView
            ZStack {
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
                    SecureField("Contraseña", text: $password)
                        .customDesign()
                        .padding(.top,5)
                    NavigationLink{
                        PassForView()
                    }label:{
                        Text("¿Has olvidado tu contraseña?\(Text("Pulsa aquí.").underline())")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 30.0)
                    }
                        
                    Button{
                        viewModel.login(name: name, password: password)
                        // set shouldShowHome to true when the button is pressed
                    } label: {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color("BackBut"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal,30)
                    .padding(.top,30)
                    
                    NavigationLink{
                        RegisterView()
                    }label:{
                        Text("¿No estás registrado?\(Text("Pulsa aquí.").underline())")
                            .foregroundColor(Color.white)
                            .padding(.top,150)
                    }
                }
                
                ZStack {
                    NavigationLink(destination: CustomTab(), isActive: $viewModel.shouldShowHome) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
        }
    }
    
    var bgc: some View {
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