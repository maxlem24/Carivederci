//
//  ScoreboardView.swift
//  Carivederci
//
//  Created by Maxime on 07/01/2024.
//

import SwiftUI

struct ScoreboardView: View {
    @State private var jour = Jours.Lundi
    @State private var familleList : FamilleList?
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color("BackgroundColor")
                LazyVStack{
                    Text("Classement des familles").font(.title).frame(width: geometry.size.width, height: geometry.size.height/10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Rectangle().fill(Color("Header"))).padding(.bottom,10)
                    Podium(geometry: geometry,familleList: familleList)
                    Scoreboard(geometry: geometry)
                    
                    
                }.padding()
                .frame(alignment:.top)
            }.ignoresSafeArea()
            
            
        }
        
    }
    
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}


struct Podium : View {
    let geometry : GeometryProxy
    var familleList : FamilleList?
    var body: some View {
        let widthPodium = geometry.size.width*0.9
        HStack(alignment: .bottom,spacing:0){
            VStack(spacing: -20){
                Spacer()
                // AsyncImage(url : URL()) { image in
                // image.methodeDeco} placeholder : { cas vide}
                Image("PP2").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke()).frame(width: geometry.size.width/5, height: geometry.size.width/5).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                VStack(spacing:5){
                    Text("Teamname").bold()
                    Text("1892").bold().foregroundColor(Color("Silver"))
                }.cornerRadius(12).frame(width: widthPodium/3,height: geometry.size.height/8).background(
                    Rectangle().fill(Color("TitleColor")).cornerRadius(12))
                
                
            }.frame(width: widthPodium/3, height: geometry.size.height/4)
            VStack(spacing: -20){
                Spacer()
                Image("PP1").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke()).frame(width: geometry.size.width/5, height: geometry.size.width/5).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                VStack(spacing:5){
                    Text("Teamname").bold()
                    Text("2435").bold().foregroundColor(.yellow)
                }.cornerRadius(12).frame(width: widthPodium/3,height: geometry.size.height/6).background(
                    Rectangle().fill(Color("CalendarBackground")).cornerRadius(12))
                
                
            }.frame(width: widthPodium/3, height: geometry.size.height/4)
            VStack(spacing: -20){
                Spacer()
                Image("PP3").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke()).frame(width: geometry.size.width/5, height: geometry.size.width/5).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                VStack(spacing:5){
                    Text("Teamname").bold()
                    Text("1515").bold().foregroundColor(Color("Bronze"))
                }.cornerRadius(12).frame(width: widthPodium/3,height: geometry.size.height/9).background(
                    Rectangle().fill(Color("TitleColor")).cornerRadius(12))
                
            }.frame(width: widthPodium/3, height: geometry.size.height/4)
        }.frame(width: widthPodium)
    }
}

struct Scoreboard : View {
    var geometry : GeometryProxy
    var body: some View {
        ScrollView(){
            ForEach(1..<20){ _ in
                HStack(){
                    Image("PP1").resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke()).frame(width: geometry.size.width/10, height: geometry.size.width/10)
                    Spacer()
                    Text("Teamname").bold()
                    Spacer()
                    Text("1413")
                    
                    
                }.padding().frame(width: geometry.size.width*0.9,height: geometry.size.height/10).background(Rectangle().fill(Color("Header")))
            }
            
        }
        
    }
}
