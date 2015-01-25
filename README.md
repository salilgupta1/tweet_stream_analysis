A program that reads five minutes of tweets from Twitter Streaming Api and calculates word frequency and total word count. 

If you wanted to stop the program and then restart the streaming and pick up from the previous word count you could possibly store the word count in a database for future retrieval. You could also just save it in a file and read the file in when you are about to start the streaming again. Then you can take the word count and initialize the word_count instance variable of the TweetAnalysis object to whatever the previous value was. 

In order to run you must install tweetstream gem.

Then run: 

ruby tweet_stream_analysis.rb