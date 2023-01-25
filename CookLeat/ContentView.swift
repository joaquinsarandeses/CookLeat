//
//  ContentView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        
        
        NavigationView{
            ZStack {
                if self.isActive{
                    Text("Hola")
                }else{
                    Rectangle()
                        .foregroundColor(Color("BackY"))
                        .background(Color("BackY"))
                    Image("Splash")
                }
                
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline:
                        .now() + 2.5){
                            withAnimation{
                                self.isActive = true
                            }
                        }
                
            }
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
