//
//  CompteView.swift
//  Carivederci
//
//  Created by Maxime on 28/02/2024.
//

import SwiftUI

struct CompteView: View {
    @ObservedObject var sharedPoints = SharedPoints.shared
    @AppStorage("notification") var notification : Bool = false
    @EnvironmentObject var appUser : AppUser
    @State var points : Int?
    @State var showMessage : Bool = false
    var body: some View {
        GeometryReader {
            geometry in
            ZStack{
                Color("BlancRosé").ignoresSafeArea()
                VStack{
                    Text("Compte").font(.title).foregroundColor(Color("Marron")).padding()
                        .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                        .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                    NavigationView {ZStack{
                        Color("BlancRosé").ignoresSafeArea()
                        VStack(spacing : 20){
                            Spacer()
                            HStack{
                                Spacer()
                                Text(appUser.user?.pseudo ?? "Error").bold().font(.title3)
                                    .foregroundColor(Color("Marron"))
                                Spacer()
                            }
                            HStack{
                                NavigationLink(destination: PasswordView()) { Label("Changer de mot de passe", systemImage: "lock.shield.fill")
                                    .font(.title3)
                                    .foregroundColor(Color("Marron"))
                                    Spacer()
                                }
                            }
                            HStack{
                                Image(systemName: notification ? "bell":"bell.slash")
                                    .foregroundColor(Color("Marron"))
                                Toggle("Notifications", isOn: $notification)
                                    .font(.title3)
                                    .foregroundColor(Color("Marron"))
                            }
                            HStack{
                                Text("Mes points : ")
                                    .font(.title3)
                                    .foregroundColor(Color("Marron"))
                                Spacer()
                                Text("\(appUser.user?.score ?? -1) points")
                                    .font(.title3)
                                    .foregroundColor(Color("Marron"))
                                
                            }
                            if(appUser.famille != nil)
                            {
                                Button{
                                    showMessage = true
                                }label :{
                                    Text("Quitter la Famille").font(.title3).bold()
                                        .foregroundColor(Color("RoseBlanc")).padding(5)
                                }.frame(width: geometry.size.width*0.9)
                                .background(Rectangle().fill(Color("Bordeaux")).cornerRadius(10))
                            }
                            if(appUser.user?.isAdmin ?? false) {
                                VStack{
                                    Text("Generer un QR-Code")
                                        .font(.title3)
                                        .foregroundColor(Color("Marron"))
                                    TextField("Nombre de points", value: $points, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .font(.title3)
                                        .foregroundColor(Color("Marron"))
                                        .padding(.horizontal,5)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Marron")))
                                    NavigationLink(destination :
                                                    QRCodeView()
                                    ){
                                        Text("Generer").font(.title3)
                                            .foregroundColor(Color("BlancRosé"))
                                            .padding(5)
                                            .frame(width: geometry.size.width*0.9)
                                            .background(RoundedRectangle(cornerRadius: 10)
                                                            .fill(Color("Bordeaux")))
                                    }
                                }
                            }
                            Spacer()
                            VStack{
                                Text("L'association Carivederci est responsable du traitement des données nécessaires au fonctionnement de l'application")
                                    .font(.footnote)
                                    .foregroundColor(Color("Marron"))
                                Text("Plus d'informations en cliquant ici").bold()
                                    .font(.footnote)
                                    .foregroundColor(Color("Marron"))
                                    .onTapGesture {
                                        getRGPD()
                                    }
                            }
                            Spacer()
                        }.padding(.horizontal,15)
                    }
                    
                    }.accentColor(Color("Marron"))
                    .allowsHitTesting(!showMessage)
                    
                }
                if (showMessage) {
                    VStack(alignment : .leading) {
                        Text("Voulez vous vraiment abandonner votre famille ?")
                            .foregroundColor(Color("Marron")).padding(5)
                        Text("Vous allez remis sur l'écran de selection des familles")
                            .foregroundColor(Color("Marron")).padding(5)
                        HStack{
                            Spacer()
                            Button{
                                showMessage = false
                                appUser.famille = nil
                            }label :{
                                Text("Oui").bold().foregroundColor(Color("Marron")).padding(5)
                            }.scaledToFill()
                            Button{
                                showMessage = false
                            }label :{
                                Text("Non").bold().foregroundColor(Color("Marron")).padding(5)
                            }.scaledToFill()
                            Spacer()
                        }
                    }.padding().background(Rectangle().fill(Color("Rose")).cornerRadius(10)).frame(width: geometry.size.width*0.9).navigationBarBackButtonHidden(showMessage)
                }
            }
        }
    }
}


struct CompteView_Previews: PreviewProvider {
    static var previews: some View {
        CompteView().environmentObject(AppUser(user : User(id: "1234-ABCD", pseudo: "Test",score: 1024,isAdmin: true)))
        
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

