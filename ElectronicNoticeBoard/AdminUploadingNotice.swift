import SwiftUI
import PhotosUI

struct AdminUploadingNotice: View {
    @State private var selectedDays: [(String, Bool)] = [
        ("Mon", true), ("Tue", true), ("Wed", false),
        ("Thur", false), ("Fri", false), ("Sat", false)
    ]
    @State private var selectedScreen: String = "Screen 1"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var navigateToAdminView = false  // ✅ Navigate to existing AdminView

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // ✅ Navigate to existing AdminView
                NavigationLink(destination: AdminView(), isActive: $navigateToAdminView) {
                    EmptyView()
                }

                // Image Picker
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding()
                } else {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        VStack {
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                            Text("Select an Image")
                                .foregroundColor(.blue)
                                .font(.headline)
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        loadSelectedImage(from: newItem)
                    }
                    .padding()
                }

                // Title and Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title").font(.headline)
                    Text("Naat And Qirat").font(.title2).bold()

                    Text("Description").font(.headline)
                    Text("Participate in the Competition to Showcase your Skill").font(.body)

                    HStack {
                        Text("Starting Date: ").font(.headline)
                        Text("Nov 1, 2024").font(.body)
                        Spacer()
                        Text("Ending Date: ").font(.headline)
                        Text("Nov 20, 2024").font(.body)
                    }
                }
                .padding()

                // Selected Days
                VStack(alignment: .leading, spacing: 8) {
                    Text("Selected Days").font(.headline)
                    HStack(alignment: .top, spacing: -5) {
                        ForEach(0..<selectedDays.count, id: \.self) { index in
                            Toggle(selectedDays[index].0, isOn: Binding(
                                get: { selectedDays[index].1 },
                                set: { selectedDays[index].1 = $0 }
                            ))
                            .toggleStyle(CheckboxToggleStyle())
                            .padding(.trailing, 8)
                        }
                    }
                }
                .padding()

                // Selected Screen
                VStack(alignment: .leading, spacing: 8) {
                    Text("Selected Screen").font(.headline)
                    HStack {
                        RadioButton(text: "Screen 1", isSelected: $selectedScreen, value: "Screen 1")
                        RadioButton(text: "Screen 2", isSelected: $selectedScreen, value: "Screen 2")
                    }
                }
                .padding()

                Spacer()

                // ✅ Approve/Reject Buttons
                HStack {
                    Button(action: {
                        navigateToAdminView = true  // ✅ Navigate to AdminView
                    }) {
                        Text("Approve")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        print("Reject button tapped")
                    }) {
                        Text("Reject")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()

                // Footer with Home Icon
                ZStack {
                    Color.green
                        .frame(height: 100)
                        .edgesIgnoringSafeArea(.bottom)

                    Button(action: {
                        print("Home button tapped")
                    }) {
                        Image(systemName: "house")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Admin")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)  // ✅ Hide default back button
        }
    }

    // Function to load selected image
    private func loadSelectedImage(from item: PhotosPickerItem?) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }
}

// ✅ Radio Button
struct RadioButton: View {
    let text: String
    @Binding var isSelected: String
    let value: String

    var body: some View {
        Button(action: {
            isSelected = value
        }) {
            HStack {
                Circle()
                    .stroke(isSelected == value ? Color.green : Color.gray, lineWidth: 2)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .fill(isSelected == value ? Color.green : Color.clear)
                            .frame(width: 12, height: 12)
                    )
                Text(text)
                    .foregroundColor(.black)
            }
        }
    }
}

// ✅ Checkbox Toggle Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

// ✅ Preview
struct AdminUploadingNotice_Previews: PreviewProvider {
    static var previews: some View {
        AdminUploadingNotice()
    }
}
