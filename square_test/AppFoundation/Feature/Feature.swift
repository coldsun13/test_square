//
//  Feature.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

import Foundation

protocol UIFeatureAction {}

protocol UIFeatureState: ObservableObject {}

protocol UISideEffect {}

protocol UIFeature {
    associatedtype State: UIFeatureState
    associatedtype Action: UIFeatureAction
    associatedtype Effect: UISideEffect
}

enum UIFeatureDefinition<StateType: UIFeatureState, ActionType: UIFeatureAction, EffectType: UISideEffect>: UIFeature {
    public typealias State = StateType
    public typealias Action = ActionType
    public typealias Effect = EffectType
}
