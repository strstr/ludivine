class Answer
    def remember
        @memory.connect

        if @message.split(' ')[1] == 'that'
            @message = @message.sub('that', '').strip
        end

        @message = @message.sub('remember', '').strip

        termSplit = termToSplit(@message)
        name = termSplit[0]
        value = termSplit[1]
        term = termSplit[2]

        if value.include?('http')
            return 'I cannot remember URLs.'
        end

        if name != '' && value != '' && term != ''
            @memory.save(@username, name, value)
            return 'I will remember that *' + nlpResponse(name) + '*' + term + "*#{value}*."
        end

        "What do you want me to remember #{@username}?"
    end

    def nlpResponse(words)
        words = ' ' + words + ' '
        words = words.sub(' my ', ' _your_ ')
        words = words.sub(' me ', ' _you_ ')
        words = words.sub(' your ', ' _my_ ')
        words = words.sub(' you ', ' _me_ ')
        words = words.gsub('_', '')

        words.strip
    end

    def termToSplit(msg)
        terms = %w(is are have has)
        if msg.split(' ').length > 2
            for term in terms
                name = msg.split(' ' + term + ' ')[0].to_s.strip
                value = msg.split(' ' + term + ' ')[1].to_s.strip
                if name != '' && value != ''
                    return [name, value, ' ' + term + ' ']
                end
            end
        end
        ['', '', '']
    end
end
