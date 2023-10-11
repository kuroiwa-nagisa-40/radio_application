# radio_application
# [サービス名]
ラジオ好きに向けたSNS

## サービス概要
ラジオのマイタイムテーブルを作成してラジオ好きと繋がれるサービス

##　想定されるユーザー層
ラジオが好きな人
周りにラジオ好きが少なくて、共通の趣味の人と繋がりたい人
TwitterなどのSNSと比較し、感想の投稿だけでなく、自身のマイタイムテーブルや聴取履歴を作成できることで、
テキストベースより分かりやすく、直感的に他のユーザと交流が可能です。
また、自分のためのタイムテーブルを作れること、さらに聴衆履歴からこれまで聴いてきた番組を振り返ることができることから、
ユーザ自身の日記のような感覚でも利用することができます。



## サービスコンセプト
私自身ラジオが好きなことからラジオをテーマに選びました。
ラジオの番組表は公式のHPやradiko等で確認ができますが、そこから自分だけのタイムテーブルを作り共有したり、
好きなラジオ番組への感想を投稿することができるプラットフォームが作れれば良いなと思っています。
他のユーザのタイムテーブルを見て同じような趣味の人を見つけたり、気になるラジオが見つけられるような発見の場所にもなると良いなと思います。
体感ですが、周りにラジオ好きが少なく、ラジオ好きな人と出会えると嬉しいので、「同じ仲間がいる・・ ！」という感覚から、
見るだけでも良し、コメントしても良しなささやかな共有の場所としても新たにあってもいいのかなと思いました。

## 実装を予定している機能
### MVP
* 会員登録
* ログイン
* 番組表閲覧
* 番組詳細ページ閲覧
* 番組表から自分専用のマイタイムテーブルが作成できる
* マイタイムテーブルを公開できる
* 番組の感想を投稿できる
* 他のユーザの感想を閲覧できる
* 通常の投稿もできる(つぶやきのイメージ)
* 通常の投稿を閲覧できる
* ラジオ番組をクリックしたら詳細画面より概要の確認とメールアドレスが確認できる⇨そこからメーラー起動させ、メールを送れる
* 投稿に対していいねができる
* ユーザのフォロー機能
* 自分の聴衆履歴を残せる＆公開できる
    →「聴いた」ボタンをクリックすることでマイページに聴衆履歴として残るイメージです、グラフ表示に対応して
    1週間、1ヶ月など自身の聴衆履歴を振り返ることができる形です。
* マルチ検索・オートコンプリート
    →ラジオを検索する時に番組名やパーソナリティ、放送局などさまざまなカラムから検索可能とします。


### その後の機能
* マイテーブルに沿ってラジオ開始の通知
* マイタイムテーブルに加え、気になるラジオリストの作成
(他のユーザのタイムテーブルや番組表等から今度聴いてみたい番組をコレクションできるイメージ)
* ユーザや番組のレコメンド機能
(同じラジオの趣味のユーザをおすすめしたり、聴いていないラジオをおすすめするような機能)
* 音楽プレイリストの作成
(ラジオで流れた曲を検索し、投稿に紐付けたり、プレイリスト化できるようなイメージ)


### 画面遷移図(figma)
https://www.figma.com/file/9wAk71gxkV2eqbNI2EjWMj/Untitled?type=design&node-id=12%3A667&mode=design&t=KPkyVP7d0mEoJX8E-1

### ER図
https://app.diagrams.net/#G140qISBSfQmuXz61R4GHPVNHMijX6SHfO