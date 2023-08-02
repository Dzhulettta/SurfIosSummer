//
//  ViewController.swift
//  SurfIosSummer
//
//  Created by Юлия Чужинова on 02.08.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    var copyCoreDataSkills = CoreDataSkills()
    @IBOutlet weak var fotoImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBAction func changeButton(_ sender: Any) {
        makeAlertControllet()
    }
    
    @IBOutlet weak var skillsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fotoImage.layer.cornerRadius = 60
        skillsCollection.delegate = self
        skillsCollection.dataSource = self
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    func makeAlertControllet(){ // создание алерт контроллера
        let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка которым вы владеете", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Ведите название"
        } // создание алерт контроллера
        // создание кнопни1
        let alertAction1 = UIAlertAction(title: "Отмена", style: .cancel) { (alert) in
            
        }
        // создание кнопки2
        let alertAction2 = UIAlertAction(title: "Добавить", style: .default) { (alert) in
            guard let newSkill = alertController.textFields?.last?.text else { return }
            if newSkill != ""{
                self.copyCoreDataSkills.addToCoreDate(nameSkill: newSkill)
                self.copyCoreDataSkills.changeToCoreDate(nameSkill: newSkill)
                self.reload()
                self.dismiss(animated: true, completion: .none)
                
            }
        }
        // добавление кнопок в алерт контроллер
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion:  nil) // вызов алерт контроллера
    }
    func reload(){
        copyCoreDataSkills.appToCoreDate()
        CoreDataSkills.shared.appToCoreDate()
        skillsCollection.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = copyCoreDataSkills.coreDataSkills.count
        if count != 0{
            return count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSkill", for: indexPath) as! CellsForCollection
        
        if copyCoreDataSkills.coreDataSkills.count == 0{
            cell.initCellEmpty()
            return cell
        } else {
            copyCoreDataSkills.appToCoreDate()
            CoreDataSkills.shared.appToCoreDate()
            var allSkills: [NSManagedObject] = []
            let skill = copyCoreDataSkills.coreDataSkills
            if skill != nil{
                for item in skill{
                    cell.initCell(item: skill[indexPath.row])
                }
            }
            
            return cell
            
            
        }
    }
}

