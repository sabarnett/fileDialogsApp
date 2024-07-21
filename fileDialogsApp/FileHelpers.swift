//
// -----------------------------------------
// Original project: fileDialogsApp
// Original package: fileDialogsApp
// Created on: 20/07/2024 by: Steven Barnett
// Web: http://www.sabarnett.co.uk
// GitHub: https://www.github.com/sabarnett
// -----------------------------------------
// Copyright © 2024 Steven Barnett. All rights reserved.
//

import Foundation
import AppKit
import UniformTypeIdentifiers

struct FileHelpers {
    
    public static func selectTextFile(withTitle windowTitle: String?) -> URL? {
        let textTypes: [UTType] = [UTType.plainText]
        return selectSingleInputFile(ofType: textTypes, withTitle: windowTitle)
    }
    
    public static func selectSingleInputFile(ofType fileTypes: [UTType],
                                             withTitle windowTitle: String?) -> URL? {

        let openPrompt = FileHelpers().createOpenPanel(ofType: fileTypes,
                                                      withTitle: windowTitle)

        let result = openPrompt.runModal()

        if result == NSApplication.ModalResponse.OK {
            let fName = openPrompt.urls

            guard fName.count == 1 else { return nil }
            return fName[0].absoluteURL
        }

        return nil
    }
    
    private func createOpenPanel(ofType: [UTType],
                                 withTitle: String?,
                                 allowsMultiple: Bool = false) -> NSOpenPanel {

        let openPrompt = NSOpenPanel()

        if let titlePrompt = withTitle {
            openPrompt.message = titlePrompt
        }

        openPrompt.allowsMultipleSelection = allowsMultiple
        openPrompt.canChooseDirectories = false
        openPrompt.canChooseFiles = true
        openPrompt.resolvesAliases = true
        openPrompt.allowedContentTypes = ofType

        return openPrompt
    }
    
    // MARK: - Save functions
    
    public static func selectTextFileToSave(withTitle windowTitle: String?) -> URL? {
        let textTypes: [UTType] = [.plainText]
        return selectSaveFile(ofType: textTypes, withTitle: windowTitle)
    }
    
    public static func selectSaveFile(ofType fileTypes: [UTType], withTitle windowTitle: String?) -> URL? {

        let openPrompt = FileHelpers().createSavePanel(ofType: fileTypes, withTitle: windowTitle)

        let result = openPrompt.runModal()

        if result == NSApplication.ModalResponse.OK {
            let fName = openPrompt.url
            return fName
        }

        return nil
    }
    
    private func createSavePanel(ofType: [UTType], withTitle: String?) -> NSSavePanel {

        let openPrompt = NSSavePanel()

        if let titlePrompt = withTitle {
            openPrompt.message = titlePrompt
        }

        openPrompt.allowsOtherFileTypes = true
        openPrompt.canCreateDirectories = true
        openPrompt.prompt = "Save As..."
        openPrompt.allowedContentTypes = ofType
        openPrompt.nameFieldLabel = "Enter file name:"
        openPrompt.nameFieldStringValue = "file"

        return openPrompt
    }
    
    // MARK: Folder Selection
    
    public static func selectFolder() -> URL? {

        let openPrompt = FileHelpers().createOpenPanel(ofType: [], withTitle: nil)

        openPrompt.canChooseDirectories = true
        openPrompt.canChooseFiles = false
        let result = openPrompt.runModal()

        if result == NSApplication.ModalResponse.OK {
            let fName = openPrompt.urls

            guard fName.count == 1 else { return nil }
            return fName[0].absoluteURL
        }

        return nil
    }
}
