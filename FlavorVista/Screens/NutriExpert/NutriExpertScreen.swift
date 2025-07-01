//
//  ChatBotView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI

struct NutriExpertScreen: View {
    
    @StateObject private var viewModel = ChatViewModel()
    @State private var userMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            if viewModel.messages.isEmpty {
                                // Friendly intro section
                                VStack(alignment: .center, spacing: 10) {
                                    Text("🤖🥕")
                                        .font(.system(size: 40))
                                    Text("Hi, I’m Nutri Buddy!")
                                        .font(.title3)
                                        .bold()
                                    Text("I’m your 24/7 available nutrition expert. Ask me anything about diet planning, food choices, or healthy habits!")
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                                .padding(.top, 30)
                            } else {
                                ForEach(viewModel.messages, id: \.id) { message in
                                    HStack(alignment: .bottom) {
                                        if message.isUser {
                                            Spacer()
                                            Text(message.content)
                                                .padding()
                                                .background(Color.orange.opacity(0.9))
                                                .foregroundColor(.white)
                                                .cornerRadius(12)
                                                .frame(maxWidth: 250, alignment: .trailing)
                                        } else {
                                            HStack(alignment: .bottom, spacing: 8) {
                                                Text("🤖")
                                                Text(message.content)
                                                    .padding()
                                                    .background(Color.gray.opacity(0.15))
                                                    .foregroundColor(.primary)
                                                    .cornerRadius(12)
                                            }
                                            .frame(maxWidth: 250, alignment: .leading)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }

                Divider()
                    .padding(.vertical, 6)
                
                // Message input area
                HStack(spacing: 10) {
                    TextField("Talk to Nutri Buddy...", text: $userMessage)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .tint(.orange)
                    
                    Button(action: {
                        if !userMessage.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.sendMessage(userMessage)
                            userMessage = ""
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("NutriExpert")
        }
    }
}



#Preview {
    NutriExpertScreen()
}
