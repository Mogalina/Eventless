// 'DatabaseManager' class encapsulates SQLite database operations related to events and favorite events.
// It handles database setup, data insertion and retrieval, favorite management, and table structure configuration.
// This class can be used to interact with a local database in your application for storing and managing event-related data.

// Imports and configuration
import Foundation
import SQLite

// Serves as a central point for managing interactions with the SQLite database
class DatabaseManager {
    // Hold the connection to the SQLite database
    var db: Connection!
    
    // Table properties
    var favoriteEventsTable: Table!
    var eventsTable: Table!
    
    // Expression properties
    var id: Expression<Int>!
    var name: Expression<String>!
    var latitude: Expression<Double>!
    var longitude: Expression<Double>!
    var mainCategory: Expression<String>!
    var derivedCategory: Expression<String>!
    var startDate: Expression<String>!
    var endDate: Expression<String>!
    var description: Expression<String>!
    
    // Instance of 'DatabaseManager' class, following the singleton design pattern
    static let shared = DatabaseManager()
    
    // Initializes 'DatabaseManager' instance
    init() {
        do {
            // Database file path
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("EventlessDatabase.sqlite")
            
            // Database connection
            db = try Connection(fileURL.path)
            
            // Table setup
            eventsTable = Table("events")
            
            // Expression setup
            id = Expression<Int>("id")
            name = Expression<String>("name")
            latitude = Expression<Double>("latitude")
            longitude = Expression<Double>("longitude")
            mainCategory = Expression<String>("mainCategory")
            derivedCategory = Expression<String>("derivedCategory")
            startDate = Expression<String>("startDate")
            endDate = Expression<String>("endDate")
            description = Expression<String>("description")
            
            // Table setup
            favoriteEventsTable = Table("favorite_events")
            
            // Expression setup
            id = Expression<Int>("id")
            name = Expression<String>("name")
            latitude = Expression<Double>("latitude")
            longitude = Expression<Double>("longitude")
            mainCategory = Expression<String>("mainCategory")
            derivedCategory = Expression<String>("derivedCategory")
            startDate = Expression<String>("startDate")
            endDate = Expression<String>("endDate")
            description = Expression<String>("description")
            
            // Table creation query
            let createTableQuery = eventsTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(name)
                table.column(latitude)
                table.column(longitude)
                table.column(mainCategory)
                table.column(derivedCategory)
                table.column(startDate)
                table.column(endDate)
                table.column(description)
            }
            
            // Table creation query
            let createFavoriteTableQuery = favoriteEventsTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(name)
                table.column(latitude)
                table.column(longitude)
                table.column(mainCategory)
                table.column(derivedCategory)
                table.column(startDate)
                table.column(endDate)
                table.column(description)
            }

            // Executing queries
            executeSQL(createTableQuery)
            executeSQL(createFavoriteTableQuery)
        } catch {
            print("Error opening database: \(error)")
        }
    }
    
    // Takes an SQL query as a parameter and attempts to execute it on the database connection (db)
    func executeSQL(_ query: String) {
        do {
            try db.execute(query)
        } catch {
            print("Error executing SQL: \(error)")
        }
    }
    
    // Inserts data into 'events' table
    func insertDataIntoTable(name: String, latitude: Double, longitude: Double, mainCategory: String, derivedCategory: String, startDate: String, endDate: String, description: String) {
        let eventsTable = Table("events")
        
        // Column-value assignments to define the values to be inserted into each column
        let insert = eventsTable.insert(
            Expression<String>("name") <- name,
            Expression<Double>("latitude") <- latitude,
            Expression<Double>("longitude") <- longitude,
            Expression<String>("mainCategory") <- mainCategory,
            Expression<String>("derivedCategory") <- derivedCategory,
            Expression<String>("startDate") <- startDate,
            Expression<String>("endDate") <- endDate,
            Expression<String>("description") <- description
        )
        
        // Insert query on the database
        do {
            try db.run(insert)
        } catch {
            print("Error inserting data: \(error)")
        }
    }
    
    // Deletes all data from the 'events' table
    func deleteAllEventData() {
        let deleteQuery = eventsTable.delete()
        
        // Dxecute the delete query on the database
        do {
            try db.run(deleteQuery)
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    // Check if the 'events' table is empty
    func initializeDatabase() {
        let initialDataCount = try? db.scalar(eventsTable.count)
        
        if initialDataCount == 0 {
            insertInitialData()
        }
    }
    
    // Insert initial data into 'events' table
    private func insertInitialData() {
        
        // Create events by calling 'insertDataIntoTable' method
        insertDataIntoTable(
            name: "Untold",
            latitude: 46.768590,
            longitude: 23.572420,
            mainCategory: "Festivals",
            derivedCategory: "Music",
            startDate: "2024-08-21",
            endDate: "2024-08-25",
            description: "Untold Festival is the largest electronic music festival held in Romania, taking place in Cluj-Napoca at the Cluj Arena."
        )
        insertDataIntoTable(
            name: "Sundance",
            latitude: 40.6425,
            longitude: -111.495,
            mainCategory: "Festivals",
            derivedCategory: "Film",
            startDate: "2024-01-19",
            endDate: "2024-01-29",
            description: "The Sundance Film Festival is an annual film festival organized by the Sundance Institute, taking place each January in Park City, Utah, Salt Lake City, Utah and at the Sundance Resort (a ski resort near Provo, Utah)."
        )
        
        insertDataIntoTable(
            name: "FCB x AMD",
            latitude: 40.4361,
            longitude: -3.5994,
            mainCategory: "Sports",
            derivedCategory: "Football",
            startDate: "2024-03-17",
            endDate: "2024-03-17",
            description: "Football match between two major teams FC Barcelona and Atletico Madrid, held on Wanda Metropolitano Stadium."
        )
        insertDataIntoTable(
            name: "LAL x PHX",
            latitude: 33.445833,
            longitude: -112.071389,
            mainCategory: "Sports",
            derivedCategory: "Basketball",
            startDate: "2023-11-10",
            endDate: "2023-11-10",
            description: "Basketball match between two major teams Los Angeles Lakers and Phoenix Suns, held on Acrisure Stadium."
        )
        
        insertDataIntoTable(
            name: "Auto Expo",
            latitude: 28.461979,
            longitude: 77.501850,
            mainCategory: "Meetings",
            derivedCategory: "Auto",
            startDate: "2024-01-13",
            endDate: "2024-01-18",
            description: "The Auto Expo is a biennial automotive show held in Greater Noida, NCR, India."
        )
        insertDataIntoTable(
            name: "Tokyo Motor Show",
            latitude: 35.629722,
            longitude: 139.794167,
            mainCategory: "Meetings",
            derivedCategory: "Auto",
            startDate: "2024-10-24",
            endDate: "2024-11-04",
            description: "The Tokyo Motor Show is a biennial auto show held in October–November at the Tokyo Big Sight, Tokyo, Japan for cars, motorcycles and commercial vehicles."
        )
        
        insertDataIntoTable(
            name: "Taste of London",
            latitude: 51.532222,
            longitude: -0.156667,
            mainCategory: "Tastings",
            derivedCategory: "Food",
            startDate: "2024-06-14",
            endDate: "2024-06-18",
            description: "We brought together 36 of the City’s best restaurants in one place. Together we ate our way round a world full of flavours and deliciousness."
        )
        insertDataIntoTable(
            name: "Dürkheim Wurstmarkt",
            latitude: 49.466014,
            longitude: 8.171021,
            mainCategory: "Tastings",
            derivedCategory: "Wine",
            startDate: "2024-08-25",
            endDate: "2024-08-30",
            description: "The Dürkheim Sausage Market is a folk festival in the Rhineland-Palatinate spa and district town of Bad Dürkheim on the German Wine Route, considered the largest wine festival in the world."
        )
    }
    
    // Retrieves a list of events from the 'events' table in the database
    public func getEvents(sortedBy column: Expression<String>, ascending: Bool = true) -> [AnnotationModel] {
        var annotationModels: [AnnotationModel] = []
        
        // Exception handling
        do {
            let sortedQuery = eventsTable.order(column.asc)
            
            for event in try db.prepare(sortedQuery) {
                let annotationModel: AnnotationModel = AnnotationModel()
                
                annotationModel.latitude = event[latitude]
                annotationModel.longitude = event[longitude]
                annotationModel.annotationName = event[name]
                annotationModel.mainCategory = event[mainCategory]
                annotationModel.derivedCategory = event[derivedCategory]
                annotationModel.startDate = event[startDate]
                annotationModel.endDate = event[endDate]
                annotationModel.description = event[description]
                
                annotationModels.append(annotationModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return annotationModels
    }
    
    // Retrieves a list of favorite events from the 'favorite_events' table
    public func getFavouriteEvents(sortedBy column: Expression<String>, ascending: Bool = true) -> [AnnotationModel] {
        var annotationModels: [AnnotationModel] = []
        
        // Exception handling
        do {
            let sortedQuery = favoriteEventsTable.order(column.asc)
            
            for favEvent in try db.prepare(sortedQuery) {
                let annotationModel: AnnotationModel = AnnotationModel()
                
                annotationModel.latitude = favEvent[latitude]
                annotationModel.longitude = favEvent[longitude]
                annotationModel.annotationName = favEvent[name]
                annotationModel.mainCategory = favEvent[mainCategory]
                annotationModel.derivedCategory = favEvent[derivedCategory]
                annotationModel.startDate = favEvent[startDate]
                annotationModel.endDate = favEvent[endDate]
                annotationModel.description = favEvent[description]
                
                annotationModels.append(annotationModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return annotationModels
    }
    
    // Adds a given event (represented by an 'AnnotationModel' instance) to 'favorite_events' table
    func addFavoriteEvent(annotation: AnnotationModel) {
        let favEventsTable = Table("favorite_events")
        let insertFavorite = favEventsTable.insert(
            Expression<String>("name") <- annotation.annotationName,
            Expression<Double>("latitude") <- annotation.latitude,
            Expression<Double>("longitude") <- annotation.longitude,
            Expression<String>("mainCategory") <- annotation.mainCategory,
            Expression<String>("derivedCategory") <- annotation.derivedCategory,
            Expression<String>("startDate") <- annotation.startDate,
            Expression<String>("endDate") <- annotation.endDate,
            Expression<String>("description") <- annotation.description
        )
            
        do {
            try db.run(insertFavorite)
        } catch {
            print("Error adding event to favorites: \(error)")
        }
    }
        
    // Remove a given event from the 'favorite_events' table
    func removeFavoriteEvent(annotation: AnnotationModel) {
        let favEventsTable = Table("favorite_events")
        
        // Query that filters the table to match the provided event's name
        let favoriteQuery = favEventsTable.filter(name == annotation.annotationName)
        let deleteFavorite = favoriteQuery.delete()
        
        // Attempt to delete the corresponding row from the table
        do {
            try db.run(deleteFavorite)
        } catch {
            print("Error removing event from favorites: \(error)")
        }
    }
    
    // Check if a specific event (given as an 'AnnotationModel' instance) is a favorite by querying 'favorite_events' table
    func isFavorite(annotation: AnnotationModel) -> Bool {
        let favEventsTable = Table("favorite_events")
        
        // Query to count the number of rows in the table where the event's name matches
        let favoriteQuery = favEventsTable.filter(name == annotation.annotationName)
        
        do {
            return try db.scalar(favoriteQuery.count) > 0
        } catch {
            print("Error checking if event is a favorite: \(error)")
            return false
        }
    }
    
    // Get the number of rows in a specific table
    func getRowCount(for table: Table) -> Int {
        // Query to retrieve the count of rows in that table
        do {
            return try db.scalar(table.count)
        } catch {
            print("Error getting row count: \(error)")
            return 0
        }
    }
}
