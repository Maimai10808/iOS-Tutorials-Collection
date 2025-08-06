import Cocoa

class HexoMarkdownUpdater {
    
    let fileManager = FileManager.default
    let hexoRoot = "/Volumes/material 1/hexo-blog"
    var markdownFilePath: String?
    var coverImagePath: String?
    var language: String?
    
    func getCurrentDatetime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    func updateMarkdownFile() -> String? {
        guard let mdFilePath = markdownFilePath else { return "❌ 错误：Markdown 文件路径无效" }
        
        let fileName = URL(fileURLWithPath: mdFilePath).lastPathComponent
        let title = fileName.replacingOccurrences(of: ".md", with: "")
        let currentDatetime = getCurrentDatetime()
        
        // 读取原始 Markdown 文件
        guard let content = try? String(contentsOfFile: mdFilePath, encoding: .utf8) else {
            return "❌ 错误：无法读取文件"
        }
        
        // 查找 front-matter 区域
        guard let frontMatterRange = content.range(of: "---\n") else {
            return "❌ 错误：文件没有有效的 front-matter"
        }
        
        // 查找 front-matter 结束位置
        let endOfFrontMatterRange = content.range(of: "\n---", range: frontMatterRange.upperBound..<content.endIndex)
        
        guard let frontMatterEnd = endOfFrontMatterRange else {
            return "❌ 错误：找不到 front-matter 结束位置"
        }
        
        // 创建新的 front-matter
        var newFrontMatter = [
            "---\n",
            "title: \(title)\n",
            "date: \(currentDatetime)\n",
            "lang: \(language ?? "en")\n"
        ]
        
        // 保留 tags 和 categories
        let frontMatterContent = content[frontMatterRange.upperBound..<frontMatterEnd.lowerBound]
        for line in frontMatterContent.split(separator: "\n") {
            if line.trimmingCharacters(in: .whitespaces).hasPrefix("tags:") || line.trimmingCharacters(in: .whitespaces).hasPrefix("categories:") {
                newFrontMatter.append("\(line)\n")
            }
        }
        
        newFrontMatter.append("---\n")
        
        let updatedContent = newFrontMatter.joined() + content[frontMatterEnd.upperBound...]
        return updatedContent
    }
    
    func saveUpdatedMarkdown(newContent: String) -> String {
        guard let language = language else { return "❌ 错误：语言未选择" }
        
        let hexoPostDir = "\(hexoRoot)/source/_posts/\(language)"
        let targetMdPath = "\(hexoPostDir)/\(URL(fileURLWithPath: markdownFilePath ?? "").lastPathComponent)"
        
        do {
            try fileManager.createDirectory(atPath: hexoPostDir, withIntermediateDirectories: true, attributes: nil)
            try newContent.write(toFile: targetMdPath, atomically: true, encoding: .utf8)
            return "✅ 文件已保存到：\(targetMdPath)"
        } catch {
            return "❌ 错误：保存文件失败，原因：\(error)"
        }
    }
    
    func copyCoverImage() -> String {
        guard let coverImagePath = coverImagePath else { return "❌ 错误：封面图片路径无效" }
        
        let hexoImagesDir = "\(hexoRoot)/source/images"
        
        do {
            try fileManager.createDirectory(atPath: hexoImagesDir, withIntermediateDirectories: true, attributes: nil)
            let coverImageDest = "\(hexoImagesDir)/\(URL(fileURLWithPath: coverImagePath).lastPathComponent)"
            try fileManager.copyItem(atPath: coverImagePath, toPath: coverImageDest)
            return "✅ 封面图片已复制到：\(coverImageDest)"
        } catch {
            return "❌ 错误：封面图片复制失败，原因：\(error)"
        }
    }
    
    func runHexoDeploy() -> String {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", "cd \(hexoRoot) && hexo clean && hexo g -d"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        
        task.launch()
        task.waitUntilExit()
        
        return task.terminationStatus == 0 ? "🎉 博客已成功更新！" : "❌ 部署失败，请检查 Hexo 配置和命令执行情况"
    }
    
    func uploadMarkdown(mdFilePath: String, coverImagePath: String, language: String) {
        self.markdownFilePath = mdFilePath
        self.coverImagePath = coverImagePath
        self.language = language
        
        if let updatedContent = updateMarkdownFile() {
            if updatedContent.contains("❌ 错误") {
                print(updatedContent)
            } else {
                let saveMessage = saveUpdatedMarkdown(newContent: updatedContent)
                print(saveMessage)
                
                let copyMessage = copyCoverImage()
                print(copyMessage)
                
                let deployMessage = runHexoDeploy()
                print(deployMessage)
            }
        }
    }
}

// 示例用法
let markdownPath = "/path/to/your/markdown.md"
let coverImagePath = "/path/to/cover/image.png"
let language = "en"

let updater = HexoMarkdownUpdater()
updater.uploadMarkdown(mdFilePath: markdownPath, coverImagePath: coverImagePath, language: language)
