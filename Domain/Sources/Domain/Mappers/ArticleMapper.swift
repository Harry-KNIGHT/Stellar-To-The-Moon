//
//  ArticleMapper.swift
//  
//
//  Created by Elliot Knight on 23/07/2023.
//

import Foundation
import StellarAPI

extension Article {
	init(dto: ArticleDTO) {
		self.title = dto.title
		self.copyright = dto.coryright
		self.explanation = dto.explanation
		self.mediaUrl = dto.mediaURL
		self.date = dto.date
	}
}
