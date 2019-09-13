# filmsearch
## URL
https://filmearch.herokuapp.com/

# 制作理由

このアプリケーションを作成した目的として以下をあげる:

* 自分の好きなアプリケーションの模擬サイトを作ることによるスキルの向上

* スクールでの学びのアウトプット
　（ranking表示、pagination機能、devise機能、review投稿機能実装）

* 経験にない実装の挑戦(javascriptを使用したslider機能、modal windowの作成、google map apiによる映画館を探す機能の実装、いいね機能の実装)

* 今後の課題
　映画館を探す機能におけるユーザーの位置情報埋め込み、user同士におけるチャット画面の実装、映画サイトのカテゴリー分類
 
# 苦労した点
- 映画情報のデータ収集(Scraping使用)
  - データ参照先に記載の自分が欲しいデータはページ遷移の層が深くコードの処理が重い。
  - 映画情報の一覧画面が用意されていない→つまり全映画情報を取得できる方法を考える必要があった。
- いいね機能の実装
  - 非同期にて『いいね』投稿はできるが、一旦ブラウザをリロードしないと『いいね』を取り消せない
- modal window
  - index画面からform_withを使用してレビューを投稿する際に、作品とレビューを紐付けること
  　→　つまり一つ一つの作品とmodalを結びつけることに多くの時間を費やした。
- sliderと数値の連動
  - javascriptの処理　→　この実装自体は私自身がjavascriptに技術力向上のため意識があるため実装に時間を割いた。
  
 # 上記解決方法
 - 映画情報のデータ収集(Scraping使用)
 [![Image from Gyazo](https://i.gyazo.com/bb012ddf93429859f2fc6f8c7a45117d.png)](https://gyazo.com/bb012ddf93429859f2fc6f8c7a45117d)
 [![Image from Gyazo](https://i.gyazo.com/46d7dbf623909bded96e44a8821f1566.png)](https://gyazo.com/46d7dbf623909bded96e44a8821f1566)
 データ参照元のサイトでは一覧で映画情報を記載してある訳ではなく、ジャンルカテゴリーに分類され、一つ一つのジャンルに対して映画の情報がページネーションされて参照できる構造であった。
 当初、scrapingする際には1枚目画像におけるジャンルのurlを取得し、2枚目の画像先に遷移し、一つのジャンルに対して2枚目画像における右側の映画情報を取得するという方法を取っていたが、eachにおける処理、それから元データの量も多く、scrapingに相当な時間がかかってしまったため、2枚目画像のページから一回一回ジャンルのurlを手入力で入力し、1枚目画像におけるジャンルを取得するeach処理を自分で行なうことにより時間、pcへの負担を軽減した。
 [![Image from Gyazo](https://i.gyazo.com/cbebf3bb29a6cd3290a7d86268583a3c.png)](https://gyazo.com/cbebf3bb29a6cd3290a7d86268583a3c)
 上記画像のコメントアウトがない状態で、つまり一回のScrapingで全データを取得しようとしたが処理が重いため、コメントアウトを施し、`movie_urls("当初は参照先大元のurl")`を`movie_urls("各ジャンルurl")`と変更。
 
- いいね機能の実装
 [![Image from Gyazo](https://i.gyazo.com/59594d8f9787ae97909276c4feedaa71.png)](https://gyazo.com/59594d8f9787ae97909276c4feedaa71)
 `destroy.js.erb`において`par.attr('method', 'POST');`の記載をしているにも関わらず、『いいね』を取り消そうとすると、console上にて次のエラーが確認された。エラー内容は`'method','get'`となってしまう現象であり、このエラーをなかなか解決できないでいたが、上記画像における`create.js.erb`における3~5行目を記載することで問題を解決し、非同期にて『いいね取り消し』が可能となった。
 
- modal windowの実装
[![Image from Gyazo](https://i.gyazo.com/bc75e70e304ca7de36e7fda94c44634c.png)](https://gyazo.com/bc75e70e304ca7de36e7fda94c44634c)
eachによる変数`product`を用いて、一つ一つの映画作品を`product.id`として取り出していて、modalとの結びつきをどのように記載すれば上手く処理できるのかということに多くの時間、頭を悩ませていたが、`data-target="#Modal<%= product.id %>`と記載することでmodalと各作品がひもづき、レビューが保存されるように実装可能となった。

- sliderと数値の連動
この部分の実装としては、自己研鑽によるものなので割愛する。

# DB設計
## productsテーブル

|Column|Type|Options|
|------|----|-------|
|title|string||
|image_url|text||
|director|string||
|detail|text||
|open_date|string||
|likes_count|references|null: false, foreign_key: true|

### Association
- has_many :reviews
- has_many :likes, dependent: :destroy
- has_many :users, through: :likes

## reviewsテーブル

|Column|Type|Options|
|------|----|-------|
|review|string||
|product_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
|rate|float||

### Association

- belongs_to :product
- belongs_to :user

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|email|string||
|password|string||
|password_confirmation|string||
|nickname|string||
  

### Association

- has_many :reviews
- has_one_attached :avatar
- has_many :likes
- has_many :products, through: :likes

## theatersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|prefecture|text||
|address|text||

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :product, counter_cache: :likes_count
- belongs_to :user

# function&behavior
## loged off
[![Image from Gyazo](https://i.gyazo.com/ba7861c0e51961b34974e99db5af5502.gif)](https://gyazo.com/ba7861c0e51961b34974e99db5af5502)
## sign up
[![Image from Gyazo](https://i.gyazo.com/732c67d6ab49bac7a09db16c5e7bc046.gif)](https://gyazo.com/732c67d6ab49bac7a09db16c5e7bc046)
## modal window&slider
[![Image from Gyazo](https://i.gyazo.com/06eecffe8ca3dc80442479481d33cf45.gif)](https://gyazo.com/06eecffe8ca3dc80442479481d33cf45)
## Ranking Display
[![Image from Gyazo](https://i.gyazo.com/9e73117c13f2ba40949defaa9b9fe9a6.gif)](https://gyazo.com/9e73117c13f2ba40949defaa9b9fe9a6)
## search
[![Image from Gyazo](https://i.gyazo.com/526130e93962b4167d68a726ac208235.gif)](https://gyazo.com/526130e93962b4167d68a726ac208235)
## look for theater
[![Image from Gyazo](https://i.gyazo.com/b81e85d23f5a582ea8daf19475a8930f.gif)](https://gyazo.com/b81e85d23f5a582ea8daf19475a8930f)
## look for theater with address
[![Image from Gyazo](https://i.gyazo.com/0c40327d0e2c4bacc85d9c38dd24077b.gif)](https://gyazo.com/0c40327d0e2c4bacc85d9c38dd24077b)
[![Image from Gyazo](https://i.gyazo.com/f65a051a4471b39dc4c48230f1962f68.gif)](https://gyazo.com/f65a051a4471b39dc4c48230f1962f68)
## usermypage
[![Image from Gyazo](https://i.gyazo.com/013978de22c159c585af837036de8d2c.png)](https://gyazo.com/013978de22c159c585af837036de8d2c)

# 課題
## データの充実度
現状、映画のあらすじを取得できていない状態である。というのもScrapingでは元サイトのjavascriptが使用されている箇所からデータを取得できないためである。今回のScrapingでは`mechanize`を主に使用しているが、javascript使用部分においてはデータ取得が困難であったため`selenium`を使用したScrapingも試してみたが、非常に長い時間をかけてデータを取得するため、実用的ではないという判断に至りました。Scrapingを使用した理由としてはカリキュラムの基礎復習であるためであり、より実践的なapplicationとして運用していくためには今後はAPIを使用していきたいと考えています。
`THE MOVIE DB :https://www.themoviedb.org/`を使用したいと考え、APIkeyを既に取得しているため、今後はそのコード処理を実装していきたいと考えています。

## user page,chat機能の追加
スクールカリキュラムにおいて、chatAPPを作成したので、その復習やアウトプットとしてuser同士が映画情報を交換できるようにchat機能の実装にも挑戦したいところである。

## category,genreにおける分類
現状、index画面では映画情報が無作為に並べられておりpaginationで数十ページと、見た目も宜しくないので、カテゴリー別に分類していきたいところである。

## gitにおけるcommit,branch作成の精度と意識
このアプリ作成後にスクールにおいて実施されたグループ開発においてcommitの精度とブランチを機能ごとに作っていくことにの大切さを痛感しました。グループ開発において学習したことを活かすためにも、今後個人で開発を進めていく際にはbranch、commitの作成には特に意識を置いて実装していきたいところです。

## IOSアプリ
これは希望ですが、現在`swift`を学習しているので、iphoneアプリとしても映画アプリを作成できれば良いと考えています。
