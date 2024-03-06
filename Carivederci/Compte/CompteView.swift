//
//  CompteView.swift
//  Carivederci
//
//  Created by Maxime on 28/02/2024.
//

import SwiftUI

struct CompteView: View {
    @State var notification = false
    @EnvironmentObject var appUser : AppUser
    var body: some View {
        GeometryReader {
            geometry in
            VStack(spacing:0){
                NavigationView {
                    ZStack(alignment :.topLeading) {
                        Color("BackgroundColor").ignoresSafeArea()
                        VStack(alignment:.leading){
                            HStack{
                                Spacer()
                                Image(appUser.user!.profil).resizable().scaledToFill().clipShape(Circle()).frame(width: geometry.size.height*0.15, height: geometry.size.height*0.15).padding(.vertical,20)
                                Spacer()
                            }
                            NavigationLink(destination: PasswordView()) { Label("Changer de mot de passe", systemImage: "lock.shield.fill").font(.title3).foregroundColor(Color("AccentColor"))
                            }.background(Color.clear).padding(.horizontal,10).padding(.vertical,5)
                            HStack{
                            Image(systemName: notification ? "bell":"bell.slash").foregroundColor(Color("AccentColor"))
                            Toggle("Notifications", isOn: $notification).foregroundColor(Color("AccentColor"))
                            }.padding(.horizontal,10).padding(.vertical,5)
                            Text("Mes points : \(appUser.user!.score) points").foregroundColor(Color("AccentColor")).padding(.horizontal,10).padding(.vertical,5)
                            Spacer()
                        }.padding()
                    }
                }
            }
            
        }
    }
}

struct CompteView_Previews: PreviewProvider {
    static var previews: some View {
        CompteView()
    }
}
