## CFC Virtuosoハンズオン資料 (Aug 2017; @稲毛海岸) ##

## タイムテーブル ##

| 時間(分) | 項目 | 種類 |
|-|-|-|
|  0-15  | オープンデータの共有と利用アプローチ | プレゼン |
| 15-45  | Virtuosoのインストールとサンプルデータのロード | ハンズオン |
| 45-75  | SPARQLの紹介 | プレゼン |
| 75-120 | データ検索 | ハンズオン |

## リンク ##
* [Code For Chiba / Virtuosoハンズオン](http://www.wherevent.com/detail/Code-for-Chiba-%E3%82%AA%E3%83%BC%E3%83%97%E3%83%B3%E3%83%87%E3%83%BC%E3%82%BF%E3%82%92%E6%B5%81%E9%80%9A%E3%81%95%E3%81%9B%E3%82%8B%E3%81%AB%E3%81%AF%EF%BC%9F-Virtuoso-%E3%83%8F%E3%83%B3%E3%82%BA%E3%82%AA%E3%83%B3)
* [AWS EC2文書](https://aws.amazon.com/jp/documentation/ec2/)
    * [SSH接続](http://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html)
* [Virtuoso Open-Source Edition](http://vos.openlinksw.com/owiki/wiki/VOS/)
    * [Bulk Loader](http://vos.openlinksw.com/owiki/wiki/VOS/VirtBulkRDFLoader)
* [YAGO](http://www.mpi-inf.mpg.de/departments/databases-and-information-systems/research/yago-naga/yago/)
* [SPARQLクエリ言語](http://www.asahi-net.or.jp/~ax2s-kmtn/internet/rdf/REC-sparql11-query-20130321.html)

## AWS設定 ##
(事前準備？)

### キーペア作成
* 安全な場所に保管
### セキュリティグループ作成
* sshとhttpを外部からアクセス許可するルールを追加
### EC2 t2.microインスタンスを作成
* AMI: Amazon Linux AMI 2017.03.1 (HVM), SSD Volume Type - ami-3bd3c45c
* インスタンスタイプ: t2.micro
* インスタンス設定: 全てデフォルト
* ストレージ要領: 20GB
* タグ: なし
* セキュリティグループ: 上記作成したSGを選択

## Virtuoso設定 ##
### コードをダウンロード (3m 22s) ###

    $ mkdir wrk
    $ cd wrk
    $ wget https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.4.2/virtuoso-opensource-7.2.4.2.tar.gz
    $ tar zxvf virtuoso-opensource-7.2.4.2.tar.gz
    $ cd virtuoso-opensource-7.2.4.2

### ツールのインストール ###

    $ sudo yum-config-manager --enable epel
    $ sudo yum install gcc gmake autoconf automake libtool flex bison gperf gawk m4 make openssl-devel readline-devel wget git p7zip

### インストール ###
(ここまで事前準備？)

    $ ./configure --prefix=/usr/local/ -with-readline
    $ make              # 8-9m
    $ sudo make install # 4s

#### 起動 ####

    $ cd /usr/local/var/lib/virtuoso/db/
    $ sudo chown -R ec2-user .
    $ virtuoso-t -df

#### webサーバに接続 ####

    http://<インシタンスのグローバルアドレス>:8890/

※これを使う場合はAWSセキュリティグループで8890を空けておくこと。

#### isqlに接続 ####

    $ isql localhost:1111 dba dba

## データのロード ##

	$ cd /home/ec2-user/wrk
    $ git clone https://github.com/zambendorf/cfc2017aug.git

    $ cd /usr/local/var/lib/virtuoso/db
    $ sudo ln -s /home/ec2-user/wrk/cfc2017aug/dat

    $ isql localhost:1111 dba dba
    SQL> LOAD 'src/rdfloader.sql';

* 続きは、src/laod-data.sql

## SPARQLによる検索 ##

* src/query-data.sql

----
Kiyoshi Nitta <<knitta@acm.org>>
