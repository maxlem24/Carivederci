//
//  ChatView.swift
//  Carivederci
//
//  Created by Maxime on 17/01/2024.
//

import SwiftUI

let me = User(pseudo :"Test",profil:Image("PP1"))

struct ChatView: View {
    @State private var texts: [Message] = [Message(content: "isdqhiohihiqshihsqiihsihihqsiohsihish12345567712345723456723456723456782345678232457834578345678345678345678", user: User(pseudo:"Player 2",profil: Image("PP2")))]
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0){
                ChatHeader(geometry: geometry)
                ScrollViewReader {
                    scrollViewProxy in
                    ScrollView{
                        ForEach(texts, id: \.time) { message in // show received results
                            message
                            
                        }.padding().frame(width: geometry.size.width, height: geometry.size.height*0.8, alignment : .top)// << important !!
                        .edgesIgnoringSafeArea(.bottom)
                        .animation(.easeOut(duration: 0.16))
                    }.onChange(of: texts.count, perform: { count in
                        scrollViewProxy.scrollTo(texts.last, anchor: .bottom)
                    }).background(Rectangle().fill(Color("CalendarBackground")))
                }
                
                ChatInput(geometry: geometry, texts : $texts)}
        }.background(Color("BackgroundColor"))
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

struct ChatHeader: View {
    let geometry : GeometryProxy
    var body: some View {
        VStack{
            Text("Famille Test (Pas Encore Fini)")
        }.frame(width: geometry.size.width, height: geometry.size.height*0.1).background(Color("TitleColor"))
    }
}

struct ChatInput : View {
    let geometry : GeometryProxy
    @State private var message : String = ""
    @Binding var texts: [Message]
    var body: some View {
        TextField(
            "Message",
            text : $message
        ).onChange(of: message){ value in
            add(content: value)
        }// onSubmit IOS14
        .padding().autocapitalization(.none)
        .disableAutocorrection(true)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        
    }
    func add(content : String) -> Void {
        let message = Message( content: content,user : me)
        self.texts.append(message)
    }
}


struct Message : View, Hashable{
    let time = Date()
    let content : String
    let user : User
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(time)
    }
    private var dateFormatter : DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEE, HH:mm:ss"
        return dateFormat
    }
    var body: some View {
        HStack{
            if me != user {
                user.profil.resizable().scaledToFill().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke()).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            VStack{
                Text(content).font(.body).frame(maxWidth : .infinity, alignment : .leading)
                Text(dateFormatter.string(from: time)).font(.footnote).frame(maxWidth : .infinity, alignment : .trailing)
            }.padding(7).frame( minHeight:50).background(Rectangle().fill(me == user  ? Color("Button"): Color("ActiviteBackground")).cornerRadius(10))
            
        }.padding(5).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        
        
        
        
    }
}
