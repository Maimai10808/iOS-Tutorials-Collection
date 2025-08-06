import Foundation
import CoreXLSX
import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var errorMessage: String?
    
    func loadSchedule() {
        if let url = Bundle.main.url(forResource: "timetable", withExtension: "xlsx") {
            do {
                let file = try XLSXFile(filepath: url.path)
                let sharedStrings = try file.parseSharedStrings()
                let worksheets = try file.parseWorksheetPaths()
                
                // 假设第一个工作表是课表
                if let firstWorksheet = worksheets.first {
                    let worksheet = try file.parseWorksheet(at: firstWorksheet)
                    var tempCourses: [Course] = []
                    
                    // 从第二行开始读取数据（跳过表头）
                    for row in worksheet.rows.dropFirst() {
                        guard row.cells.count >= 7 else { continue }
                        
                        let cells = row.cells
                        let getCellValue = { (cell: Cell) -> String in
                            if let value = cell.value {
                                if let index = Int(value),
                                   let sharedString = sharedStrings?.items[index].text {
                                    return sharedString
                                }
                                return value
                            }
                            return ""
                        }
                        
                        // 假设Excel表格列的顺序是：课程名、教师、教室、星期、开始节次、结束节次、周次
                        let course = Course(
                            name: getCellValue(cells[0]),
                            teacher: getCellValue(cells[1]),
                            classroom: getCellValue(cells[2]),
                            weekday: Int(getCellValue(cells[3])) ?? 1,
                            startTime: Int(getCellValue(cells[4])) ?? 1,
                            endTime: Int(getCellValue(cells[5])) ?? 2,
                            weekRange: getCellValue(cells[6])
                        )
                        tempCourses.append(course)
                    }
                    
                    DispatchQueue.main.async {
                        self.courses = tempCourses
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "读取课表失败: \(error.localizedDescription)"
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "未找到课表文件"
            }
        }
    }
} 