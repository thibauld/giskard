# encoding: utf-8

=begin
   Copyright 2016 Telegraph-ai

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=end

# implement a user for facebook

module Giskard
	module FB
		class User < Giskard::Core::User
			attr_accessor :id   # id in the database = id in Facebook
			attr_accessor :mail
			attr_accessor :last_msg_time

			# database queries to prepare
			def self.load_queries
				queries={
					'find_user_by_id'=>'SELECT * FROM fb_users WHERE id=$1',
					'insert_user'=>'INSERT INTO fb_users (id,firstname,lastname,fb_id) VALUES ($1,$2,$3,$4) RETURNING *',
					'update_user_profile'=>'UPDATE fb_users SET profile=profile || $2::jsonb WHERE id=$1 RETURNING *',
					'count_users'=>'SELECT COUNT(*) FROM fb_users'
				}
				queries.each { |k,v| Bot.db.prepare(k,v) }
			end

			def initialize(id)
				@id = id
				@sig=Digest::SHA256.hexdigest(@id.to_s) if @id.to_i>0
				@last_msg_time = 0
				super()
			end

			# look at the database whether the user has already been created
			# return the user in this case
			# return a nil if the user does not exist
			def load
				res=Bot.db.query('find_user_by_id',[@sig])
				return false if res.num_tuples.zero?
				@fb_id = res[0]['fb_id'].to_i
				@first_name = res[0]['firstname']
				@last_name = res[0]['lastname']
				@profile = res[0]['profile']
				#@uid = res[0]['uid'].to_i
				#@last_msg_time = DateTime.parse(res[0]['last_msg_time']).strftime('%s').to_i
				@messenger = FB_BOT_NAME
				#super
				return true
			end

			def create
				@messenger = FB_BOT_NAME
				# get info from facebook
				begin
					res = URI.parse("https://graph.facebook.com/v2.6/#{user.id}?fields=first_name,last_name,profile_pic,locale,timezone,gender&access_token=#{FB_PAGEACCTOKEN}").read
				rescue Exception=>e
					Bot.log.error "Error retrieving user fb profile info: #{e}\n#{e.msg}"
				end
				r_user           = JSON.parse(res)
				r_user           = JSON.parse(JSON.dump(r_user), object_class: OpenStruct)
				@first_name  = r_user.first_name
				@last_name   = r_user.last_name
				@sig 	     = Digest::SHA256.hexdigest(@id) if @id.to_i>0
				#@last_msg_time = 1000000

				# save in database
				#super
				Bot.log.debug("New user : #{@first_name} #{@last_name}")
				Bot.db.query('insert_user',[@sig,@first_name,@last_name,@id])
			end

			# save in the database the user with its fsm
			def save(profile=nil)
				@profile=profile unless profile.nil?
				Bot.db.query('update_user_profile',[@sig,@profile])
				#super
			end

			# check if the message has already been answered
			def already_answered?(msg)
				return false # FIXME
				return false if msg.seq ==-1 # external command
				if @last_msg_time > 0 and @last_msg_time >= msg.timestamp then
					Bot.log.debug "Message already answered: last msg time: #{@last_msg_time} and this msg time: #{msg.timestamp}"
					return true
				else
					@last_msg_time = msg.timestamp
					return false
				end
			end
		end # end class
	end # end module FB
end # Giskard
