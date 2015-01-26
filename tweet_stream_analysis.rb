require 'tweetstream'
require 'time'

class TweetAnalysis
	
	@@stop_words = ['was','amp','your','are','this','that','im','who','the','a','for','i','you','and','me','it','or','but','&amp;','to','on','if','with','as','is','be','in','my','of','not','at','so']

	def initialize
		@word_count = 0
		@tweets = []
		@word_freq = Hash.new(0)

		# config set up
		TweetStream.configure do |config|
			config.consumer_key       = 'nieAysyV2MJZ4XYP6kMB4FwUj'
			config.consumer_secret    = '3m9x9jvFoxpTsA6pDp5gcOdGWzNRZ5Wa6h1ExOCBxf8DU9yfxc'
			config.oauth_token        = '2579555235-ciNSq2XlzgVpVnrcIFWwELzo30fEMybFET0EAB6'
			config.oauth_token_secret = 'qUiRqJbDNEdD4gBsGELNKQOx3VK9wBCorDvWunMWL8Yue'
			config.auth_method        = :oauth
		end
	end

	def get_tweets

		# pulls data from twitter for 5 minutes

		end_time = Time.now + 5*60

		# pull english tweets
		TweetStream::Client.new.sample(language: 'en') do |status, client|

			if Time.now >= end_time
				client.stop
			else
				# collect tweet text
				@tweets.push(status.text)
			end
		end
	end

	def parse_tweets
		# parse text of each tweet

		@tweets.each do |tweet|

			# remove RT
			clean_tweet = tweet.gsub("RT","")

			# remove any non-word chars and non-spaces
			clean_tweet = clean_tweet.gsub(/[^\w\s]/,"")

			#remove spaces at front and end of string
			clean_tweet = clean_tweet.strip

			words = clean_tweet.split(" ")
			words.each do |word|
				# if it isn't a stop word
				# and doesn't contain http (link)
				if ( !@@stop_words.include? word.downcase ) && ( !word.include? "http" )
					@word_count += 1
					@word_freq[word] += 1
				end
			end
		end
	end

	def print_results
		puts "Word count (not including stop words and links): #{@word_count}"

		# sort hash by word_freq and return top 10 
		top_ten = @word_freq.sort_by{ |k,v| v }.reverse[0...10]

		puts "Top ten most common words: #{top_ten}"
	end 

end

start_time = Time.now()
tweet_analysis = TweetAnalysis.new()
puts "Currently getting tweets from Twitter ....."
tweet_analysis.get_tweets
puts "Getting the tweets took: #{Time.now()- start_time} seconds"

start_time = Time.now()
tweet_analysis.parse_tweets
puts "Parsing Tweets took #{Time.now() - start_time} seconds"

tweet_analysis.print_results



