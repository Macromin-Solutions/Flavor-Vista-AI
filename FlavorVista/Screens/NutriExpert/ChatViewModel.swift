//
//  ChatViewModel.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 20/05/24.
//

import FirebaseRemoteConfig
import Foundation
import SwiftUI
import Combine

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
}

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    private var cancellables = Set<AnyCancellable>()
    private var apiKey = ""
    private let assistantId = "asst_xpb2mqcpIbZSLz7GBUm5DRe8"
    private let baseURL = "https://ai-flavorvistaai766530959280.openai.azure.com"
//    private let baseURL = "https://ai-flavorvistaai766530959280.openai.azure.com/"
    private let remoteConfig: RemoteConfig
    
    // FireBase init() for the API_KEY
    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // for development you might want to fetch everytime
        remoteConfig.configSettings = settings
        
        fetchRemoteConfig()
    }
    
    //FireBase Function for RemoteConfig Settings
    private func fetchRemoteConfig() {
        remoteConfig.fetch{ [weak self] status, error in
            if status == .success {
                self?.remoteConfig.activate { _, error in
                    if let error = error {
                        print("Error activating remote config: \(error.localizedDescription)")
                    } else {
                        self?.apiKey = self?.remoteConfig.configValue(forKey: "API_KEY").stringValue ?? ""
                        print("API KEY fetched successfully")
                    }
                    
                }
            } else if let error = error {
                print("Error fetching remote config: \(error.localizedDescription)")
            }
            
        }
    }
    
    
    func sendMessage(_ text: String) {
        let userMessage = Message(content: text, isUser: true)
        messages.append(userMessage)
        
        // Create a new thread for each conversation
        createThread { threadId in
            guard let threadId = threadId else { return }
            
            // Add user message to the thread
            self.addUserMessageToThread(threadId: threadId, content: text) {
                // Run the thread to get the response from NutriExpert
                self.runThread(threadId: threadId) { runId in
                    guard let runId = runId else { return }
                    self.pollRunStatus(threadId: threadId, runId: runId)
                }
            }
        }
    }
    
    private func createThread(completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(baseURL)/openai/threads?api-version=2024-02-15-preview")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error creating thread: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            do {
                let result = try JSONDecoder().decode(ThreadResponse.self, from: data)
                completion(result.id)
            } catch {
                print("Error decoding thread response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    private func addUserMessageToThread(threadId: String, content: String, completion: @escaping () -> Void) {
        let url = URL(string: "\(baseURL)/openai/threads/\(threadId)/messages?api-version=2024-02-15-preview")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "role": "user",
            "content": content
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil, error == nil else {
                print("Error adding user message: \(error?.localizedDescription ?? "Unknown error")")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    private func runThread(threadId: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(baseURL)/openai/threads/\(threadId)/runs?api-version=2024-02-15-preview")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "assistant_id": assistantId
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error running thread: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            do {
                let result = try JSONDecoder().decode(RunResponse.self, from: data)
                completion(result.id)
            } catch {
                print("Error decoding run response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    private func pollRunStatus(threadId: String, runId: String) {
        let url = URL(string: "\(baseURL)/openai/threads/\(threadId)/runs/\(runId)?api-version=2024-02-15-preview")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching run status: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            do {
                let result = try JSONDecoder().decode(RunStatusResponse.self, from: data)
                if result.status == "completed" {
                    self.fetchRunResult(threadId: threadId, runId: runId)
                } else if result.status == "in_progress" || result.status == "queued" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.pollRunStatus(threadId: threadId, runId: runId)
                    }
                } else {
                    print("Run failed with status: \(result.status)")
                }
            } catch {
                print("Error decoding run status response: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func fetchRunResult(threadId: String, runId: String) {
//        let url = URL(string: "\(baseURL)/openai/threads/\(threadId)/runs/\(runId)/results?api-version=2024-02-15-preview")!
        guard let url = URL(string: "\(baseURL)/openai/threads/\(threadId)/messages?api-version=2024-02-15-preview") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching run result: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                print(data)
                print(response ?? "Error in Response")
            }
            
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                print(result)
                var newMessages: [Message] = []
                result.data.forEach { messageReceived in
                    let role = messageReceived.role
                    var content: String = ""
                    messageReceived.content.forEach { nestedMessage in
                        content = nestedMessage.text.value
                    }
                    let message = Message(content: content, isUser: role == "user" ? true : false)
//                    self.messages.append(message)
                    newMessages.append(message)
                }
                DispatchQueue.main.async {
                    self.messages = newMessages.reversed()
                }
                
//                result.messages.forEach { AssistantMessage in
//                    let messages = Message(content: AssistantMessage.content, isUser: true)
//                    self.messages.append(messages)
//                }
//                if let botMessageContent = result.messages.first?.content {
//                    let botMessage = Message(content: botMessageContent.trimmingCharacters(in: .whitespacesAndNewlines), isUser: false)
//                    DispatchQueue.main.async {
//                        self.messages.append(botMessage)
//                    }
//                }
            } catch {
                print("Error decoding run result response: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct ThreadResponse: Decodable {
    let id: String
}

struct RunResponse: Decodable {
    let id: String
}

struct RunStatusResponse: Decodable {
    let status: String
}


struct Response: Decodable {
    let data: [MessageData]
}

struct MessageData: Decodable {
    let role: String
    let content: [Content]

    // CodingKeys to map JSON keys to Swift properties
    private enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}

struct Content: Decodable {
    let text: TextContent

    // CodingKeys to map JSON keys to Swift properties
    private enum CodingKeys: String, CodingKey {
        case text
    }
}

struct TextContent: Decodable {
    let value: String

    // CodingKeys to map JSON keys to Swift properties
    private enum CodingKeys: String, CodingKey {
        case value
    }
}


