
import SwiftUI
import FeedKit


func fetchRSSFeed() {
    // 设置 RSS Feed 的 URL
    guard let feedURL = URL(string: "https://www.healthline.com/feed") else { return }
    
    // 创建 FeedParser 实例
    let parser = FeedParser(URL: feedURL)

    // 异步解析 RSS Feed
    parser.parseAsync { result in
        switch result {
        case .success(let feed):
            // 成功解析 RSS Feed 后，处理数据
            if let rssFeed = feed.rssFeed {
                // 打印标题和链接以查看结果
                for item in rssFeed.items ?? [] {
                    print("Title: \(item.title ?? "No Title")")
                    print("Link: \(item.link ?? "No Link")")
                    print("Description: \(item.description ?? "No Description")")
                }
            }
        case .failure(let error):
            // 解析失败时，打印错误
            print("Failed to fetch RSS feed: \(error)")
        }
    }
}
