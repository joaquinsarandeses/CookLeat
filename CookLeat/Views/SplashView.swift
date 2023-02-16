//
//  SplashView.swift
//  CookLeat
//
//  Created by joaquin sarandeses on 16/2/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
                    // 2.
                    if self.isActive {
                        // 3.
                        ContentView()
                    } else {
                        // 4.
                        ZStack{
                            Rectangle()
                                .background(Color("BackA"))
                                .foregroundColor(Color("BackA"))
                            Image("logo")
                                .resizable()
                                .frame(width: 180,height: 150)
                        }
                    }
                }
        .background(Color("BackA"))
      
       
                // 5.
                .onAppear {
                    // 6.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        // 7.
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
