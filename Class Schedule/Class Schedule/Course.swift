import Foundation

struct Course: Identifiable {
    let id = UUID()
    let name: String
    let teacher: String
    let classroom: String
    let weekday: Int // 1-7 代表周一到周日
    let startTime: Int // 第几节课开始
    let endTime: Int // 第几节课结束
    let weekRange: String // 上课周次，如"1-16周"
} 