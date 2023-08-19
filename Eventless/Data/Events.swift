// Defines two structs, 'Subcategory' and 'Event'

// Imports and configuration
import Foundation

// Represents a subcategory ('derivedCategory' in 'DatabaseManager') of events ('mainCategory' in 'DatabaseManager')
struct Subcategory: Identifiable, Hashable, Comparable {
    // Properties
    var name: String
    let id = UUID()
    
    // Sorting 'Subcategory' elements alphabetically (by name) using 'Comparable' protocol
    static func < (lhs: Subcategory, rhs: Subcategory) -> Bool {
        return lhs.name < rhs.name
    }
}

// Represents an event, which can have multiple subcategories
struct Event: Identifiable, Hashable, Comparable {
    // Properties
    var name: String
    var subcategories: [Subcategory]
    let id = UUID()

    // Sorting 'Event' elements alphabetically (by name) using 'Comparable' protocol
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.name < rhs.name
    }

    // Returns an array of predefined 'Event' instances, each with their associated subcategories
    static func preview() -> [Event] {
        [
            // Elements (type: Event) declaration
            Event(name: "Festivals", subcategories: [
                Subcategory(name: "Music"),
                Subcategory(name: "Film")
            ]),
            Event(name: "Sports", subcategories: [
                Subcategory(name: "Football"),
                Subcategory(name: "Basketball")
            ]),
            Event(name: "Meetings", subcategories: [
                Subcategory(name: "Auto")
            ]),
            Event(name: "Tastings", subcategories: [
                Subcategory(name: "Food"),
                Subcategory(name: "Wine")
            ])
        ]
        .sorted()
    }
}
