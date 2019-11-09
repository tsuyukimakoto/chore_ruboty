# chore ruboty

## Install ruby via rbenv on macOS

### Install rbenv and ruby-build via brew

brew入ってない場合にはググって入れる。

```
$ brew install rbenv ruby-build
```

zshを使ってるので、 `~/.zshrc` の末尾に追加しちゃう。

```
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

### Install ruby

rbenvでどんなRubyをインストールできるのか確認する。

```
$ rbenv install -l
```

ただの数字のやつを入れたい。

2019/11/09時点では2.6.5が最新っぽい（2019/10/01版？）。

```
$ rbenv install 2.6.5
```

再び `~/.zshrc` の末尾に追加しちゃう

```
rbenv global 2.6.5
```

.zshrcを読み直すかシェルに入り直すかしたら良いかな。

## Install ruboty

```
$ gem install ruboty
```

## Initialize ruboty project

rubotyってフォルダ作って、1行書かれたGemfileを置くだけかな？

```
$ ruboty --generate
```

適当なフォルダ作ってGemfile置けば良さそう。

```
$ cd ruboty
$ cat Gemfile
source "https://rubygems.org"

gem "ruboty"
```

## Integration with Slack

`Bots` というアプリを追加して適当に決めたSlackのユーザ名を指定する。

Tokenが発行されるので、 `.env` というファイルに `SLACK_TOKEN=` 形式で保存する。

`.env` は `.gitignore` に突っ込んでおかねば。 `www.gitignore.io` で生成したら良いな。giboより簡単だ。

`.env` はコメントアウトされてるかもしれないのでちゃんと確認しないと危ない。

### Run with Slack Integration

`SLACK_TOKEN` 環境変数が存在していたらSlack連携する模様。

なので、Slack連携する場合には

```
$ bundle exec ruboty --dotenv
```

Slack連携せずに手元で試すには

```
$ bundle exec ruboty
```

で起動すれば良いのかな？（よくない）

実際は、 `-l` でプラグインファイルを指定する必要がありそう（複数ファイルはどうするのかとかはまだ知らない）。

#### Slack連携を外すには

Gemfileからruboty-slack_rtmを外せば良いのかな。

コメントアウトしたらローカルになる。

```
# gem "ruboty-slack_rtm"
```

## Write Plugins

`Ruboty::Handlers::Base` を継承したクラスを作って、onメソッドと、反応するときに呼ばれる関数を書く。

モジュールとクラスを表す書き方を知らないので適当に書いているけれど、 `Ruboty` と `Handlers` はモジュールで `Base` はクラスかな。

呼び掛けずに反応させる場合にはonメソッドのallをtrueにすれば良い。
