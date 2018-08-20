//
//  ProjectAssembling.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/20/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//
import UIKit

struct ProjectAssemblingService {
    
    static func assemble(view: ViewProtocol) {
        let presenter = Presenter()
        presenter.view = view
        
    }
    
}
