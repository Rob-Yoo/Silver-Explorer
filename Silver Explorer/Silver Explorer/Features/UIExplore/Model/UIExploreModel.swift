//
//  UIExploreResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import ARKit
import SceneKit

struct UIExploreModel {
    static let stageTitles: [String] = [
            "탭하기 - 짧게", "탭하기 - 길게", "스와이프하기", "드래그하기", "확대하기/축소하기", "회전시키기"
            ]
    static let stageImages: [Stage.StageType: UIImage] = [
            .shortTap: #imageLiteral(resourceName: "tap"),
            .longTap: #imageLiteral(resourceName: "longTap"),
            .swipe: #imageLiteral(resourceName: "swipe right"),
            .drag: #imageLiteral(resourceName: "drag"),
            .pinch: #imageLiteral(resourceName: "pinch out"),
            .rotate: #imageLiteral(resourceName: "rotate")
        ]
    static let stageDescriptions: [Stage.StageType: String] = [
        .shortTap: "한 손가락을 사용해\nAR 캐릭터를 짧게 탭해보세요!",
        .longTap: "한 손가락을 사용해\nAR 캐릭터를 길게 탭해보세요!",
        .swipe: "한 손가락을 사용해\nAR 캐릭터를 스와이프해보세요!",
        .drag: "한 손가락을 사용해\nAR 캐릭터를 드래그해보세요!",
        .pinch: "두 손가락을 사용해\nAR 캐릭터를 확대/축소해보세요!",
        .rotate: "두 손가락을 사용해\nAR 캐릭터를 회전시켜보세요!"
    ]
}
