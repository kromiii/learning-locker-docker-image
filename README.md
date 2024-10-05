# learning-locker-docker-image

https://github.com/LearningLocker/learninglocker の Docker イメージです。

ghcr でイメージを公開しています

https://github.com/kromiii/learning-locker-docker-image/pkgs/container/learninglocker

マルチアーキテクチャ（AMD64, ARM64）対応しています。

docker compose で動かしたい方はこのレポジトリをクローンして

```
docker-compose up -d
```

してもらえれば localhost:3000 で learning locker が起動するようになっています

ローカルで build したい場合

```
docker compose build learninglocker
```

## 初期設定

=== Learning Locker
==== Admin ユーザの作成
Learning Locker の Admin ユーザを作成する。

---

EMAIL_ADDRESS=admin@example.com
ORGANIZATION=personal
PASSWORD=password123
docker exec \
 -e EMAIL_ADDRESS=${EMAIL_ADDRESS} \
  -e ORGANIZATION=${ORGANIZATION} \
 -e PASSWORD=${PASSWORD} learninglocker bash -c '\
    source ~/.bashrc;
    node ./cli/dist/server createSiteAdmin "${EMAIL_ADDRESS}" "${ORGANIZATION}" "${PASSWORD}"'

---

==== ログイン
Learning Locker( http://localhost:3000/ )に Admin ユーザのアカウントでログインし、組織を選択する。

[cols="a,a", frame=none, grid=none]
|===
| image::learninglocker/login.png[]
| image::learninglocker/select-org.png[]
|===

==== LRS の作成
サイドメニューの `[Settings] > [Stores]` から任意の名称で LRS を作成する。

image::learninglocker/stores.png[align=center]

[[learninglocker_client_settings]]
==== クライアントの設定
サイドメニューの `[Settings] > [Clients]` から `New xAPI store client` を選択する。 +
`LRS (optional)` に上記で作成した LRS が指定されていることを確認し、 `Overall Scopes` の `API All` にチェックを入れる。

image::learninglocker/new-xapi-store-client.png[align=center]
