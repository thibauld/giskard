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

module Home
	def self.included(base)
		Bot.log.info "loading Home add-on"
		messages={
			:en=>{
				:home=>{
					:welcome_answer=>"/start",
					:welcome=><<-END,
Hello %{firstname} !
My name is Giskard, I am an intelligent bot.. or at least as intelligent as you make me #{Bot.emoticons[:smile]}
This is an example program for you to get acustomed to how I work.
But enough talking, let's begin !
END
					:menu_answer=>"#{Bot.emoticons[:home]} Home",
					:menu=><<-END,
What do you want to do ? Please use below buttons to tell me what you would like to do.
END
					:jm_yes_answer=>"Yes I do",
					:jm_yes=><<-END,
Great ! Let's proceed directly to the vote then.
END
					:ask_email_answer=>"My email",
					:ask_email=><<-END,
What is your email ?
END
					:email_saved=><<-END,
Your email is %{email} !
END
					:email_wrong=><<-END,
Hmmm... %{email} doesn't look like a valid email #{Bot.emoticons[:confused]}
END
					:jm_no_answer=>"No, please tell me more",
					:jm_no=><<-END,
Sure thing !
The majority judgement is [blabla...]
END
					:official_candidates=><<-END,
Having considered everything, how would you rate the following candidates :
END
					:tres_bien=>"Very good",
					:bien=>"Good",
					:assez_bien=>"Rather good",
					:passable=>"Mediocre",
					:insuffisant=>"Insufficient",
					:a_rejeter=>"Rejected",
					:understood=>"Ok understood\n",
					:francois_fillon_answer=>"F. Fillon",
					:francois_fillon=>"How would you rate François Fillon ?",
					:nicolas_dupont_aignan_answer=>"N. Dupont-Aignan",
					:nicolas_dupont_aignan=>"How would you rate Nicolas Dupont-Aignan ?",
				}
			},
			:fr=>{
				:home=>{
					:welcome_answer=>"/start",
					:welcome=><<-END,
Bonjour !
Merci de votre participation à cette expérimentation scientifique. Sachez que votre vote est anonyme et que vos données personnelles ne sont pas enregistrées.
En introduction, connaissez-vous déjà le jugement majoritaire ?
END
					:menu_answer=>"#{Bot.emoticons[:home]} Accueil",
					:menu=><<-END,
Que voulez-vous faire ? Utilisez les boutons du menu ci-dessous pour m'indiquer ce que vous souhaitez faire.
END
					:jm_yes_answer=>"Oui je connais déjà",
					:jm_yes=><<-END,
Parfait, nous pouvons donc dès à présent procéder au vote !
END
					:email_saved=><<-END,
Votre email est %{email} !
END
					:email_wrong=><<-END,
Hmmm... %{email} n'est pas un email valide #{Bot.emoticons[:confused]}
END
					:jm_no_answer=>"Non, dites m'en plus",
					:jm_no=><<-END,
Avec plaisir !
Le jugement majoritaire c'est [blabla...]
END
					:official_candidates=><<-END,
Ayant pris en considération tout ce qui va bien, comment jugez-vous les candidats suivants :
END
					:tres_bien=>"Très bien",
					:bien=>"Bien",
					:assez_bien=>"Assez bien",
					:passable=>"Passable",
					:insuffisant=>"Insuffisant",
					:a_rejeter=>"A rejeter",
					:understood=>"Ok bien noté\n",
					:francois_fillon_answer=>"F. Fillon",
					:francois_fillon=>"Comment noteriez-vous François Fillon",
					:nicolas_dupont_aignan_answer=>"N. Dupont-Aignan",
					:nicolas_dupont_aignan=>"Comment noteriez-vous Nicolas Dupont-Aignan ?",
				}
			}
		}
		screens={
			:home=>{
				:welcome=>{
					:answer=>"home/welcome_answer",
					:kbd=>[
						{"text"=>"home/jm_no"},
						{"text"=>"home/jm_yes"}
					],
					:kbd_options=>{:resize_keyboard=>true,:one_time_keyboard=>false,:selective=>true}
				},
				:menu=>{
					:answer=>"home/menu_answer",
					#:callback=>"home/menu",
					:parse_mode=>"HTML",
					:kbd=>[
						{"text"=>"home/jm_no"},
						{"text"=>"home/jm_yes"}
					]
				},
				:jm_yes=>{
					:answer=>"home/jm_yes_answer",
					:jump_to=>"home/official_candidates"
				},
				:jm_no=>{
					:answer=>"home/jm_no_answer",
					:jump_to=>"home/fillon"
				},
				:email_saved=>{
					:jump_to=>"home/menu"
				},
				:email_wrong=>{
					:jump_to=>"home/menu"
				},
				:tres_bien=>{
					:answer=>"home/tres_bien",
					:jump_to=>"home/understood"
				},
				:bien=>{
					:answer=>"home/bien",
					:jump_to=>"home/understood"
				},
				:assez_bien=>{
					:answer=>"home/assez_bien",
					:jump_to=>"home/understood"
				},
				:passable=>{
					:answer=>"home/passable",
					:jump_to=>"home/understood"
				},
				:insuffisant=>{
					:answer=>"home/insuffisant",
					:jump_to=>"home/understood"
				},
				:a_rejeter=>{
					:answer=>"home/a_rejeter",
					:jump_to=>"home/understood"
				},
				:understood=>{
					:jump_to=>"home/official_candidates"
				},
				:official_candidates=>{
					:kbd=>[
						{"text"=>"home/nicolas_dupont_aignan"},
						#"home/marine_le_pen",
						#"home/emmanuel_macron",
						#"home/benoit_hamon",
						#"home/nathalie_arthaud",
						#"home/philippe_poutou",
						#"home/jacques_cheminade",
						#"home/jean_lassalle",
						#"home/jean_luc_melenchon",
						#"home/francois_asselineau",
						{"text"=>"home/francois_fillon"}
					]
				},
				:francois_fillon=>{
					:answer=>"home/francois_fillon_answer",
					:kbd=>[
						{"text"=>"home/tres_bien","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/tresbien.png" },
						{"text"=>"home/bien", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png" },
						{"text"=>"home/assez_bien", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/assezbien.png" },
						{"text"=>"home/passable", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/passable.png" },
						{"text"=>"home/insuffisant", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png" },
						{"text"=>"home/a_rejeter", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/arejeter.png" }
					]
				},
				:nicolas_dupont_aignan=>{
					:answer=>"home/nicolas_dupont_aignan_answer",
					:kbd=>[
						{"text"=>"home/tres_bien","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/tresbien.png" },
						{"text"=>"home/bien", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png" },
						{"text"=>"home/assez_bien", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/assezbien.png" },
						{"text"=>"home/passable", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/passable.png" },
						{"text"=>"home/insuffisant", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png" },
						{"text"=>"home/a_rejeter", "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/arejeter.png" }
					],
					#:kbd=>[
					#	"home/tres_bien",
					#	"home/bien",
					#	"home/assez_bien",
					#	"home/passable",
					#	"home/insuffisant",
					#	"home/a_rejeter"
					#],
					#:options=>{
					#	:kbd=>{
					#		"home/tres_bien"=>{ "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/tresbien.png" },
					#		"home/bien"=>{ "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png" },
					#		"home/assez_bien"=>{ "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/assezbien.png" },
					#		"home/passable"=>{ "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/passable.png" },
					#		"home/insuffisant"=>{ "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png" },
					#		"home/a_rejeter"=>{ "image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/arejeter.png" }
					#	}
					#}
				}
			}
		}
		Bot.updateScreens(screens)
		Bot.updateMessages(messages)
		Bot.addMenu({:home=>{:menu=>{:kbd=>{"text"=>"home/menu"}}}})
	end

	def home_welcome(msg,user,screen)
		Bot.log.info "#{__method__}"
		screen=self.find_by_name("home/menu",self.get_locale(user))
		return self.get_screen(screen,user,msg)
	end

	def home_menu(msg,user,screen)
		Bot.log.info "#{__method__}"
		screen[:kbd_del]=["home/menu"] #comment if you want the home button to be displayed on the home menu
		user.next_answer('answer')
		return self.get_screen(screen,user,msg)
	end

	def home_ask_email(msg,user,screen)
		Bot.log.info "#{__method__}"
		user.next_answer('free_text',1,"home/save_email_cb")
		return self.get_screen(screen,user,msg)
	end

	def home_save_email_cb(msg,user,screen)
		email=user.state['buffer']
		Bot.log.info "#{__method__}: #{email}"
		if email.match(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/).nil? then
			screen=self.find_by_name("home/email_wrong",self.get_locale(user))
			screen[:text]=screen[:text] % {:email=>email}
			return self.get_screen(screen,user,msg)
		end
		screen=self.find_by_name("home/email_saved",self.get_locale(user))
		screen[:text]=screen[:text] % {:email=>email}
		return self.get_screen(screen,user,msg)
	end
end

include Home
