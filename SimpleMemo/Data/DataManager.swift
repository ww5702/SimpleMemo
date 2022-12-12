//
//  DataManager.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/29.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    private init() {
        
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    
    func fetchMemo() {
        // 데이터를 데이터베이스에서 읽어오는 것을 표현하는 용어 fetch
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        // 날짜 내림차순
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            memoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    
    }
    
    func addNewMemo(_ memo: String?) {
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.insertDate = Date()
        
        // append추가는 맨뒤로, insert추가는 맨 앞으로ㅓ
        memoList.insert(newMemo, at: 0)
        
        saveContext()
        
    }
    
    func deleteMemo(_ memo: Memo?) {
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleMemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
