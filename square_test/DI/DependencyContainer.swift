//
//  DependencyContainer.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation
import Swinject

func resolve<T>(
    dependency: T.Type = T.self,
    named name: String = "Default"
) -> T {
    DependencyContainer.resolve(
        dependency: dependency,
        named: name
    )
}

func register<T>(
    dependency: T.Type = T.self,
    name: String = "Default",
    implementation: @escaping () -> T
) {
    DependencyContainer.register(
        .standard,
        dependency: dependency,
        name: name,
        implementation: implementation
    )
}

private enum DependencyBehaviour {
    case standard
    case singleton
}

enum DependencyContainer {
    private static var container = Container()
    
    // MARK: - Setup
    
    static func setup(container: Container? = nil) {
        if let inputContainer = container {
            self.container = inputContainer
        }
        
        registerHelpers()
        registerServices()
    }
    
    // MARK: - Dependencies Registration
    
    private static func registerHelpers() {
        register {
            JSONParameterEncoder() as JSONParameterEncoderProtocol
        }
    }
    
    private static func registerServices() {

        register(.singleton) {
            NetworkRouter() as NetworkRouterProtocol
        }

        register {
            RequestBuilder() as RequestBuilderProtocol
        }

        register {
            MainSquareNetworkService() as MainSquareNetworkServiceProtocol
        }
    }
    
    // MARK: - Dependencies Managing
    
    fileprivate static func register<T>(
        _ behaviour: DependencyBehaviour = .standard,
        dependency: T.Type = T.self,
        name: String = "Default",
        implementation: @escaping () -> T
    ) {
        container.register(dependency, name: name) { _ in
            implementation()
        }.inObjectScope(
            behaviour == .singleton
            ? .container
            : .transient
        )
    }
    
    fileprivate static func resolve<T>(dependency: T.Type, named name: String) -> T {
        guard let service = container.synchronize()
            .resolve(dependency, name: name) else {
            fatalError("Service isn't registered")
        }
        
        return service
    }
}
