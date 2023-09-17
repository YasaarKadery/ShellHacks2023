//
//  ChatView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Hi, how can I help you today?"]
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message )
            self.messageText = ""
        }
        
            withAnimation {
                getBotResponse(question: message) { (response, error) in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let response = response {
                        messages.append(response)
                        
                    }
                }
            }
    }

    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Jakey")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Image("mdi_robot")
                        .font(.system(size: 26))
                }
                ScrollView {
                    // Messages
                    ForEach(messages, id: \.self) { message in
                        if message.contains("[USER]") {
                            let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                            HStack {
                                Spacer()
                                Text(newMessage)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(.blue.opacity(0.8))
                                    .cornerRadius(10)
                                    .padding(.horizontal,16)
                                    .padding(.bottom,10)
                                    .font(.system(size: 18))
                            }
                        } else {
                            HStack {
                                
                                Text(message)
                                    .padding()
                                    .background(.gray.opacity(0.9))
                                    .cornerRadius(10)
                                    .padding(.horizontal,16)
                                    .padding(.bottom,10)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                Spacer()
                            }

                        }
                    }.rotationEffect(.degrees(180))
                }.rotationEffect(.degrees(180))
            
                HStack {
                    TextField("", text: $messageText, prompt: Text("Type something...").foregroundColor(.white))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .onSubmit {
                            sendMessage(message: messageText)
                             //
                        }
                    Button {
                        sendMessage(message: messageText)
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size:26))
                            .padding(.horizontal, 10)
                    }
                }
                .padding()
            }
        }
                
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
