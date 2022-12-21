//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Dependencies
import Kingfisher

extension AsyncImage: DependencyKey {

    public static var liveValue: AsyncImage {
        return AsyncImage(setImage: { url, imageView in
            imageView.kf.setImage(with: url)
        })
    }

}
