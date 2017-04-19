//
//  SectionView.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 12/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

protocol SectionViewDelegate {
    
    func sectionViewWantsToOpen(_ sectionView: SectionView)
}

class SectionView: NSView {

    static let defaultWidth: CGFloat = 56.0
    
    var containerLeftConstraint: NSLayoutConstraint!
    var contentRightConstraint: NSLayoutConstraint!
    var containerView: ContainerView!
    var nibName: String? { return nil }
    
    private(set) var isOpen = false
    var titleButton: NSButton!
    var delegate: SectionViewDelegate?
    var contentController: SectionContentController
    
    var header: SectionContentHeader?
    var wantsHeader: Bool { return true }
    
    var color: NSColor
    var titleColor: NSColor {
        return color.shadow(withLevel: 0.4)!
    }
    
    init(title: String, color: NSColor, controller: SectionContentController) {
        
        self.color = color
        self.contentController = controller
        
        super.init(frame: .zero)
        
        setup()
        
        layer!.backgroundColor = color.cgColor
        setTitle(title)
    }
    
    private func setup() {
        
        widthAnchor.constraint(greaterThanOrEqualToConstant: SectionView.defaultWidth).isActive = true
        
        titleButton = NSButton(title: "", target: self, action: #selector(titleButtonClicked(_:)))
        titleButton.isBordered = false
        titleButton.frame = CGRect(x: 0, y: 0, width: SectionView.defaultWidth, height: self.frame.height)
        titleButton.autoresizingMask = .viewHeightSizable
        titleButton.translatesAutoresizingMaskIntoConstraints = true
        titleButton.rotate(byDegrees: -90)
        addSubview(titleButton)
        
        widthAnchor.constraint(equalToConstant: SectionView.defaultWidth).isActive = true
        
        containerView = ContainerView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        let containerOptLeftConstraint = containerView.leftAnchor.constraint(equalTo: self.leftAnchor)
        containerOptLeftConstraint.priority = NSLayoutPriorityDefaultHigh
        containerOptLeftConstraint.isActive = true
        
        containerLeftConstraint = containerView.leftAnchor.constraint(equalTo: titleButton.rightAnchor)
        containerLeftConstraint.isActive = true
        
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let contentView = createContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        contentView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        let contentBottomConstraint = contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        contentBottomConstraint.priority = 200
        contentBottomConstraint.isActive = true
        
        contentView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor).isActive = true
        
        let contentCenterYConstraint = contentView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        contentCenterYConstraint.priority = NSLayoutPriorityDefaultLow
        contentCenterYConstraint.isActive = true
        
        let contentMaxWidthConstraint = contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 800.0)
        contentMaxWidthConstraint.isActive = true
        
        contentView.heightAnchor.constraint(lessThanOrEqualToConstant: 700.0).isActive = true
        
        contentRightConstraint = contentView.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        contentRightConstraint.priority = 250
        contentRightConstraint.isActive = true
        
        if let nibName = self.nibName {
            loadContentFromNib(named: nibName)
        }
        
        wantsLayer = true
    }
    
    func createContentView() -> NSView {
        
        let mainView = contentController.view
        
        if contentController.wantsHeader {
            return mainView
        }
        
        let contentView = NSView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        let header = SectionContentHeader(title: "PÁGINAS", description: "O capítulo agrupa páginas distintas do seu playground.")
        header.color = color.shadow(withLevel: 0.5)!
        self.header = header
        
        let headerView = header.view
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(headerView)
        contentView.addSubview(mainView)
        
        contentView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        contentView.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        
        mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        return contentView
    }
    
    private func loadContentFromNib(named nibName: String) {
        Bundle.main.loadNibNamed(nibName, owner: self, topLevelObjects: nil)
    }
    
    func setTitle(_ title: String) {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let text = NSMutableAttributedString(string: title.uppercased(), attributes: [
            NSForegroundColorAttributeName: titleColor,
            NSParagraphStyleAttributeName: paragraph,
            NSFontAttributeName: NSFont(name: "HelveticaNeue-Bold", size: 24.0)!,
        ])
        
        titleButton.attributedTitle = text
    }
    
    func open(animated: Bool = true) {
        
        if isOpen {
            return
        }
        isOpen = true
        
        let actions = {
            self.removeConstraint(self.widthConstraint!)
            self.contentRightConstraint.constant = 0.0
            self.titleButton.alphaValue = 0.0
            self.containerLeftConstraint.isActive = false
        }
        
        if animated {
            runConstraintAnimations(withDuration: 0.3, animations: actions)
        }
        else {
            actions()
        }
    }
    
    func close(animated: Bool = true) {
        
        if !isOpen {
            return
        }
        isOpen = false
        
        let actions = {
            self.widthAnchor.constraint(equalToConstant: SectionView.defaultWidth).isActive = true
            self.contentRightConstraint.constant = self.contentController.view.bounds.width
            self.titleButton.alphaValue = 1.0
            self.containerLeftConstraint.isActive = true
        }
        
        if animated {
            runConstraintAnimations(withDuration: 0.3, animations: actions)
        }
        else {
            actions()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func titleButtonClicked(_ sender: NSButton) {
        delegate?.sectionViewWantsToOpen(self)
    }
}
