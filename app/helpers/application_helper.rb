module ApplicationHelper
  def page_title(page_title = '', admin: false)
    base_title = if admin
                   'BESPRE(管理画面)'
                 else
                   'BESPRE'
                 end

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def default_meta_tags
    {
      title: 'BESPRE',
      charset: 'utf-8',
      description: 'ベストな選択ができる欲しいもの公開サービス',
      keywords: 'BESPRE,欲しいものリスト',   # キーワードを「,」区切りで設定する
      canonical: request.original_url, # 優先するurlを指定する
      icon: [                    # favicon、apple用アイコンを指定する
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@knight92137'
      }
    }
  end
end
