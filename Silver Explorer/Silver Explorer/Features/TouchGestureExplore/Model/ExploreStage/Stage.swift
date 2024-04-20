//
//  Stage.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 10/29/23.
//

import Foundation

struct Stage {
    enum StageType: Int {
        case shortTap = 0, longTap, swipe, drag, pinch, rotate
    }
    
    static func changeStage(_ stage: inout StageType, _ isNext: Bool) {
        switch stage {
        case .shortTap:
            stage = .longTap
        case .longTap:
            stage = isNext ? .swipe : .shortTap
        case .swipe:
            stage = isNext ? .drag : .longTap
        case .drag:
            stage = isNext ? .pinch : .swipe
        case .pinch:
            stage = isNext ? .rotate : .drag
        case .rotate:
            stage = .pinch
        }
    }
}
