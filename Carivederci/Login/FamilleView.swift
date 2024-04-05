//
//  FamilleView.swift
//  Carivederci
//
//  Created by Maxime on 17/02/2024.
//

import SwiftUI

struct FamilleView: View {
    @EnvironmentObject var appUser : AppUser
    @State var abbvFamille : String = ""
    @State var abbvFamilleError : String = ""
    @State var nomFamille : String = ""
    @State var nomFamilleError : String = ""
    @State var password : String = ""
    @State var passwordError : String = ""
    let newFamily : Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("Bordeaux").ignoresSafeArea()
                VStack(alignment : .leading){
                    HStack{
                        Spacer()
                        Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                        Spacer()
                    }
                    ScrollView{
                        if newFamily {
                            FieldView(nom: "Abbreviation de la famille", field: $abbvFamille, errorField: $abbvFamilleError, width: geometry.size.width*0.9)
                        }
                        FieldView(nom: "Nom de la famille", field: $nomFamille, errorField: $nomFamilleError, width: geometry.size.width*0.9)
                        FieldView(nom: "Mot de passe", field: $password, errorField: $passwordError, width: geometry.size.width*0.9, isSecure: true)
                    }
                    HStack{
                        Spacer()
                        Button{
                            checkFields()
                        } label :{
                            Image(systemName: "arrow.right").resizable().foregroundColor(Color("RoseBlanc")).padding(5)
                        }.scaledToFill().frame(width: geometry.size.width*0.1,height : geometry.size.width*0.1).padding(5)
                        .background(Circle().fill(Color("Taupe")))
                        Spacer()
                    }
                    Spacer()
                    
                }.padding()
            }
        }
    }
    func checkFields() {
        if newFamily {
            abbvFamilleError = isValidAbbreviation(abbvFamille) ? "" : "L'abbréviation doit être uniquement composée de 3 lettres"
        }
        nomFamilleError = isValidPseudo(nomFamille) ? "" : "Nom de Famille invalide : il doit contenir au moins 6 caractères et pas de caractère spéciaux"
        passwordError = isValidPassword(password) ? "" : "Mot de passe invalide : il doit contenir au moins 8 caractères, avec une majuscule, une minuscule, un chiffre et un caractère spécial"
        if abbvFamilleError == "" && nomFamilleError == "" && passwordError == "" {
            appUser.user?.famille = Famille(nom: nomFamille, abbv: abbvFamille.uppercased(), score: 0)
        }
    }
}
