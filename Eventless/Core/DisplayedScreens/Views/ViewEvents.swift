// App interface for browsing and exploring a catalog of events.
// Designed to display event categories, subcategories, and individual events with interactive elements such as favoriting.

import SwiftUI

struct ViewEvents: View {
    // Properties
    
    // Store an array of event categories
    @State private var eventCategories = Event.preview()

    // Array to check if category labels are expanded
    @State private var isExpanded: [Bool] = Array(repeating: false, count: Event.preview().count)
    
    // Track whether each category label is expanded or collapsed
    @State private var selectedSubcategory: Subcategory? = nil
    
    var body: some View {
        VStack {
            Text("Events Catalogue")
                .foregroundColor(.gray)
                .font(.system(size: 25))
                .padding(.bottom, 30)
                .padding(.top, 70)
            
            // Display event categories
            NavigationView {
                List(Array(eventCategories.enumerated()), id: \.element.id) { index, category in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { isExpanded[index] },
                            set: { newValue in
                                isExpanded.indices.forEach { idx in
                                    isExpanded[idx] = idx == index ? newValue : false
                                }
                            }
                        ),
                        content: {
                            ForEach(category.subcategories.sorted()) { subcategory in
                                Button(action: {
                                    selectedSubcategory = subcategory
                                }) {
                                    HStack {
                                        Text(subcategory.name)
                                            .foregroundColor(.gray)
                                            .font(.system(size: 18))
                                            .padding(.leading)
                                            .padding(.vertical, 5)
                                        
                                        Spacer()
                                    }
                                }
                                .background(NavigationLink("", destination: SubcategoryEventsView(subcategory: selectedSubcategory ?? subcategory)
                                    .onDisappear {
                                        resetIsExpanded()
                                    }
                                ))
                            }
                        },
                        label: {
                            CategoryRow(categories: category)
                                .font(.system(size: 20))
                                .padding(.vertical, 7)
                        }
                    )
                }
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
    
    // Resets the 'isExpanded' state array to collapse all category labels
    private func resetIsExpanded() {
        isExpanded = Array(repeating: false, count: eventCategories.count)
    }
}

// Define the view for displaying events within a particular subcategory
struct SubcategoryEventsView: View {
    // Properties
    @State private var sortedAnnotations: [AnnotationModel] = []
    
    // Pass the selected subcategory
    let subcategory: Subcategory
    
    var body: some View {
        NavigationView {
            // Display event annotations filtered based on the current subcategory
            List(sortedAnnotations.filter { $0.derivedCategory == subcategory.name }) { annotation in
                // Display each event annotation in the list
                AnnotationRowView(annotation: annotation)
            }
        }
        .navigationBarTitle("Events for \(subcategory.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: UIColor.systemBackground, tintColor: .gray)
        .onAppear {
            sortedAnnotations = DatabaseManager.shared.getEvents(sortedBy: DatabaseManager.shared.name)
        }
    }
}

// Define a view for displaying detailed information about an event annotation
struct AnnotationRowView: View {
    // Properties
    
    // Hold the event annotation model that the view will display information about
    let annotation: AnnotationModel
    
    // Track whether the event is marked as a favorite
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(annotation.annotationName)
                    .foregroundColor(.gray)
                    .font(.system(size: 19))
                    .padding(.vertical, 3)
                
                Spacer()
                
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.gray)
                }
            }
            
            VStack {
                Text("          \(annotation.description)")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                
                Text("Start Date: \(annotation.startDate)")
                    .foregroundColor(.gray)
                    .padding(.vertical, 5)
                
                Text("End Date: \(annotation.endDate)")
                    .foregroundColor(.gray)
                    .padding(.vertical, 5)
            }
        }
        // Check whether the current event annotation is marked as a favorite using
        // 'DatabaseManager.shared.isFavorite(annotation: annotation)' and updates the 'isFavorite' state accordingly.
        .onAppear {
            isFavorite = DatabaseManager.shared.isFavorite(annotation: annotation)
        }
    }
    
    // Called when the 'heart' button is tapped.
    // Updates the state of event (favorite or not)
    private func toggleFavorite() {
        if isFavorite {
            DatabaseManager.shared.removeFavoriteEvent(annotation: annotation)
        } else {
            DatabaseManager.shared.addFavoriteEvent(annotation: annotation)
        }
        
        isFavorite.toggle()
    }
}

// Custom modifier to set navigation bar colors
extension View {
    func navigationBarColor(backgroundColor: UIColor?, tintColor: UIColor?) -> some View {
        self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

// Define a SwiftUI view modifier that allows customization of the appearance of the navigation bar
struct NavigationBarColor: ViewModifier {
    init(backgroundColor: UIColor?, tintColor: UIColor?) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [
            .foregroundColor: tintColor ?? .white,
            .font: UIFont.systemFont(ofSize: 19, weight: .regular) // Set the font size and weight here
        ]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = tintColor
    }

    func body(content: Content) -> some View {
        content
    }
}

// Provide a preview of the 'ViewEvents'
struct ViewEvents_Previews: PreviewProvider {
    static var previews: some View {
        ViewEvents()
            .preferredColorScheme(.dark)
    }
}
