//
//  ProfileViewController.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        print("Profile: ")
        print(userEntityValidate.fullname)
        print(userEntityValidate.username)
        //lblName.text = userEntityValidate.fullname
        //lblUsername.text = userEntityValidate.username
        //let indexPath = IndexPath(row: 7, section: 0)
        //self.menuTable(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionPhotoTouchUp(_ sender: UIButton) {
        let alert = UIAlertController(title: "Imagen de Perfil", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { (UIAlertAction) in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galería de Fotos", style: .default, handler: { (UIAlertAction) in
            self.openGalery()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        
        if indexPath.row == 2 {
            let indexPathNombre = IndexPath(row: indexPath.row, section: indexPath.section)
            let firstCell = tableView.cellForRow(at: indexPathNombre)
            firstCell?.detailTextLabel?.text = userEntityValidate.fullname
        }
        if indexPath.row == 3 {
            let indexPathNombre = IndexPath(row: indexPath.row, section: indexPath.section)
            let firstCell = tableView.cellForRow(at: indexPathNombre)
            firstCell?.detailTextLabel?.text = userEntityValidate.username
        }
        
        return cell
    }*/
   
    func openGalery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 */
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true,completion: nil)
        }
    }
    
    @IBAction func actionCloseSessionTouchUp(_ sender: UIButton) {
        userEntityValidate = UserEntity()
    }

}
