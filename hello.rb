module Ruboty
    module Handlers
        class Hello < Base
            on(/hello/i, name: "hello", description: "こんにちわー")

            def hello(message)
                message.reply("Hello!")
            end
        end
        class MontyHandler < Base
            on(/.*(スパム|エッグ).*/, name: 'spam', all: true)

            def spam(message)
                message.reply("ハム！")
            end
        end
    end
end
