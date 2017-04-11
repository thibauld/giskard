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

# define a class for managing several users


module Bot
	class Users
		def self.load_queries
			queries={
				'find_user_by_id'=>'SELECT * FROM fb_users WHERE id=$1',
				'insert_user'=>'INSERT INTO fb_users (id,firstname,lastname,profile) VALUES ($1,$2,$3,$4) RETURNING *',
				'update_user_profile'=>'UPDATE fb_users SET profile=profile || $2::jsonb WHERE id=$1 RETURNING *',
				'count_users'=>'SELECT COUNT(*) FROM fb_users'
			}
			queries.each { |k,v| Bot::Db.prepare(k,v) }
		end

		def initialize()
			@users={}
		end

		def add(user)
			## WARNING ## 
			# This is for example purpose only and will work with only 1 unicorn process.
			# If you use more than 1 unicorn process, you should save users in shared memory or a database to ensure data consistency between unicorn processes.
			return Bot::Db.query('insert_user',[user.sig,user.first_name,user.last_name,user.profile])
		end

		# given a User instance with a Bot name and an ID, we look into the database to load missing informations, or to create it in the database
		def open_user_session(user)
			res=self.search({
				:by=>"user_id",
				:target=> user.id
			})
			if res.nil? then # new user
				case user.bot #FIXME: this should be inside bot
				when TG_BOT_NAME then
					Bot.log.debug("Nouveau participant : #{user.first_name} #{user.last_name} (<https://telegram.me/#{user.username}|@#{user.username}>)")
				when FB_BOT_NAME then
					res              = URI.parse("https://graph.facebook.com/v2.6/#{user.id}?fields=first_name,last_name,profile_pic,locale,timezone,gender&access_token=#{FB_PAGEACCTOKEN}").read
					r_user           = JSON.parse(res)
					r_user           = JSON.parse(JSON.dump(r_user), object_class: OpenStruct)
					user.first_name  = r_user.first_name
					user.last_name   = r_user.last_name
					user.sig=Digest::SHA256.hexdigest(user.id)
					Bot.log.debug("Nouveau participant : #{user.first_name} #{user.last_name}")
				end
				self.add(user)
			else
				user.sig=Digest::SHA256.hexdigest(user.id)
				user.first_name = res['firstname']
				user.last_name = res['lastname']
				user.profile = res['settings']
			end
			@users[user.id]=user
			return user # we have to return the user because Ruby has no native deep copy
		end

		def save_user_session(user)
			res=Bot::Db.query('update_user_profile',[user.sig,user.profile])
		end

		def close_user_session(user)
			self.save_user_session(user)
			@users.delete(user.id)
		end

		def search(query)
			id=Digest::SHA256.hexdigest(query[:target])
			res=Bot::Db.query('find_user_by_id',[id])
			return res.num_tuples==0 ? nil : res[0]
		end

	end
end
