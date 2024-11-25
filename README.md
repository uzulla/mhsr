m.sh
======

`m.sh`は、指定されたスクリプトファイルを複数のホストにおいて実行するためのシェルスクリプトです。

## 使用方法

```bash
./m.sh <script_file> [hosts_file]
```

- `<script_file>`: 実行したいスクリプトファイルを指定します。
- `[hosts_file]`: スクリプトを実行するホストのリストを含むファイルを指定します。省略した場合、デフォルトで `hosts.txt` が使用されます。

## 例

以下の例では、`deploy.sh` スクリプトを `hosts.txt` に記載されたホストに対して実行します。

```bash
./m.sh deploy.sh
```

ホストリストファイルを指定する場合は、次のように実行します。

```bash
./m.sh deploy.sh custom_hosts.txt
```

## 注意事項

1. 各ホストに対してSSH接続が可能であることを確認してください。
2. bashが実行可能であることを確認してください。

## `hosts_file`の書き方

`hosts_file` ファイルには、sshするホストのホスト名またはIPアドレスを1行ずつ記載します。コメントなどはつかえません。

`ssh $HOST 'bash ...` という形で渡されるので、うまく書けばsshへのオプションも渡すことが可能です。

`hosts.txt`の例

```
192.168.0.1
user@example.jp
-i key another@example.com
```
