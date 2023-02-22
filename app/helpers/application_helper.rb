module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'BESPRE'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'BESPRE',
      title: 'お互いにベストな選択ができる欲しいもの公開サービス',
      reverse: true,
      charset: 'utf-8',
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: 'ページの説明',
      keywords: 'ページキーワード',   #キーワードを「,」区切りで設定する
      canonical: request.original_url,   #優先するurlを指定する
      noindex: ! Rails.env.production?,
      icon: [                    #favicon、apple用アイコンを指定する
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@knight92137'
      }
    }
  end
end
