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

module Api
	def self.included(base)
		Bot.log.info "loading Api add-on"
		messages={
			:en=>{
				:api=>{
					:vote_completed=>"Le vote s'est-il correctement déroulé ?",
					:vote_completed_11=>"Le vote concernant les 11 candidat(e)s officiels s'est-il correctement déroulé ?",
					:vote_completed_4=>"Le vote concernant les 4 candidat(e)s non-officiels s'est-il correctement déroulé ?"
				}
			},
			:fr=>{
				:api=>{
					:vote_completed=>"Le vote s'est-il correctement déroulé ?",
					:vote_completed_11=>"Le vote concernant les 11 candidat(e)s officiels s'est-il correctement déroulé ?",
					:vote_completed_4=>"Le vote concernant les 4 candidat(e)s non-officiels s'est-il correctement déroulé ?"
				}
			}
		}
		screens={
			:api=>{
				:vote_completed=>{
					:kbd=>[
						{"text"=>"home/vote_ok","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png"},
						{"text"=>"home/vote_ko","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png"}
					]
				},
				:vote_completed_11=>{
					:callback=>"api/vote_11",
					:kbd=>[
						{"text"=>"home/vote_ok_11","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png"},
						{"text"=>"home/vote_ko_11","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png"}
					]
				},
				:vote_completed_4=>{
					:callback=>"api/vote_4",
					:kbd=>[
						{"text"=>"home/vote_ok_4","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png"},
						{"text"=>"home/vote_ko_4","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png"}
					]
				},

			}
		}
		Bot.updateScreens(screens)
		Bot.updateMessages(messages)
	end

	def api_vote_11(msg,user,screen)
		Bot.log.debug "#{__method__}"
		return self.get_screen(screen,user,msg)
	end

	def api_vote_4(msg,user,screen)
		Bot.log.debug "#{__method__}"
		return self.get_screen(screen,user,msg)
	end
end

include Api
