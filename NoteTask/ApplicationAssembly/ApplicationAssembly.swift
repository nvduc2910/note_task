//
//  ApplicationAssembly.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/22/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import Foundation
import Typhoon
open class ApplicationAssembly : TyphoonAssembly
{
    static let sharedInstance = ApplicationAssembly().activate()
    
    
    
    open dynamic func noteDataService() -> AnyObject {
        return TyphoonDefinition.withClass(NoteDataService.self, configuration: { (definition) in
            definition?.scope = .lazySingleton
        }) as AnyObject
    }
    
    
}
