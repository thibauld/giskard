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
					:try_again_answer=>"Réessayer",
					:vote_paused=>"Désolé le vote est temporairement suspendu. Reessayez dans quelques minutes, merci de votre compréhension !",
					:welcome_answer=>"/start",
					:welcome=><<-END,
Hello !
My name is Giskard, I am an intelligent bot.. or at least as intelligent as you make me #{Bot.emoticons[:smile]}
This is an example program for you to get acustomed to how I work.
But enough talking, let's begin !
END
					:jm_yes_answer=>"Yes I do",
					:jm_yes=><<-END,
Great ! Let's proceed directly to the vote then.
END
					:jm_no_answer=>"No, please tell me more",
					:jm_no=><<-END,
Sure thing !
The majority judgement is [blabla...]
END
					:understood_answer=>"Continuer",
					:understood=><<-END,
Top #{Bot.emoticons[:thumbs_up]}
Passons au vote alors !
END
					:vote_ok_answer=>"Oui",
					:vote_ok=>"Content de voir que tout s'est bien passé !\n",
					:vote_ko_answer=>"Non j'ai eu un souci",
					:vote_ko=>"Désolé que le vote ne se soit pas bien passé, pouvez-vous nous contacter pour nous dire ce qu'il s'est passé ?\n",
					:question_jm=>"Est-ce que c'était facile de voter ?",
					:question_jm_yes_answer=>"Facile",
					:question_jm_yes=>"Très bonne nouvelle, cette expérimentation est désormais terminée, merci beaucoup pour votre participation.\nN'hésitez pas à partager cette expérimentation à vos amis pour leur faire découvrir le jugement majoritaire.\nEnfin, pour utiliser le jugement majoritaire dans la vraie vie, sachez que LaPrimaire.org l'utilise dans le cadre des primaires ouvertes qu'ils organisent.",
					:question_jm_no_answer=>"Difficile",
					:question_jm_no=>"Merci pour votre opinion, cette expérimentation est désormais terminée, merci beaucoup pour votre participation !\nN'hésitez pas à partager cette expérimentation à vos amis pour leur faire découvrir le jugement majoritaire.\nEnfin, pour utiliser le jugement majoritaire dans la vraie vie, sachez que LaPrimaire.org l'utilise dans le cadre des primaires ouvertes qu'ils organisent.",
				}
			},
			:fr=>{
				:home=>{
					:try_again_answer=>"Réessayer",
					:vote_paused=>"Désolé les votes sont temporairement suspendus #{Bot.emoticons[:disappointed]} Reessayez dans quelques minutes, merci de votre compréhension !",
					:welcome_answer=>"/start",
					:welcome=><<-END,
Bonjour #{Bot.emoticons[:smile]}
Merci de votre participation à cette expérimentation scientifique.
Sachez que votre vote est anonyme et que vos données personnelles ne sont pas enregistrées.
A tout instant, vous pouvez réinitialiser notre conversation en m'écrivant "/start" (sans les guillemets).
Pour commencer, connaissez-vous le jugement majoritaire ?
END
					:jm_yes_answer=>"Oui je connais",
					:jm_yes=><<-END,
Parfait #{Bot.emoticons[:thumbs_up]}
A présent, passons au vote !
Nous avons créé 2 votes : le 1er avec les 11 candidats officiels et le 2nd avec 4 candidats, vainqueurs ou finalistes des différentes primaires :
END
					:jm_no_answer=>"Non, dites m'en plus",
					:jm_no=><<-END,
Avec plaisir !
Le jugement majoritaire est un système de vote inventé par 2 chercheurs français dans le but de permettre aux électeurs de mieux exprimer leurs opinions.
D'une part les électeurs sont invités à s'exprimer sur *tous* les candidats (au lieu d'en choisir un(e) seul(e)).
D'autre part, le vote se fait en évaluant chaque candidat avec une mention allant de "Très bien" à "A rejeter".
Pour plus d'informations sur le jugement majoritaire, n'hésitez pas à consulter la page https://www.jugementmajoritaire2017.com
END
					:understood_answer=>"Continuer",
					:understood=><<-END,
Ok, passons au vote à présent !
Pour des raisons de confidentialité, le vote ne se fait pas sur Facebook mais sur une page sécurisée.
Vos votes sont anonymes : Ni Facebook, ni nous n'avons la possibilité de connaître votre vote.
Voici le 1er vote concernant les 11 candidat(e)s officiel(le)s à l'élection présidentielle :
END
					:vote_ok_answer=>"Oui",
					:vote_ok=>"Content de voir que tout s'est bien passé !\n",
					:vote_ko_answer=>"Non j'ai eu un souci",
					:vote_ko=>"Désolé que le vote ne se soit pas bien passé, pouvez-vous nous laisser un message sur https://laprimaire.org/contact/ pour nous dire ce qu'il s'est passé ? Cela nous serait très utile !\n",
					:question_jm=><<-END,
Trouvez-vous que la manière dont vous venez de voter (en jugeant chacun des candidats) exprime mieux ou moins bien votre opinion, en comparaison avec le « système officiel » (où vous choisissez un seul candidat) ?
END
					:question_jm_yes_answer=>"Mieux",
					:question_jm_yes=><<-END,
Merci pour votre opinion !
Cette expérimentation est désormais terminée, merci pour votre participation !
A présent n'hésitez pas à partager cette expérimentation à vos proches et amis car nous avons besoin de beaucoup de participants.
Sachez enfin que, si vous voulez utiliser le jugement majoritaire, LaPrimaire.org l'utilise dans le cadre des primaires ouvertes qu'ils organisent.
END
					:question_jm_no_answer=>"Moins bien",
					:question_jm_no=><<-END,
Merci pour votre opinion !
Cette expérimentation est désormais terminée, merci pour votre participation !
Partagez cette expérimentation à vos proches et amis car nous avons besoin de beaucoup de participants.
Sachez enfin que, si vous voulez utiliser le jugement majoritaire, LaPrimaire.org l'utilise dans le cadre des primaires ouvertes qu'ils organisent.
END
				}
			}
		}
		screens={
			:home=>{
				:try_again=>{
					:answer=>"home/try_again_answer",
					:jump_to=>"home/official_candidates",
				},
				:vote_paused=>{
					:kbd=>[{"text"=>"home/try_again"}]
				},
				:welcome=>{
					:callback=>"home/welcome_cb",
					#:jump_to=>"home/share"
					:kbd=>[ {"text"=>"home/jm_no"}, {"text"=>"home/jm_yes"} ]
				},
				:jm_yes=>{
					:answer=>"home/jm_yes_answer",
					:callback=>"home/jm_yes_cb",
					:jump_to=>"home/official_candidates"
				},
				:jm_no=>{
					:answer=>"home/jm_no_answer",
					#:jump_to=>"home/official_candidates"
					:callback=>"home/jm_no_cb",
					:kbd=>[{"text"=>"home/understood"}]
				},
				:understood=>{
					:answer=>"home/understood_answer",
					:jump_to=>"home/official_candidates"
				},
				:official_candidates=>{
					:callback=>"home/official_candidates_cb",
					:attachment=>{
						"type"=>"template",
						"payload"=>{
							"template_type"=>"generic",
							"elements"=>[
								{
									"title"=>"Les 11 candidat(e)s officiels",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/JM2017-foule900.jpg",
									"subtitle"=>"Cliquez sur 'Je vote' pour évaluer pour les 11 candidat(e)s officiels.",
									"default_action"=> {
										"type"=>"web_url",
										"url"=>"https://laprimaire.org/citoyen/vote/facebook_11",
										#"url"=>"http://localhost:9293/citoyen/vote/facebook_11",
										"messenger_extensions"=> true,
										"webview_height_ratio"=> "full",
										#"fallback_url"=>"http://localhost:9293/citoyen/vote/facebook_11"
										"fallback_url"=>"https://laprimaire.org/citoyen/vote/facebook_11"
									},
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"Je vote !",
											"url"=>"https://laprimaire.org/citoyen/vote/facebook_11",
											#"url"=>"http://localhost:9293/citoyen/vote/facebook_11",
											"webview_height_ratio"=>"full",
											"webview_share_button"=>"hide"
										}
									]      
								},
								{
									"title"=>"Les 4 candidat(e)s finalistes des primaires",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/JM2017-foule900.jpg",
									"subtitle"=>"Cliquez sur 'Je vote' pour évaluer pour 4 candidat(e)s finalistes des primaires.",
									"default_action"=> {
										"type"=> "web_url",
										"url"=>"https://laprimaire.org/citoyen/vote/facebook_4",
										#"url"=>"http://localhost:9293/citoyen/vote/facebook_4",
										"messenger_extensions"=> true,
										"webview_height_ratio"=> "full",
										#"fallback_url"=>"http://localhost:9293/citoyen/vote/facebook_4"
										"fallback_url"=>"https://laprimaire.org/citoyen/vote/facebook_4"
									},
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"Je vote !",
											"url"=>"https://laprimaire.org/citoyen/vote/facebook_4",
											#"url"=>"http://localhost:9293/citoyen/vote/facebook_4",
											"webview_height_ratio"=>"full",
											"webview_share_button"=>"hide"
										}
									]      
								}
							]
						}
					}
				},
				:vote_ok=>{
					:answer=>"home/vote_ok_answer",
					:callback=>"home/vote_ok_cb",
					:jump_to=>"home/question_jm"
				},
				:vote_ko=>{
					:answer=>"home/vote_ko_answer",
					:callback=>"home/vote_ko_cb",
					:jump_to=>"home/question_jm"
				},
				:question_jm=>{
					:kbd=>[
						{"text"=>"home/question_jm_yes"},
						{"text"=>"home/question_jm_no"}
					]
				},
				:question_jm_yes=>{
					:answer=>"home/question_jm_yes_answer",
					:callback=>"home/question_jm_yes_cb",
					:jump_to=>"home/share"
				},
				:question_jm_no=>{
					:answer=>"home/question_jm_no_answer",
					:callback=>"home/question_jm_no_cb",
					:jump_to=>"home/share"
				},
				:share=>{
					:attachment=>{
						"type"=>"template",
						"payload"=>{
							"template_type"=>"generic",
							#"image_aspect_ratio"=>"square",
							"elements"=>[
								{
									"title"=>"Découvrez le Jugement Majoritaire",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/share-jm-img-logo1.jpg",
									#"subtitle"=>"Exprimez-vous sur les candidat(s) à la présidentielle grâce au jugement majoritaire.",
									"subtitle"=>"Une expérience scientifique pour faire progresser la science du vote.",
									"default_action"=> {
										"type"=> "web_url",
										"url"=>"https://m.me/JugementMajoritairePresidentielle2017",
										#"url"=>"http://localhost:9293/citoyen/vote/facebook_voting",
									},
									"buttons"=>[
										{
										"type"=> "web_url",
										"title"=> "Participer",
										"url"=>"https://m.me/JugementMajoritairePresidentielle2017",
										},
										{
											"type"=>"element_share"
										}
									]      
								},
								{
									"title"=>"Utilisez le Jugement Majoritaire sur LaPrimaire.org",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/share-legislatives-img2.jpg",
									"subtitle"=>"Choisissez vos candidats pour les législatives.",
									"default_action"=> {
										"type"=> "web_url",
										"url"=>"https://legislatives.laprimaire.org"
									},
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"Participer",
											"url"=>"https://legislatives.laprimaire.org"
										},
										{
											"type"=>"element_share"
										}
									]      
								}
							]
						}
					}
				},
			}
		}
		Bot.updateScreens(screens)
		Bot.updateMessages(messages)
	end

	def home_jm_yes_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		if VOTE_PAUSED then
			screen=self.find_by_name("home/vote_paused",self.get_locale(user))
			return self.get_screen(screen,user,msg)
		end
		@users.update_profile(user.sig,'{"connait_JM":1}');
		return self.get_screen(screen,user,msg)
	end

	def home_jm_no_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		if VOTE_PAUSED then
			screen=self.find_by_name("home/vote_paused",self.get_locale(user))
			return self.get_screen(screen,user,msg)
		end
		@users.update_profile(user.sig,'{"connait_JM":0}');
		return self.get_screen(screen,user,msg)
	end

	def home_question_jm_yes_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"mieux_que_SM":1}');
		return self.get_screen(screen,user,msg)
	end

	def home_question_jm_no_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"mieux_que_SM":0}');
		return self.get_screen(screen,user,msg)
	end

	def home_vote_ok_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"vote_OK":1}');
		return self.get_screen(screen,user,msg)
	end

	def home_vote_ko_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"vote_OK":0}');
		return self.get_screen(screen,user,msg)
	end

	def home_official_candidates_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		if VOTE_PAUSED then
			screen=self.find_by_name("home/vote_paused",self.get_locale(user))
			return self.get_screen(screen,user,msg)
		end
		token_11={
			:iss=> CC_APP_ID_FB,
			:sub=> Digest::SHA256.hexdigest(user.id.to_s+'@facebook.com'),
			:email=> user.id.to_s+'@facebook.com',
			:lastName=> user.last_name,
			:firstName=> user.first_name,
			:authorizedVotes=> [FB_VOTE_ID_11],
			:exp=>(Time.new.getutc+VOTING_TIME_ALLOWED).to_i
		}
		vote_token_11=JWT.encode token_11, CC_SECRET_FB, 'HS256'
		token_4={
			:iss=> CC_APP_ID_FB,
			:sub=> Digest::SHA256.hexdigest(user.id.to_s+'@facebook.com'),
			:email=> user.id.to_s+'@facebook.com',
			:lastName=> user.last_name,
			:firstName=> user.first_name,
			:authorizedVotes=> [FB_VOTE_ID_4],
			:exp=>(Time.new.getutc+VOTING_TIME_ALLOWED).to_i
		}
		vote_token_4=JWT.encode token_4, CC_SECRET_FB, 'HS256'
		vote_url_11=screen[:attachment]["payload"]["elements"][0]["buttons"][0]["url"].split('?')[0]
		vote_url_4=screen[:attachment]["payload"]["elements"][1]["buttons"][0]["url"].split('?')[0]
		patch={
			:attachment=>{
				"payload"=>{
					"elements"=>[
						{
							"buttons"=>[{"url"=>vote_url_11+"?token=#{vote_token_11}"}],
							"default_action"=>{
								"url"=>vote_url_11+"?token=#{vote_token_11}",
								"fallback_url"=>vote_url_11+"?token=#{vote_token_11}"
							}
						},
						{
							"buttons"=>[{"url"=>vote_url_4+"?token=#{vote_token_4}"}],
							"default_action"=>{
								"url"=>vote_url_4+"?token=#{vote_token_4}",
								"fallback_url"=>vote_url_4+"?token=#{vote_token_4}"
							}
						}
					]
				}
			}
		}
		custom_screen=Bot.mergeHash(screen,patch)
		return self.get_screen(custom_screen,user,msg)
	end

	def home_welcome_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		user.set('rates',{})
		return self.get_screen(screen,user,msg)
	end

	def home_rate_candidate_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		user.set('rated_candidate',screen[:id].split('/')[1])
		return self.get_screen(screen,user,msg)
	end

	def home_save_rating_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		candidate=user.get('rated_candidate')
		rates=user.get('rates').nil? ? {} : user.get('rates')
		user.set('rates',rates.merge({candidate=>screen[:id]}))
		user.unset('rated_candidate')
		Bot.log.debug user.get('rates')
		return self.get_screen(screen,user,msg)
	end

	def home_menu(msg,user,screen)
		Bot.log.debug "#{__method__}"
		screen[:kbd_del]=["home/menu"] #comment if you want the home button to be displayed on the home menu
		user.next_answer('answer')
		return self.get_screen(screen,user,msg)
	end
end

include Home
