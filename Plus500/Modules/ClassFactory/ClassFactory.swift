//
//  ClassFactory.swift
//  Plus500
//
// Created by Bary Levy on 25/05/2021.
//
//

import Foundation

enum ClassFactoryError: Error {
    case runtimeError(String)
}

class ClassFactory {
    
    static let shared = ClassFactory()    
    
    private var instances = [AnyHashable : AnyObject]()
    
    public func clearAll(){
        instances.removeAll()
    }
    
    func resolve(type: Any) throws -> Any {
        let name = String(describing: type.self)
        
        if let val:AnyObject = instances[name]{
            return val
        }
        throw ClassFactoryError.runtimeError("Impl Not Exist for: "+name)

    }
    func register( type: Any, impl:AnyObject) {
        let typeId = String(describing: type.self)
        instances[typeId] = impl
    }
}
