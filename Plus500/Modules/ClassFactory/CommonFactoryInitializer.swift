//
//  CommonFactoryInitializer.swift
//  itim
//
//  Created by Bary Levy on 04/10/2018.
//  Copyright © 2018 barylevy. All rights reserved.
//

import Foundation

class CommonFactoryInitializer {
    
    class func initFactoryGeneral( classFactory:ClassFactory) {
        
        classFactory.register(type: NetworkType.self, impl: Network())
        
        classFactory.register(type: FeedsManagerType.self, impl: FeedsManager())
        
        classFactory.register(type: ScreenFactoryType.self, impl: ScreenFactory())
    }
}

public class ModuleFactory {
    
    public static var network: NetworkType {
        try! ClassFactory.shared.resolve(type: NetworkType.self) as! NetworkType
    }

    public static var feedsManager: FeedsManagerType {
        try! ClassFactory.shared.resolve(type: FeedsManagerType.self) as! FeedsManagerType
    }
    
    public static var screenFactory: ScreenFactoryType {
        try! ClassFactory.shared.resolve(type: ScreenFactoryType.self) as! ScreenFactoryType
    }
}
