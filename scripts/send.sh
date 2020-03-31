#!/bin/bash
# 指定のマシンに対して、自マシンの本スクリプトを実行したディレクトリをコピーします。
# >事前指定環境変数
# - export ADDRESSES="マシン１ マシン２ ..."
# >引数
# 1:マシンのユーザ名
# 2:マシンのパスワード
USER=$1
PASSWORD=$2
PROJECT_DIR=$(cd  $(dirname $0); pwd)
PARENT_OF_PROJECT_DIR=`dirname ${PROJECT_DIR}`
SCP_PORT=22
# 開始メッセージ、確認
echo "send this directry -> $PROJECT_DIR "
echo "to"
echo "this place -> $PARENT_OF_PROJECT_DIR"

# 実行コマンド のパーツ(ループ内不変)
# A)ディレクトリ削除
EXECUTE_DELETE_DIR="sudo  $PROJECT_DIR"
# B)親ディレクトリ作成 
EXECUTE_MKDIR="sudo mkdir -p $PARENT_OF_PROJECT_DIR"
# password省略
SSHPASS_CMD="sshpass -p $PASSWORD"

# 【option】StrictHostKeyChecking:初めてのホストに接続したとき、警告を出すか否か
# 　　〃　　 UserKnownHostFile 空を読み込ませて、毎回初めてのホストに繋いでるようにさせる
SSH_OPTIONS="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# チェック用関数
check() {
    if [ $1 != 0 ]; then
        echo "NG"
        exit 0
    else
        echo "OK"
    fi 
}
for ADDRESS in $ADDRESSES
do
    # 実行コマンド のパーツ(ループ内変化)
    SSH_CMD="ssh ${USER}@${ADDRESS}"
    SCP_CMD="scp -P $SCP_PORT -r $PROJECT_DIR ${USER}@${ADDRESS}:$PARENT_OF_PROJECT_DIR"
    # A)実行
    $SSHPASS_CMD $SSH_CMD $SSH_OPTIONS $EXECUTE_DELETE_DIR
    res=$?
    check $res
    # B)実行
    $SSHPASS_CMD $SSH_CMD $SSH_OPTIONS $EXECUTE_MKDIR 
    res=$?
    check $res
    # コピー
    $SSHPASS_CMD $SCP_CMD $SSH_OPTIONS 
    res=$?
    check $res
done

# 終了
echo "finished to copy this directory  !!!"