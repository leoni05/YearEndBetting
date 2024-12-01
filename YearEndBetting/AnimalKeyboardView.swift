//
//  AnimalKeyboardView.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

protocol AnimalKeyboardViewDelegate: AnyObject {
    func selectedAnimalChanged(selectedAnimals: Int)
}

class AnimalKeyboardView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AnimalKeyboardViewDelegate?
    private var animalViews: Array<AnimalView> = [
        AnimalView(koreanString: "산토끼", imageName: "hare"),
        AnimalView(koreanString: "거북이", imageName: "tortoise"),
        AnimalView(koreanString: "강아지", imageName: "dog"),
        AnimalView(koreanString: "고양이", imageName: "cat"),
        AnimalView(koreanString: "도마뱀", imageName: "lizard"),
        AnimalView(koreanString: "새", imageName: "bird"),
        AnimalView(koreanString: "무당벌레", imageName: "ladybug"),
        AnimalView(koreanString: "물고기", imageName: "fish"),
        AnimalView(koreanString: "개미", imageName: "ant")
    ]
    private var animalContainerView = UIView()
    private var selectedAnimals: Int = 0
    
    private let cellGap = 10.0
    private let columnCnt = 3
    
    // MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        
        for idx in animalViews.indices {
            animalViews[idx].tag = (1 << idx)
            animalContainerView.addSubview(animalViews[idx])
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(animalViewTouched(_:)))
            gesture.numberOfTapsRequired = 1
            animalViews[idx].addGestureRecognizer(gesture)
        }
        self.addSubview(animalContainerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rowCnt = (animalViews.count + columnCnt - 1) / columnCnt
        let cellWidth = (self.frame.size.width - (cellGap * Double(columnCnt - 1))) / Double(columnCnt)
        let cellHeight = (self.frame.size.height - (cellGap * Double(rowCnt - 1))) / Double(rowCnt)
        if cellWidth < 0 || cellHeight < 0 {
            return
        }

        for idx in animalViews.indices {
            let r = idx / columnCnt
            let c = idx % columnCnt
            var x = 0.0
            var y = 0.0
            if c > 0 { x = animalViews[idx - 1].frame.maxX + cellGap }
            if r > 0 { y = animalViews[idx - columnCnt].frame.maxY + cellGap }
            animalViews[idx].pin.top(y).left(x).width(cellWidth).height(cellHeight)
        }
        animalContainerView.pin.wrapContent().center()
    }
}

// MARK: - Private Extensions

private extension AnimalKeyboardView {
    @objc func animalViewTouched(_ sender: UITapGestureRecognizer) {
        if let view = sender.view as? AnimalView {
            view.isSelected.toggle()
            if view.isSelected { selectedAnimals |= view.tag }
            else { selectedAnimals &= ~view.tag }
            delegate?.selectedAnimalChanged(selectedAnimals: selectedAnimals)
        }
    }
}
