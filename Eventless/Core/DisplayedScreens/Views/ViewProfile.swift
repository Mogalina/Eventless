// Define a SwiftUI view that displays a user's favorite events

// Imports and configuration
import SwiftUI

let defaultProfilePhoto = UIImage(named: "userPhoto")

struct ViewProfile: View {
    // Properties
    let favoriteEvents = DatabaseManager.shared.getFavouriteEvents(sortedBy: DatabaseManager.shared.name)
    
    var body: some View {
        VStack {
            Text("Your Eventless")
                .foregroundColor(.gray)
                .font(.system(size: 25))
                .padding(.bottom, 30)
                .padding(.top, 70)
            
            // Content inside the view is conditionally displayed based on whether the user has favorite events or not:
            // if there are no favorite events, a message indicating so is displayed; if there are favorite events,
            // a List displays them using the 'AnnotationRowView'
            if DatabaseManager.shared.getRowCount(for: DatabaseManager.shared.favoriteEventsTable) == 0 {
                Spacer()
                
                Text("You Have No Favourite Events")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .padding(.bottom, 100)
                
                Spacer()
            } else {
                List(favoriteEvents) { annotation in
                    AnnotationRowView(annotation: annotation)
                }
                .frame(width: UIScreen.main.bounds.width)
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

// Provide a preview of the 'ViewProfile
struct ViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfile()
            .preferredColorScheme(.dark)
    }
}
