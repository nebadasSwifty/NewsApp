//
//  NewsCoreData.swift
//  NewsApp
//
//  Created by Кирилл on 17.06.2022.
//

import CoreData
import UIKit

class NewsCoreData {
    
    static let sharedInstance = NewsCoreData()
    private init() {}
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private let fetchRequest = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    
    func saveDataOf(articles: [Article]) {
        container?.performBackgroundTask { context in
            self.deleteDataFromCoreData(context: context)
            self.saveDataToCoreData(articles: articles, context: context)
        }
    }
    
    private func deleteDataFromCoreData(context: NSManagedObjectContext) {
        do {
            let object = try context.fetch(fetchRequest)
            _ = object.map { context.delete($0) }
            try context.save()
        } catch {
            print("Deleting error: \(error)")
        }
    }
    
    
    private func saveDataToCoreData(articles: [Article], context: NSManagedObjectContext) {
        context.perform {
            for article in articles {
                let articleEntity = ArticleEntity(context: context)
                articleEntity.title = article.title
                articleEntity.newsDescription = article.newsDescription
                articleEntity.url = article.url
                articleEntity.urlToImage = article.urlToImage
                articleEntity.publishedAt = article.publishedAt
                articleEntity.content = article.content
            }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
}
