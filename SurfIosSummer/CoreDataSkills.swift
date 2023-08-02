//
//  CoreDataSkills.swift
//  SurfIosSummer
//
//  Created by Юлия Чужинова on 02.08.2023.
//

import UIKit
import Foundation
import CoreData

class CoreDataSkills{
    static let shared = CoreDataSkills()
    var coreDataSkills: [NSManagedObject] = []
    
    //MARK: - работа в базе
    func appToCoreDate () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SkillCollection")
        do {
            coreDataSkills = try! context.fetch(fetchRequest) as? [NSManagedObject] ?? [NSManagedObject]()
        }
    }
    
    //MARK: - добавление новых ячеек в базе
    
    func addToCoreDate (nameSkill: String) {
        
        appToCoreDate ()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SkillCollection", in: context) else { return }
        
        let productToAdd = NSManagedObject.init(entity: entity, insertInto: context)
        
        productToAdd.setValue(nameSkill, forKey: "nameSkill")
        
        do {
            try! context.save()
            coreDataSkills.append(productToAdd)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    //MARK: - сохранение изменений в базе
    
    func changeToCoreDate (nameSkill: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SkillCollection", in: context) else { return }
        do {
            try! context.save()
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    //MARK: - удаление ячейки в базе
    
    func deleteData(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let coreDataSkillDel = coreDataSkills[index]
        do {
            try! context.delete(coreDataSkillDel)
            try! context.save()
        }
    }
}


