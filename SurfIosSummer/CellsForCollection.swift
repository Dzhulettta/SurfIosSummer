//
//  CellsForCollection.swift
//  SurfIosSummer
//
//  Created by Юлия Чужинова on 02.08.2023.
//

import UIKit
import CoreData

class CellsForCollection: UICollectionViewCell {
    
    var copyCoreDataSkills = CoreDataSkills()
    
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBAction func deleteButton(_ sender: Any) {
    }
   
    @IBOutlet weak var nameSkill: UILabel!
 
    @IBOutlet weak var cellColor: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellColor.layer.masksToBounds = true
        cellColor.layer.cornerRadius = 12
   
    }
    
    func initCell(item: NSManagedObject){
        copyCoreDataSkills.appToCoreDate()
        if copyCoreDataSkills.coreDataSkills.count != 0 {
            
            nameSkill.text = item.value(forKey: "nameSkill") as? String
        }
    }
    func initCellEmpty(){
        nameSkill.text = "Навыков пока нет"
    }
}
