//
//  File.swift
//  Class Schedule
//
//  Created by mac on 3/11/25.
//

import UIKit
import CoreXLSX

func loadXLSXFile() {
    // 获取文件路径（假设课表文件名是 "timetable.xlsx"）
    if let url = Bundle.main.url(forResource: "timetable", withExtension: "xlsx") {
        do {
            let file = try XLSXFile(filepath: url.path)
            
            // 获取工作表路径
            let worksheets = try file.parseWorksheetPaths()
            
            // 用于存储课表数据
            var timetableData: [[String: Any]] = []
            
            // 读取每一个工作表
            for path in worksheets {
                let worksheet = try file.parseWorksheet(at: path)
                
                // 假设第一行是表头，跳过第一行
                var rowIndex = 0
                
                // 遍历所有行
                for row in worksheet.rows {
                    // 跳过表头
                    if rowIndex == 0 {
                        rowIndex += 1
                        continue
                    }
                    
                    var rowData: [String: Any] = [:]
                    
                    var columnIndex = 0
                    for cell in row.cells {
                        // 根据列的不同，获取不同的数据
                        if let value = cell.value {
                            switch columnIndex {
                            case 0:
                                rowData["week"] = value  // 周次
                            case 1:
                                rowData["date"] = value  // 日期
                            default:
                                let columnName = "class\(columnIndex - 1)" // 课程
                                rowData[columnName] = value
                            }
                        }
                        columnIndex += 1
                    }
                    
                    // 将当前行数据添加到课表数据中
                    timetableData.append(rowData)
                }
            }
            
            // 将课表数据转化为 JSON 数据
            let jsonData = try JSONSerialization.data(withJSONObject: timetableData, options: .prettyPrinted)
            
            // 将 JSON 数据保存为文件
            if let jsonFilePath = getDocumentsDirectory()?.appendingPathComponent("timetable.json") {
                try jsonData.write(to: jsonFilePath)
                print("JSON file saved at: \(jsonFilePath)")
            }
            
        } catch {
            print("Error reading XLSX file: \(error)")
        }
    } else {
        print("Failed to find timetable.xlsx in the bundle.")
    }
}

// 获取应用程序的 Documents 目录
func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths.first
}

