//
//  TaskModel.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import Foundation
//import CoreData

struct TaskModel: Identifiable, Hashable{
    var id = UUID()
    var title:String
    var memo:String
    var motivation:Double
    var start_time:String
    var end_time:String
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}

//extension TaskEntity{
//    static func create(in managedObjectContext: NSManagedObjectContext,
//                       title: String = "",
//                       memo: String = "",
//                       motivation: Double = 0.0,
//                       start_time: String = "00:00",
//                       end_time: String = "00:00"
//    ){
//        let newTask = self.init(context: managedObjectContext)
//        newTask.title = title
//        newTask.memo = memo
//        newTask.motivation = motivation
//        newTask.start_time = start_time
//        newTask.end_time = end_time
//    }
//
//}




//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        HomeView()
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
