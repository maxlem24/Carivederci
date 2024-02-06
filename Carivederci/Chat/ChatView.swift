//
//  ChatView.swift
//  Carivederci
//
//  Created by Maxime on 17/01/2024.
//

import SwiftUI

struct ChatView: View {
    @State private var texts: [Message] = [Message(content: "Test", myMessage: false)]
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0){
                ChatHeader(geometry: geometry)
                ScrollView{
                    
                    ForEach(texts, id: \.self) { message in // show received results
                        message
                        
                    }.padding().frame(width: geometry.size.width, height: geometry.size.height*0.8, alignment : .top)// << important !!
                    .edgesIgnoringSafeArea(.bottom)
                    .animation(.easeOut(duration: 0.16))
                }.background(Rectangle().fill(Color("CalendarBackground")))
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
        let message = Message( content: content,myMessage: true)
        self.texts.append(message)
    }
}


struct Message : View,Hashable {
    let content : String
    let myMessage : Bool
    var body: some View {
        HStack{
            if myMessage {
                Spacer()
            }
                VStack{
                    Text(content).padding()
                }.background(Rectangle().fill(myMessage ? Color("Button"): Color("ActiviteBackground")).cornerRadius(10)).padding(.horizontal)
            if !myMessage{
                Spacer()
            }
        }
        
        
        
        
    }
}
