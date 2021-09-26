////
////  ServiceLocator.swift
////  injectedwrapper
////
////  Created by Anna Zharkova on 22.07.2021.
////
//
//import Foundation
//
//public class ServiceLocator {
//    public static let shared = ServiceLocator()
//    
//    private var services: [String: Any] = [String:Any]()
//    
//    public func addService<T>(service: T) {
//        let name = "\(T.self)"
//        //guard let previous = tryGetService(T.self)  else {
//            services[name] = service
//          //  return
//        //}
//    }
//    
//    func tryGetService<T:Any>(_ type: T.Type)->T? {
//        let name = "\(type)"
//        return services[name] as? T
//    }
//
//}
//
