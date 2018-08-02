//
//  CadastroViewController.swift
//  FizzBuzzJoguinho
//
//  Created by Treinamento on 01/08/18.
//  Copyright © 2018 somaisumesquisito. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    //MARK : - Variables
    var score: Int = Int.min
    let alertInvalidInput: UIAlertController = UIAlertController(title: "Erro ao Salvar", message: "Por favor, coloque um nome ou aperte em Cancelar", preferredStyle: .alert)
    let alertErrorSavingDB: UIAlertController = UIAlertController(title: "Erro ao Salvar", message: "Erro Inesperado ao tentar salvar, por favor, tente denovo", preferredStyle: .alert)
    
    var DBManagerHelper: DBManager = DBManager.getInstance()
    
    //MARK : - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK : - Actions
    @IBAction func insertPhotoOnClick(_ sender: Any) {
        self.openGallery()
    }
    
    @IBAction func saveOnClick(_ sender: Any) {
        if (!self.checkInputs()) { self.present(alertInvalidInput, animated: true, completion: nil)}
        else if (self.saveOnDataBase()) { self.performSegue(withIdentifier: "goToLeaderBoard", sender: nil)}
    }
    

    //MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareAlerts()
        self.loadScore()
        self.loadAnomPlayerImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK : - GameFunctions
    func loadScore() {
        self.scoreLabel.text = String(self.score)
    }
    
    func loadAnomPlayerImage() {
        self.playerPhoto.image = #imageLiteral(resourceName: "anomPlayer")
    }
    
    func checkInputs() -> Bool {
        var result = true
        if (self.nameField.text == "") { result = false }
        return result
    }
    
    //MARK : - ViewFunctions
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func saveOnDataBase() -> Bool{
        var result = true
        
        let newPlayer = PlayerMO(context: self.DBManagerHelper.managedContext!)
            newPlayer.nome  = self.nameField.text
            newPlayer.score = Int32(self.scoreLabel.text!)!
            newPlayer.foto  = UIImageJPEGRepresentation(self.playerPhoto.image!, 1)
        
        do {
            try self.DBManagerHelper.managedContext?.save()
        } catch let error as NSError {
            print("Erro ao salvar Jogador \(error)")
            self.present(alertErrorSavingDB, animated: true, completion: nil)
            result = false
        }
    
        return result
    }
    
    func prepareAlerts() {
        alertInvalidInput.addAction(UIAlertAction(title: NSLocalizedString("Entendi", comment: "Default action"), style: .default, handler: nil))
        alertErrorSavingDB.addAction(UIAlertAction(title: NSLocalizedString("Entendi", comment: "Default action"), style: .default, handler: nil))
    }
    

}

//MARK : - Extension
extension CadastroViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.playerPhoto.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}



