check() {
    if [ $1 != 0 ]; then
        echo "NG"
        exit 0
    else
        echo "OK"
    fi 
}
