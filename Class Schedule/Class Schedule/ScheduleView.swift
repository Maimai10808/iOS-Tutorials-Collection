import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    private let weekdays = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
    private let timeSlots = Array(1...12) // 假设一天最多12节课
    
    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    // 表头
                    HStack(spacing: 0) {
                        TimeSlotHeaderView()
                        ForEach(weekdays, id: \.self) { weekday in
                            Text(weekday)
                                .frame(width: 100, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .border(Color.gray.opacity(0.3), width: 1)
                        }
                    }
                    
                    // 课表内容
                    HStack(spacing: 0) {
                        // 时间槽
                        VStack(spacing: 0) {
                            ForEach(timeSlots, id: \.self) { slot in
                                Text("\(slot)")
                                    .frame(width: 40, height: 60)
                                    .border(Color.gray.opacity(0.3), width: 1)
                            }
                        }
                        
                        // 课程格子
                        ForEach(1...7, id: \.self) { weekday in
                            VStack(spacing: 0) {
                                ForEach(timeSlots, id: \.self) { slot in
                                    CourseCell(courses: viewModel.courses, weekday: weekday, timeSlot: slot)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("课程表")
            .onAppear {
                viewModel.loadSchedule()
            }
            .alert("错误", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("确定", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

struct TimeSlotHeaderView: View {
    var body: some View {
        Text("节次")
            .frame(width: 40, height: 40)
            .background(Color.gray.opacity(0.2))
            .border(Color.gray.opacity(0.3), width: 1)
    }
}

struct CourseCell: View {
    let courses: [Course]
    let weekday: Int
    let timeSlot: Int
    
    private var coursesForCell: [Course] {
        courses.filter { course in
            course.weekday == weekday &&
            timeSlot >= course.startTime &&
            timeSlot <= course.endTime
        }
    }
    
    var body: some View {
        ZStack {
            if let course = coursesForCell.first {
                VStack(spacing: 2) {
                    Text(course.name)
                        .font(.system(size: 12))
                        .bold()
                    Text(course.classroom)
                        .font(.system(size: 10))
                    Text(course.teacher)
                        .font(.system(size: 10))
                }
                .padding(4)
                .frame(width: 100, height: 60)
                .background(Color.blue.opacity(0.1))
                .border(Color.gray.opacity(0.3), width: 1)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 100, height: 60)
                    .border(Color.gray.opacity(0.3), width: 1)
            }
        }
    }
}

#Preview {
    ScheduleView()
} 