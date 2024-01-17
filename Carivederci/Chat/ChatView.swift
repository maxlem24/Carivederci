//
//  ChatView.swift
//  Carivederci
//
//  Created by Maxime on 17/01/2024.
//

import SwiftUI

struct ChatView: View {
    @State private var texts: [Message] = []
    var userID : UUID = UUID()
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ChatHeader(geometry: geometry)
                ScrollView{
                    VStack(alignment: .leading) {
                        ForEach(texts, id: \.self) { message in // show received results
                            message
                        }
                    }.frame(maxWidth: .infinity)  // << important !!
                    .padding()
                    .edgesIgnoringSafeArea(.bottom)
                    .animation(.easeOut(duration: 0.16))
                }
                ChatInput(geometry: geometry,userID : userID, texts : $texts)}
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
            Text("Header")
        }.frame(width: geometry.size.width, height: geometry.size.height*0.1)
    }
}

struct ChatInput : View {
    let geometry : GeometryProxy
    let userID : UUID
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
        let message = Message(userId: userID, content: content)
        self.texts.append(message)
    }
}


struct Message : View,Hashable {
    var userId : UUID
    let sendId = UUID()
    let content : String
    var body: some View {
        VStack{
            Text(content).border(userId == sendId ? Color.black : Color.red)
        }
    }
}
