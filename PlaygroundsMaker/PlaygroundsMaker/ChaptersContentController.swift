//
//  ChaptersContentController.swift
//  PlaygroundsMaker
//
//  Created by Adilson Tavares on 18/04/17.
//  Copyright © 2017 Adilson Tavares. All rights reserved.
//

import Cocoa

class ChaptersContentController: SectionContentController, NSTableViewDataSource {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var chaptersController: NSArrayController!
    
    private var draggingRow: Int?
    private var draggingChapter: Chapter? {
        if let index = draggingRow {
            return chapters[index]
        }
        return nil
    }
    
    var chapters = [
        Chapter(name: "1 chapter"),
        Chapter(name: "2 chapter"),
        Chapter(name: "3 chapter"),
        Chapter(name: "4 chapter")
    ]
    
    init() {
        super.init(nibName: "ChaptersSectionContent")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(forDraggedTypes: ["public.text"])
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        
        let chapter = chapters[row]
        draggingRow = row
        
        let item = NSPasteboardItem()
        item.setString(chapter.name ?? "[Chapter]", forType: "public.text")
        
        return item
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        
        if dropOperation.rawValue == NSDragOperation.copy.rawValue && row >= 0 && row <= chapters.count && row != draggingRow && row != (draggingRow! + 1) {
            return .move
        }
        
        return []
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        
        guard let oldRow = draggingRow, let chapter = draggingChapter else {
            return false
        }
        
        tableView.beginUpdates()
        
        if oldRow < row {
            
            chapters.insert(chapter, at: row)
            chapters.remove(at: oldRow)
            
            tableView.moveRow(at: oldRow, to: row - 1)
        }
        else {
            
            chapters.remove(at: oldRow)
            chapters.insert(chapter, at: row)
            
            tableView.moveRow(at: oldRow, to: row)
        }
        
        tableView.endUpdates()
        
        draggingRow = nil
        
        return true
    }
}
