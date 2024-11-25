#!/bin/bash

# 引数の確認
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <script_file> [hosts_file]"
    exit 1
fi

# スクリプトファイル（引数1）
SCRIPT_FILE="$1"

# ホストファイル（引数2: デフォルトは 'hosts.txt'）
HOSTS_FILE="${2:-hosts.txt}"

# スクリプトが存在するか確認
if [[ ! -f "$SCRIPT_FILE" ]]; then
    echo "Error: $SCRIPT_FILE not found!"
    exit 1
fi

# ホストリストが存在するか確認
if [[ ! -f "$HOSTS_FILE" ]]; then
    echo "Error: $HOSTS_FILE not found!"
    exit 1
fi

# ホストごとに処理を実行
while IFS= read -r HOST; do
    echo "Executing script $SCRIPT_FILE on $HOST..."
    cat "$SCRIPT_FILE" | ssh $HOST 'bash -s' &&
    echo "Successfully executed on $HOST" ||
    echo "Failed to execute on $HOST"
done < "$HOSTS_FILE"
