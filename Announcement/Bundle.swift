//
//  Bundle.swift
//  Webサイトから借用。ファイル上のJsonファイルを利用するサイト
//
//  Created by Yousuke Hasegawa on 2021/12/03.
//

import Foundation

extension Bundle {
   func decodeJSON<T: Codable>(_ file: String) -> T {
       // ①プロジェクト内にある"steps.json"ファイルのパス取得
       guard let url = self.url(forResource: file, withExtension: nil) else {
           fatalError("Faild to locate \(file) in bundle.")
       }
       // ②steps.jsonの内容をData型プロパティに読み込み
       // Data型の定数 dataをして代入
       guard let data = try? Data(contentsOf: url) else {
           fatalError("Failed to load \(file) from bundle.")
       }
       
       // ③JSONデコード処理
       //data をloadedに代入
       let decoder = JSONDecoder()
       guard let loaded = try? decoder.decode(T.self, from: data) else {
           fatalError("Failed to decode \(file) from bundle.")
       }
       
       // ④loadedを呼び出し元に返す。
       return loaded
   }
}
