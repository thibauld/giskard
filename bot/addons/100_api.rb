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
					:vote_completed=>"Le vote s'est-il correctement déroulé ?"
				}
			},
			:fr=>{
				:api=>{
					:vote_completed=>"Le vote s'est-il correctement déroulé ?"
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
				}
			}
		}
		Bot.updateScreens(screens)
		Bot.updateMessages(messages)
	end
end

include Api
