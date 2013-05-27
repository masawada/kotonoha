# Authentication - 認証仕様

## 概要
ことのはのAPIを叩く際、leafの操作にはアクセス認証を必要とする。HMAC-SHA256ハッシュをシグネチャとして添付する。以下で詳細を記述する。

## 認証の手順
認証の必要なAPIリクエストに対して、Signature文字列とTimestamp文字列を同時に送信する。

### Timestamp文字列
ISO8601準拠の日付・時間の文字列をTimestampとしてリクエストクエリパラメータに追加する。

    example:
    timestamp=2013-03-10T18:06:29.040Z

この文字列は認証にのみ使われ、実際に保存されるタイムスタンプにはサーバの情報が用いられる。

### Signature文字列
Signature文字列の作成方法について以下に記述する。

1. 1行目にリクエストメソッドを記述する。
2. 2行目にリクエスト先のapi_root_uriを記述する。
3. 3行目に叩くREST APIを記述する。
4. 4行目にリクエストのクエリをkey1=a&key2=b...という形で記述する。
  * このときkeyはアルファベット順にソートする。小文字よりも大文字の方が上位である。

4行目のクエリのvalue部分は予めencodeURIComponentと同等のURIエンコードを施す。

それぞれの行の最後に付加する改行は\nとする。

これらをもとにSecretKeyを用いてHMAC-SHA256ハッシュをとり、Base64でエンコードしたものをencodeURIComponentと同等のURIエンコードを施し、signature=[signature string]という形でリクエストクエリの最後に付加する。

    example:

    String to hash:
      DELETE
      example.com
      /statuses/destroy/1
      access=1-WKZ8aBLXOL9Um1naxss6OJn3uZ5otufXEy8n7g%3D%3D&timestamp=2013-03-12T12%3A18%3A33.117Z

    Secret key:
      TD6nCKf3uJN5x22dDTjWFMOHlOV+1Zu4kupSNdQshI8=

これらの操作によりアクセス認証をうけることができる。

