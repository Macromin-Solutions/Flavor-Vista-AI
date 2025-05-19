import SwiftUI

struct ProfileScreen: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.orange)
                        
                        Text("Personal Details")
                            .font(.title2.bold())
                            .foregroundStyle(.green)
                        
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Goal Weight Card
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green.opacity(0.1))
                        .overlay(
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Goal Weight")
                                        .foregroundStyle(.gray)
                                    Text("49 kg")
                                        .font(.title2.bold())
                                        .foregroundStyle(.green)
                                }
                                Spacer()
                                Button(action: {}) {
                                    Text("Change Goal")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(Color.orange)
                                        .cornerRadius(12)
                                }
                            }
                            .padding()
                        )
                        .frame(height: 90)
                        .padding(.horizontal)

                    // Editable Details
                    VStack(spacing: 16) {
                        ProfileField(title: "Current weight", value: "54 kg")
                        ProfileField(title: "Height", value: "167 cm")
                        ProfileField(title: "Date of birth", value: "1/12/2023")
                        ProfileField(title: "Gender", value: "Male")
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle(" ")
            .onAppear {
                viewModel.loadProfile()
            }
        }
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
