//
//  DBManager.swift
//  FizzBuzzJoguinho
//
//  Created by Treinamento on 01/08/18.
//  Copyright © 2018 somaisumesquisito. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBManager {
    static var myDBManager : DBManager?
    
    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    
    private init () {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedContext = self.appDelegate?.persistentContainer.viewContext
    }
    
    static func getInstance() -> DBManager {
        if (DBManager.myDBManager == nil) {
            DBManager.myDBManager = DBManager()
        }
        
        return DBManager.myDBManager!
    }
    
}
