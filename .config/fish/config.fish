# set up path
set -x -U GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x PATH $GOROOT/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/tools/google-cloud-sdk/bin $PATH
set -x PATH $HOME/tools/google-cloud-sdk/platform/google_appengine $PATH
set -x PATH $HOME/tools/mongodb-osx-x86_64-enterprise-4.0.0/bin $PATH
set -x PATH $HOME/tools/spark-2.0.0-bin-hadoop2.7/bin $PATH
set -x JAVA_HOME '/usr/libexec/java_home -v 1.8'
set -x PATH $HOME/tools/jads/ $PATH
set -x PATH /Users/natsumekoki/Library/Android/sdk/platform-tools $PATH
set -x PATH /Users/natsumekoki/Library/Android/sdk/tools $PATH

# set up alias
# redis dump.rdbの作成場所を指定した状態でredis-serverを起動する 参考:https://blog.kotamiyake.me/tech/output-dump-rdb-to-current-directory/
function redis-server
   command redis-server /usr/local/etc/redis.conf $argv
end

function pcd 
    cd ( ls -1d */ | peco )
end

alias lg='lazygit'
