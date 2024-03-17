//
//  CompteView.swift
//  Carivederci
//
//  Created by Maxime on 28/02/2024.
//

import SwiftUI

struct CompteView: View {
    @AppStorage("notification") var notification : Bool = false
    @EnvironmentObject var appUser : AppUser
    @State var points : Int?
    var body: some View {
        GeometryReader {
            geometry in
            NavigationView {
                ZStack(alignment :.topLeading) {
                    Color("BackgroundColor").ignoresSafeArea()
                    VStack(spacing : 20){
                        HStack{
                            Spacer()
                            VStack{
                                Image(appUser.user!.profil).resizable().scaledToFit().clipShape(Circle())
                                Text(appUser.user!.pseudo).bold().font(.title3)
                                    .foregroundColor(Color("AccentColor"))
                            }
                            .frame(width: geometry.size.height*0.15, height: geometry.size.height*0.25)
                            Spacer()
                        }
                        HStack{
                            NavigationLink(destination: PasswordView()) { Label("Changer de mot de passe", systemImage: "lock.shield.fill")
                                .font(.title3)
                                .foregroundColor(Color("AccentColor"))
                                Spacer()
                            }
                            
                        }.background(Color.clear)
                        HStack{
                            Image(systemName: notification ? "bell":"bell.slash")
                                .foregroundColor(Color("AccentColor"))
                            Toggle("Notifications", isOn: $notification)
                                .font(.title3)
                                .foregroundColor(Color("AccentColor"))
                        }
                        HStack{
                            Text("Mes points : ")
                                .font(.title3)
                                .foregroundColor(Color("AccentColor"))
                            Spacer()
                            Text("\(appUser.user!.score) points")
                                .font(.title3)
                                .foregroundColor(Color("AccentColor"))
                            
                        }
                        if(appUser.user!.isAdmin) {
                            VStack{
                                Text("Generer un QR-Code")
                                    .font(.title3)
                                    .foregroundColor(Color("AccentColor"))
                                TextField("Nombre de points", value: $points, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .font(.title3)
                                    .foregroundColor(Color("AccentColor"))
                                    .padding(.horizontal,5)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                                NavigationLink(destination :
                                                QRCodeView(points: points ?? 0)
                                               ,label: {
                                                Text("Generer").font(.title3)
                                                    .foregroundColor(Color("AccentColor"))
                                                    .padding(5)
                                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("Button")))
                                               })
                            }
                            
                        }
                        Spacer()
                        VStack{
                            Text("L'association Carivederci est responsable du traitement des données nécessaires au fonctionnement de l'application")
                                .font(.footnote)
                                .foregroundColor(Color("AccentColor"))
                            Text("Plus d'informations en cliquant ici").bold()
                                .font(.footnote)
                                .foregroundColor(Color("AccentColor"))
                                .onTapGesture {
                                    getRGPD()
                                }
                            
                        }
                    }.padding(.horizontal,15)
                }
            }
        }
    }
}

struct CompteView_Previews: PreviewProvider {
    static var previews: some View {
        CompteView().environmentObject(AppUser(user : User(id: "1234-ABCD", pseudo: "Test",score: 1024, profil: "PP2",isAdmin: true)))
        
    }
}

func getRGPD(){
    DispatchQueue.main.async {
        let url = URL(string: "https://www.sujetdebac.fr%2Fannales-pdf%2F2023%2Fspe-mathematiques-2023-centres-etranger-1-sujet-officiel.pdf&usg=AOvVaw2Wl5BMI8CZoiqUjOdknPBS&opi=89978449")
        let pdfData = try? Data.init(contentsOf: url!)
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let pdfNameFromUrl = "Carivederci-RGPD.pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try pdfData?.write(to: actualPath, options: .atomic)
            print("pdf successfully saved!")
        } catch {
            print("Pdf could not be saved")
        }
    }
    
}

