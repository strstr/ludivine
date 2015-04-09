#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer
	def say
		if @username == 'slackbot' then return  'Stop messing with me...' end

		cleanMessage = @message.sub('say ', '').strip

		if cleanMessage.include? 'in channel'
			parts = cleanMessage.split('in channel')
			channel = parts[1].strip
			cleanMessage = parts[0].strip
			sayInChannel('#' + channel, cleanMessage)
		else
			return cleanMessage
		end

		cleanMessage
	end
end
