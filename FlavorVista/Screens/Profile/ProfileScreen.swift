//
//  ProfileView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI

struct ProfileScreen: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 50)
                        .foregroundStyle(.orange)
                    
                    Spacer()
                    
                    Text("Your Profile Info")
                        .foregroundStyle(.orange)
                        .font(.title)
                    
                    Spacer()
                }
                
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $viewModel.userProfile.name)
                    TextField("Email", text: $viewModel.userProfile.email)
                        .keyboardType(.emailAddress)
                    TextField("Age", text: $viewModel.ageString)
                        .keyboardType(.numberPad)
                    Picker("Gender", selection: $viewModel.userProfile.gender) {
                        ForEach(viewModel.genders, id: \.self) { gender in
                            Text(gender).tag(gender)
                        }
                    }
                    
                    Text("Are you Diabetic?")
                    
                    Picker("Diabetes", selection: $viewModel.userProfile.hasDiabetes) {
                        Text("Yes").tag(true)
                        Text("No").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: viewModel.saveProfile) {
                    Text("Save Changes")
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                viewModel.loadProfile()
            }
        }
    }
}

#Preview {
    ProfileScreen()
}
