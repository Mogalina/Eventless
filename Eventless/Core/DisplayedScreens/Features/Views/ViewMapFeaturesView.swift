// Defines a complete set of SwiftUI components that together create a map-related user interface,
// including buttons for search and location

// Imports and configuration
import SwiftUI
import MapKit

struct ViewMapFeaturesView: View {
    // Properties
    
    // Track whether the 'Search' bottom sheet view should be displayed
    @State var showingSearchBottomSheetViewRepresentable = false
    
    // Track whether the 'Filter' bottom sheet view should be displayed
    @State var showingFilterBottomSheetViewRepresentable = false
    
    // Represents the 'MapViewModel.shared' instance, used to manage map-related data and interactions.
    @ObservedObject var mapViewModel = MapViewModel.shared
    
    // Track whether the map should be centered on the user's actual location
    @Binding var pointToUserLocationIsActive: Bool
    
    var body: some View {
        VStack {
            // Search activation button
            Button(action: {
                showingSearchBottomSheetViewRepresentable.toggle()
            }) {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .font(.system(size: 15))
                    .frame(width: 40, height: 30)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 2.5)
            }
            .sheet(isPresented: $showingSearchBottomSheetViewRepresentable) {
                SearchBottomSheetViewRepresentable(showingSearchBottomSheetViewRepresentable: $showingSearchBottomSheetViewRepresentable)
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled)
                    .presentationContentInteraction(.scrolls)
                    .preferredColorScheme(.dark)
            }
            
            // Point user actual location activation button
            Button(action: {
                pointToUserLocationIsActive.toggle()
            }) {
                Image(systemName: "location.viewfinder")
                    .imageScale(.large)
                    .font(.system(size: 15))
                    .frame(width: 40, height: 30)
                    .foregroundColor(.white)
                    .padding(.top, 2.5)
                    .padding(.bottom, 10)
            }
        }
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .shadow(color: .black, radius: 2)
                .cornerRadius(10.0)
        )
    }
}

struct SearchBottomSheetViewRepresentable: View {
    // Properties
    
    // Track whether the search bottom sheet view should be displayed
    @Binding var showingSearchBottomSheetViewRepresentable: Bool
    
    // Store the search text entered by the user
    @State var searchText: String = ""
    
    // Represents the 'MapViewModel.shared' instance, used for map-related interactions
    @ObservedObject var mapViewModel = MapViewModel.shared
    
    // Holds an array of events retrieved from the database
    let sortedAnnotations = DatabaseManager.shared.getEvents(sortedBy: DatabaseManager.shared.name)
    
    // Returns an array of 'AnnotationModel' objects that match the search text
    var filteredAnnotations: [AnnotationModel] {
        guard !searchText.isEmpty else {return []}
        return sortedAnnotations.filter {$0.annotationName.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchText.count > 0 ? .blue : .gray)
                TextField("Search Events", text: $searchText)
                    .foregroundColor(.blue)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(searchText.count > 0 ? .blue : .gray)
            }
            .frame(width: UIScreen.main.bounds.width - 40)
               
            if searchText.count == 0 {
                Text("Matched Events")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .padding(.top, 50)
            }
            
            // Display the filtered annotations
            List(filteredAnnotations, id: \.id) { annotation in
                Button(action: {
                    showingSearchBottomSheetViewRepresentable = false
                    mapViewModel.selectAnnotation(annotation)
                }) {
                    HStack {
                        Text(annotation.annotationName)
                            .foregroundColor(.gray)
                                        
                        Spacer()
                                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
}

// Define a custom disclosure arrow icon that indicates whether a disclosure group is expanded or collapsed
struct CustomDisclosureArrow: View {
    // Properties
    
    // Determines the appearance of the arrow
    let isExpanded: Bool
    
    var body: some View {
        Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
    }
}

// Display a single row within a list of categories
struct CategoryRow: View {
    // Properties
    let categories: Event
    
    var body: some View {
        HStack {
            Text(categories.name)
        }
    }
}

// Provide a preview of the 'ViewMapFeaturesView', passing a binding to the 'pointToUserLocationIsActive' property
struct ViewMapFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        ViewMapFeaturesView(pointToUserLocationIsActive: .constant(false))
            .preferredColorScheme(.dark)
    }
}
