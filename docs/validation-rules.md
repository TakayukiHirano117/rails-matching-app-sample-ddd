# 概要
これらは各集約と集約内のエンティティや値オブジェクトについての制約を定めたものです。
集約は整合性を保って変更する単位です。
また各エンティティはIdを元にして互いに参照します。

## User集約
### User
名前(1文字以上50文字以内)
メールアドレス(メールアドレス形式)
パスワード(8文字以上英数字のみかつ英数字それぞれ1文字以上)
プロフィール(Profileの参照)

### Profile
UserId
自己紹介(1000文字以内)
顔写真(今回はuser_imagesテーブルなどは作らず１枚のみとする。)

## Like集約
### Like
いいねを送ったUserのid
いいねを送られたUserのid


## Match集約
### Match
UserId1
UserId2


## Message集約
SenderId
ReceiverId
メッセージ内容
作成日時

## Conversation集約



