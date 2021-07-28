//
//  AddNewItemViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    var eventToAddItemTo:Event?
    var addNewItemHost:User?
    
    var arrayOfImages = [UIImage]()
    
    var userSelectedImage:UIImage?
    @IBOutlet weak var imagePickingCollectionView: UICollectionView!

    @IBOutlet weak var itemGoalLabel: UILabel!
    @IBOutlet weak var itemGoalSlider: UISlider!
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var chooseImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        setUpNavButtons()
        setUpNavTitle()
        addAllImagesToArray()
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemNameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        itemNameTextField.backgroundColor = UIColor.clear
    }
    
    
    
    
    
    @objc func savePartyItemButton() -> Void
    {
        
        //truncate after decimal place
        let itemGoal = Int(itemGoalSlider.value)


        print(itemGoal)
        print(itemNameTextField.text!)
        
        if itemNameTextField.text?.isEmpty ?? true {
            //if its empty then alert the user
            itemNameTextField.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            
            if(userSelectedImage == nil) {
                
                chooseImageLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                
            } else {
                
                let newPartyItem = PartyItem(name: itemNameTextField.text!,
                                             goal: Double(itemGoal),
                                             image: userSelectedImage!,
                                             itemEventID: (eventToAddItemTo?.eventID)!,
                                             amountFunded: 0)
                
                
                eventToAddItemTo?.partyItems.append(newPartyItem)
                
                FirebaseManager.writeToFirebaseDBPartyItem(partyItemName: itemNameTextField.text!, eventID: (eventToAddItemTo?.eventID)!, partyItemsArray: eventToAddItemTo?.partyItems)
                eventToAddItemTo?.partyItems.removeAll()
                //name and ID of the host who posted it. Not sure if you need both but they are here
                let hostName = addNewItemHost?.name!
                let hostID = addNewItemHost?.userID!
                print(hostName!)
                print(hostID!)
                
                //check to see if they are nil or else do not pop back
                _ = self.navigationController?.popViewController(animated: true)
                
            }

                
            }
            


            }
    
    @IBAction func itemGoalSliderAction(_ sender: UISlider)
    {
        
        let itemGoalInt = Int(itemGoalSlider.value)
        itemGoalLabel.text = "Item Goal: $\(itemGoalInt)"
    }
    
    @objc func cancelItemButton() -> Void
    {
        
        //pop back do not save
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newItemImageCell", for: indexPath) as! ImagePickingCollectionViewCell
        
        cell.configureCell(partyItemImage:arrayOfImages[indexPath.item])
        cell.alpha = 1
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath)
        userSelectedImage = arrayOfImages[indexPath.item]
        cell?.alpha = 0.3
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
        
    }
    
    //MARK: - General Setup -
    
    func setUpNavButtons() -> Void
    {
        
        let savePartyItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(savePartyItemButton))
        self.navigationItem.rightBarButtonItem = savePartyItem
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelItemButton))
        self.navigationItem.leftBarButtonItem = cancel
        
    }
    
    func setUpNavTitle() -> Void {
        
        let frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        let navLabel = UILabel(frame: frame)
        navLabel.font = UIFont(name: "Congratulations DEMO", size: 20.00)
        navLabel.textAlignment = .center
        navLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navLabel.text = eventToAddItemTo?.eventName
        
        self.navigationItem.titleView = navLabel
        
    }
    
    func addAllImagesToArray() -> Void
    {
        let imageArray = [#imageLiteral(resourceName: "aerosolCan"), #imageLiteral(resourceName: "balloons"), #imageLiteral(resourceName: "beer"), #imageLiteral(resourceName: "bubbles"), #imageLiteral(resourceName: "cake"), #imageLiteral(resourceName: "camcorder"), #imageLiteral(resourceName: "candle"), #imageLiteral(resourceName: "champagne"), #imageLiteral(resourceName: "clown"), #imageLiteral(resourceName: "confetti"), #imageLiteral(resourceName: "cupcake"), #imageLiteral(resourceName: "dinnerWhite"), #imageLiteral(resourceName: "discoBall"), #imageLiteral(resourceName: "dress"), #imageLiteral(resourceName: "drums"), #imageLiteral(resourceName: "eye-mask"), #imageLiteral(resourceName: "fireworks"), #imageLiteral(resourceName: "flags"), #imageLiteral(resourceName: "gamepad"), #imageLiteral(resourceName: "gift"), #imageLiteral(resourceName: "guitar"), #imageLiteral(resourceName: "hat"), #imageLiteral(resourceName: "ice-cream"), #imageLiteral(resourceName: "karaoke"), #imageLiteral(resourceName: "keyboard"), #imageLiteral(resourceName: "magic-wand"), #imageLiteral(resourceName: "martini"), #imageLiteral(resourceName: "mixer"), #imageLiteral(resourceName: "musical-note"), #imageLiteral(resourceName: "mustache"), #imageLiteral(resourceName: "party-blower"), #imageLiteral(resourceName: "photo-camera"), #imageLiteral(resourceName: "pizza"), #imageLiteral(resourceName: "soft-drink"), #imageLiteral(resourceName: "sparkler"), #imageLiteral(resourceName: "speaker"), #imageLiteral(resourceName: "suit"), #imageLiteral(resourceName: "trumpet"), #imageLiteral(resourceName: "turntable")]
        
        arrayOfImages.append(contentsOf: imageArray)
        
    }

}
