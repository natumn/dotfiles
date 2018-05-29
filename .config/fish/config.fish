# set up path
set -x -U GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x PATH $GOROOT/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/google-cloud-sdk/bin $PATH
set -x PATH $HOME/google-cloud-sdk/platform/google_appengine $PATH

# set up alias
# redis dump.rdbの作成場所を指定した状態でredis-serverを起動する 参考:https://blog.kotamiyake.me/tech/output-dump-rdb-to-current-directory/
function redis-server
    redis-server /usr/local/etc/redis.conf $argv
end

