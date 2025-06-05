import SwiftUI

struct ProfileScreen: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Screen Title
                    HStack {
                        Text("Profile Settings")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Profile Settings Card
                    ProfileSettingsCard(
                        image: Image(systemName: "person.crop.circle.fill"),
                        name: $viewModel.userProfile.name,
                        ageDescription: "\(viewModel.userProfile.age) years old"
                    )
                    .padding(.horizontal)
                    
                    // Goal Weight Card
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green.opacity(0.1))
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Goal Weight")
                                        .foregroundColor(.gray)
                                    Text("\(viewModel.userProfile.goalWeight) kg")
                                        .font(.title2.bold())
                                        .foregroundStyle(.green)
                                }
                                Spacer()
                                Button {
                                    // change goal func
                                } label: {
                                    Text("Change Goal")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(Color.orange)
                                        .cornerRadius(12)
                                }

                            }
                                .padding(.horizontal)
                        )
                        .frame(height: 90)
                    
                    // Other Details
                    VStack(spacing: 16) {
                        ProfileField(title: "Current weight", value: "\(viewModel.userProfile.currentWeight) kg")
                        // viewmodel needs to be implemented for height and dob
                        ProfileField(title: "Height", value: "165 cm")
                        ProfileField(title: "Date of birth", value: "12/01/00")
                        ProfileField(title: "Gender", value: viewModel.userProfile.gender)
                    }
                    .padding(.horizontal)
                    
                    Button(role: .destructive) {
                        do {
                            try AuthService.shared.signOut()
                        } catch {
                            print("Failed to signed out")
                        }
                    } label: {
                        Text("Sign Out")
                    }

                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .onAppear {
                viewModel.loadProfile()
            }
        }
    }
}

// MARK: - Profile Settings Card

struct ProfileSettingsCard: View {
    let image: Image
    @Binding var name: String
    let ageDescription: String
    
    var body: some View {
        HStack(spacing: 16) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .background(Circle().fill(Color.green.opacity(0.2)))
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    // When empty, show placeholder
                    if name.isEmpty {
                        Text("Enter your name")
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $name)
                        .opacity(name.isEmpty ? 0.8 : 1)
                    Image(systemName: "pencil")
                        .foregroundColor(.orange)
                }
                .font(.headline)
                
                Text(ageDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct ProfileField: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Text(value)
                    .foregroundStyle(.primary)
                    .font(.headline)
            }
            Spacer()
            Image(systemName: "pencil")
                .foregroundColor(.orange)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

#Preview {
    ProfileScreen()
}
