# Eventless-Project-2023
  The project is a SwiftUI-based iOS application that aims to provide users with a comprehensive event discovery and management platform. The app utilizes various components to create a seamless experience for users, combining interactive maps, event catalogues, and user profiles.

  The app's core functionality revolves around three primary tabs: Map, Book, and Profile. In the "Map" tab, users can explore a map view using the MapKit framework. The app leverages a custom MapViewRepresentable structure to display annotations corresponding to events retrieved from a database using the DatabaseManager. These annotations are dynamically updated and can be customized with icons and colors. Users can also activate a "Point to User Location" feature, which dynamically centers the map on the user's location.

  In the "Book" tab, users can browse and search for events in a user-friendly interface. The ViewEvents structure utilizes a disclosure group UI pattern to categorize events into subcategories. The SearchBottomSheetViewRepresentable component provides a powerful search functionality, filtering events based on user input. Users can favorite events, and the app's design includes the capability to add events to a favorites list.

  The "Profile" tab allows users to view their favorite events. The ViewProfile structure dynamically lists user-selected events and displays them in a clear and organized manner.

  The project's user interface is streamlined and visually appealing, with custom tab bar views and navigation bar color modifications using extensions. The app efficiently utilizes SwiftUI's reactive programming paradigm, utilizing the @State, @Binding, and @ObservedObject property wrappers to manage dynamic UI changes and user interactions.

  Overall, the project elegantly combines location-based services, interactive data presentation, and user profile management to offer a cohesive event management solution, providing a seamless and user-friendly experience for event discovery and engagement.

