//
//  ChatBotView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI

struct NutriExpertView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var userMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages, id: \.id) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.content)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.primary)
                                        .cornerRadius(10)
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.primary)
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding()

                HStack {
                    TextField("Talk to NutriExpert AI...", text: $userMessage)
                        .frame(minHeight: 40)
                        .tint(.orange)
                        .padding([.leading, .trailing], 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.orange, lineWidth: 2)
                        )
                        
                    
                    Button(action: {
                        viewModel.sendMessage(userMessage)
                        userMessage = ""
                    }) {
                        Text("Send")
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.orange)
                            .foregroundColor(.primary)
                            .clipShape(Capsule())
                    }
                }
                .padding()
            }
            .navigationTitle("NutriExpert24/7")
        }
    }
}

#Preview {
    NutriExpertView()
}
