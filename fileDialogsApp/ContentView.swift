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
    

import SwiftUI

struct ContentView: View {
    
    @State var selectedInputFile: String = ""
    @State var selectedOutputFile: String = ""
    @State var selectedFolder: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button("Open a file") {
                    if let selectedFile = FileHelpers.selectTextFile(
                        withTitle: "Select a text file") {

                        selectedInputFile = selectedFile.path()
                    } else {
                        selectedInputFile = "No file selected"
                    }
                }
                Button("Save file as") {
                    if let saveTo = FileHelpers.selectTextFileToSave(withTitle: "Save file to...") {
                        selectedOutputFile = saveTo.path()
                    } else {
                        selectedOutputFile = "No file selected - save cancelled"
                    }
                }
                Button("Select folder") {
                    if let targetFolder = FileHelpers.selectFolder() {
                        selectedFolder = targetFolder.path()
                        
                        print(selectedFolder)
                    } else {
                        selectedFolder = "No folder was selected"
                    }
                }
                Divider().frame(height: 20)
                Button("Open xyz file") {
                    if let selectedFile = FileHelpers.selectSingleXYZFile(
                        withTitle: "Select an XYZ file") {

                        selectedInputFile = selectedFile.path()
                    } else {
                        selectedInputFile = "No file selected"
                    }
                }

            }
            Divider()
            
            Form {
                LabeledContent("Selected File", value: selectedInputFile)
                LabeledContent("Output File", value: selectedOutputFile)
                LabeledContent("Selected Folder", value: selectedFolder)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
