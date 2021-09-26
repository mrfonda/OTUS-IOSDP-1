////
////  Injected.swift
////  injectedwrapper
////
////  Created by Anna Zharkova on 22.07.2021.
////
//
//import Foundation
//
//@propertyWrapper
//public struct Injected<T> {
//    private var service:T?
//    private var container: ServiceLocator? = nil
//
//    public var name: String?
//    public init() {
//        self.container =  ServiceLocator.shared
//    }
//
//    public init(name: String? = nil, container: ServiceLocator? = ServiceLocator.shared) {
//        self.name = name
//        self.container = container
//    }
//
//    public var wrappedValue: T? {
//        mutating get {
//            if self.service == nil {
//                if self.container == nil {
//                    self.container =  ServiceLocator.shared
//                }
//                self.service = container?.tryGetService(T.self)
//            }
//            return service
//        }
//        mutating set {service = newValue}
//    }
//
//    public var projectedValue: Injected<T> {
//        get {return self}
//        mutating set {self = newValue}
//    }
//}
