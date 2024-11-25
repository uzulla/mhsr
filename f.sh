#!/bin/bash

# 引数の確認
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <file_to_send> [remote_directory] [hosts_file]"
    exit 1
fi

# 送信するファイル（引数1）
FILE_TO_SEND="$1"

# リモートディレクトリ（引数2: デフォルトは HOME DIR）
REMOTE_DIR="${2:-~}"

# ホストファイル（引数3: デフォルトは 'hosts.txt'）
HOSTS_FILE="${3:-hosts.txt}"

# ファイルが存在するか確認
if [[ ! -f "$FILE_TO_SEND" ]]; then
    echo "Error: $FILE_TO_SEND not found!"
    exit 1
fi

# ホストリストが存在するか確認
if [[ ! -f "$HOSTS_FILE" ]]; then
    echo "Error: $HOSTS_FILE not found!"
    exit 1
fi

# ホストごとにファイルを送信
while IFS= read -r HOST; do
    echo "Sending file $FILE_TO_SEND to $HOST:$REMOTE_DIR..."
    cat "$FILE_TO_SEND" | ssh "$HOST" "sudo tee $REMOTE_DIR/$(basename "$FILE_TO_SEND") > /dev/null" &&
    echo "Successfully sent to $HOST:$REMOTE_DIR" ||
    echo "Failed to send to $HOST:$REMOTE_DIR"
    ssh $HOST "sudo chmod +x $REMOTE_DIR/$(basename "$FILE_TO_SEND")" &&
    echo "Successfully chmod $REMOTE_DIR/$(basename "$FILE_TO_SEND")" ||
    echo "Failed to chmod $REMOTE_DIR/$(basename "$FILE_TO_SEND")"
done < "$HOSTS_FILE"
