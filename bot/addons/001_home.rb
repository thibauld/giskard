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
Hi #{Bot.emoticons[:smile]}
Thanks for participating to this experiment.
First off, quick question : Do you know what Majority Judgement is ?
END
					:jm_yes_answer=>"Yes I do",
					:jm_yes=><<-END,
Great ! Let's proceed directly to the vote then.
END
					:jm_no_answer=>"No, tell me more",
					:jm_no=><<-END,
Sure thing !
The majority judgement is a novel and advanced way of casting your vote where you evaluate each one of the candidates by giving them a mention ranging from "Very good" to "To be rejected"
END
					:understood_answer=>"Ok understood",
					:understood=><<-END,
Great #{Bot.emoticons[:thumbs_up]}
Now let's vote !
END
					:official_candidates=><<-END,
Here are the 2 offical candidates of the presidential election run-off :
attachment:
Once you casted your vote, please click on "Continue"
END
					:non_official_candidates=><<-END,
Passons à présent au 2nd vote concernant 4 candidat(e)s finalistes de leur primaire respective mais non-qualifiés :
attachment:
END
					:vote_completed_answer=>"Continue",
					:vote_completed=>"Did the voting procedure go smoothly ?\n",
					:vote_ok_answer=>"Yes",
					:vote_ok=>"Glad to see everything went well !\n",
					:vote_ko_answer=>"No I had an issue",
					:vote_ko=>"Sorry you ran into an issue, can you contact us to let us know what happened ?\n",
					:question_jm=>"Was casting your vote with the Majority Judgement let us express your opinion better or worse than the official system ?",
					:question_jm_yes_answer=>"Better",
					:question_jm_yes=>"Very good news, this experiment is now over, thanks a lot for participating!\n",
					:question_jm_no_answer=>"Worse",
					:question_jm_no=>"Thanks for your opinion!\nThis experiment is now over, thanks for participating!\n",
					:question_share_experiment=><<-END,
Would you agree to help us by sharing this experiment to some of your friends and family ?
END
					:question_share_experiment_no_answer=>"No thanks",
					:question_share_experiment_no=><<-END,
Too bad #{Bot.emoticons['disappointed']}
END
					:question_share_experiment_yes_answer=>"Of course!",
					:question_share_experiment_yes=><<-END,
Thanks a lot! Here is a little message ready to share :
attachment:
Click on "Share" to choose the friends to whom you'd like to share this experiment. Click on "Done" once you're done
END
					:done_button_answer=>"Done",
					:done_button=>"Thank you for your help #{Bot.emoticons['smile']}\n",
					:share_laprimaire=><<-END,
Finally, know that, if you want to use Majority Judgement in real life, LaPrimaire.org uses it to organize their open primaries:
attachment:
END
				}
			},
			:fr=>{
				:home=>{
					:try_again_answer=>"Réessayer",
					:vote_paused=>"Désolé les votes sont temporairement suspendus #{Bot.emoticons[:disappointed]} Reessayez dans quelques minutes, merci de votre compréhension !",
					:welcome_answer=>"/start",
					:welcome=><<-END,
Bonjour #{Bot.emoticons[:smile]}
Merci de votre participation à cette seconde expérimentation scientifique dans le cadre de l'élection présidentielle.
Les résultats de la première expérimentation seront rendus publics juste après l'élection présidentielle.
A tout instant, vous pouvez réinitialiser notre conversation en m'écrivant "/start" (sans les guillemets).
Question préalable avant de passer au vote : connaissez-vous le jugement majoritaire ?
END
					:jm_yes_answer=>"Oui je connais",
					:jm_yes=><<-END,
Top #{Bot.emoticons[:thumbs_up]}
Passons directement au vote alors !
END
					:jm_no_answer=>"Non, dites m'en plus",
					:jm_no=><<-END,
Avec grand plaisir !
Le jugement majoritaire est un système de vote inventé pour permettre aux électeurs de mieux exprimer leurs opinions.
D'une part les électeurs s'expriment sur tous les candidats au lieu d'en choisir un(e) seul(e).
D'autre part, le vote se fait en évaluant chaque candidat avec une mention allant de "Très bien" à "A rejeter".
Pour plus d'infos sur le jugement majoritaire, rendez-vous sur https://www.jugementmajoritaire2017.com
END
					:understood_answer=>"Ok bien compris",
					:understood=><<-END,
Ok, à présent passons au vote !
Pour des raisons de confidentialité, le vote se fait hors de Facebook sur une page sécurisée.
Sachez que votre vote est anonyme et que vos données personnelles ne sont pas enregistrées.
END
					:official_candidates=><<-END,
Voici les 2 candidats officiels au second tour de l'élection présidentielle :
attachment:
Une fois que vous avez voté, cliquez sur le bouton "Continuer"
END
					:vote_completed_answer=>"Continuer",
					:vote_completed=>"Le vote s'est-il correctement déroulé ?",
					:vote_ok_answer=>"Oui aucun souci",
					:vote_ok=>"Top !\n",
					:vote_ko_answer=>"Non malheureusement",
					:vote_ko=>"Toutes nos excuses pour ce souci, si vous pouviez nous laisser un message sur https://laprimaire.org/contact/ pour nous dire ce qu'il s'est passé, cela nous aiderait beaucoup !\n",
					:question_jm=><<-END,
Trouvez-vous que la manière dont vous venez de voter exprime mieux ou moins bien votre opinion, en comparaison avec le « système officiel » ?
END
					:question_jm_yes_answer=>"Mieux",
					:question_jm_yes=><<-END,
Merci pour votre opinion !
Cette expérimentation est désormais terminée, merci pour votre participation !
END
					:question_jm_no_answer=>"Moins bien",
					:question_jm_no=><<-END,
Merci pour votre opinion !
Cette expérimentation est désormais terminée, merci pour votre participation !
END
					:question_share_experiment=><<-END,
Seriez-vous d'accord pour nous aider en partageant cette expérimentation à quelques uns de vos proches et amis de votre choix ? 
END
					:question_share_experiment_no_answer=>"Non merci",
					:question_share_experiment_no=><<-END,
Dommage #{Bot.emoticons['disappointed']}
END
					:question_share_experiment_yes_answer=>"Avec plaisir",
					:question_share_experiment_yes=><<-END,
Merci beaucoup ! Voici un petit texte prêt à partager :
attachment:
Cliquez sur "Partager" pour choisir les amis à qui vous souhaitez la partager. Cliquez sur "C'est fait !" une fois que vous avez terminé.
END
					:done_button_answer=>"C'est fait !",
					:done_button=>"Merci énormément pour votre coup de pouce #{Bot.emoticons['thumbs_up']}\n",
					:share_laprimaire=><<-END,
Si vous voulez utiliser à nouveau le jugement majoritaire, sachez que LaPrimaire.org l'utilise dans le cadre des primaires ouvertes qu'ils organisent.
attachment:
Merci encore et à très vite pour les résultats !
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
					:kbd=>[ {"text"=>"home/jm_no"}, {"text"=>"home/jm_yes"} ]
				},
				:jm_yes=>{
					:answer=>"home/jm_yes_answer",
					:callback=>"home/jm_yes_cb",
					:jump_to=>"home/official_candidates"
				},
				:jm_no=>{
					:answer=>"home/jm_no_answer",
					:callback=>"home/jm_no_cb",
					:kbd=>[{"text"=>"home/understood"}]
				},
				:understood=>{
					:answer=>"home/understood_answer",
					:jump_to=>"home/official_candidates"
				},
				:official_candidates=>{
					:callback=>"home/official_candidates_cb",
					:kbd=>[{"text"=>"home/vote_completed"}],
					:attachment=>{
						"type"=>"template",
						"payload"=>{
							"template_type"=>"generic",
							"elements"=>[
								{
									"title"=>"Les 2 candidats au 2nd tour",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/lepenmacron.jpg",
									"subtitle"=>"Cliquez sur 'Je vote' pour évaluer pour les 2 candidats au Jugement Majoritaire.",
									"default_action"=> {
										"type"=>"web_url",
										#"url"=>"https://laprimaire.org/citoyen/vote/facebook_2",
										#"url"=>"http://localhost:9293/citoyen/vote/facebook_2",
										"url"=>"https://laprimaire.org/citoyen/vote/facebook_11?token=a&test=1",
										"messenger_extensions"=> true,
										"webview_height_ratio"=> "full",
										#"fallback_url"=>"https://laprimaire.org/citoyen/vote/facebook_2"
										#"fallback_url"=>"http://localhost:9293/citoyen/vote/facebook_2"
										"fallback_url"=>"https://laprimaire.org/citoyen/vote/facebook_11?token=a&test=1",
									},
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"Je vote !",
											#"url"=>"https://laprimaire.org/citoyen/vote/facebook_2",
											#"url"=>"http://localhost:9293/citoyen/vote/facebook_2",
											"url"=>"https://laprimaire.org/citoyen/vote/facebook_11?token=a&test=1",
											"webview_height_ratio"=>"full",
											"webview_share_button"=>"hide"
										}
									]      
								}
							]
						}
					}
				},
				:vote_completed=>{
					:answer=>"home/vote_completed_answer",
					:kbd=>[
						{"text"=>"home/vote_ok","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/bien.png"},
						{"text"=>"home/vote_ko","image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/insuffisant.png"}
					]
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
					:jump_to=>"home/question_share_experiment"
				},
				:question_jm_no=>{
					:answer=>"home/question_jm_no_answer",
					:callback=>"home/question_jm_no_cb",
					:jump_to=>"home/question_share_experiment"
				},
				:question_share_experiment=>{
					:kbd=>[
						{"text"=>"home/question_share_experiment_yes"},
						{"text"=>"home/question_share_experiment_no"}
					]
				},
				:question_share_experiment_no=>{
					:answer=>"home/question_share_experiment_no_answer",
					:callback=>"home/share_experiment_no_cb",
					:jump_to=>"home/share_laprimaire"
				},
				:question_share_experiment_yes=>{
					:answer=>"home/question_share_experiment_yes_answer",
					:callback=>"home/share_experiment_yes_cb",
					:kbd=>[{"text"=>"home/done_button"}],
					:attachment=>{
						"type"=>"template",
						"payload"=>{
							"template_type"=>"generic",
							"elements"=>[
								{
									"title"=>"Exprimez-vous avec le Jugement Majoritaire",
									#"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/share-jm-img-logo1.jpg",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/lepenmacron.jpg",
									"subtitle"=>"Une expérience scientifique pour tester un système de vote évolué.",
									"default_action"=> {
										"type"=> "web_url",
										"url"=>"https://m.me/JugementMajoritairePresidentielle2017"
									},
									"buttons"=>[
										{
										"type"=> "web_url",
										"title"=> "Participer",
										"url"=>"https://m.me/JugementMajoritairePresidentielle2017"
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
				:done_button=>{
					:answer=>"home/done_button_answer",
					:callback=>"home/done_button_cb",
					:jump_to=>"home/share_laprimaire"
				},
				:share_laprimaire=>{
					:attachment=>{
						"type"=>"template",
						"payload"=>{
							"template_type"=>"generic",
							"elements"=>[
								{
									"title"=>"Utilisez le Jugement Majoritaire sur LaPrimaire.org",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/share-legislatives-img2.jpg",
									"subtitle"=>"Choisissez vos candidats pour les législatives.",
									"default_action"=> {
										"type"=> "web_url",
										"url"=>"https://laprimaire.org/?utm_source=facebook&utm_medium=bot&utm_campaign=experiment-jm-2017"
									},
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"En savoir plus",
											"url"=>"https://laprimaire.org/?utm_source=facebook&utm_medium=bot&utm_campaign=experiment-jm-2017"
										},
										{
											"type"=>"element_share"
										}
									]      
								}
							]
						}
					}
				}
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
		@users.update_profile(user.sig,'{"connait_JM_2":1}',true);
		return self.get_screen(screen,user,msg)
	end

	def home_jm_no_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		if VOTE_PAUSED then
			screen=self.find_by_name("home/vote_paused",self.get_locale(user))
			return self.get_screen(screen,user,msg)
		end
		@users.update_profile(user.sig,'{"connait_JM_2":0}',true);
		return self.get_screen(screen,user,msg)
	end

	def home_question_jm_yes_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"mieux_que_SM_2":1}');
		return self.get_screen(screen,user,msg)
	end

	def home_question_jm_no_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"mieux_que_SM_2":0}');
		return self.get_screen(screen,user,msg)
	end

	def home_vote_ok_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"vote_OK_2":1}');
		return self.get_screen(screen,user,msg)
	end

	def home_vote_ko_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"vote_OK_2":0}');
		return self.get_screen(screen,user,msg)
	end

	def home_share_experiment_yes_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		patch={
			:attachment=>{
				"payload"=>{
					"elements"=>[
						{
							"buttons"=>[{"url"=>"https://m.me/JugementMajoritairePresidentielle2017?ref=#{user.id}"}],
							"default_action"=>{
								"url"=>"https://m.me/JugementMajoritairePresidentielle2017?ref=#{user.id}"
							}
						}
					]
				}
			}
		}
		custom_screen=Bot.mergeHash(screen,patch)
		@users.update_profile(user.sig,'{"share_experiment_2":1}');
		return self.get_screen(custom_screen,user,msg)
	end

	def home_share_experiment_no_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"share_experiment_2":0}');
		return self.get_screen(screen,user,msg)
	end

	def home_done_button_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		@users.update_profile(user.sig,'{"ad_laprimaire_2":1}');
		return self.get_screen(screen,user,msg)
	end

	def home_official_candidates_cb(msg,user,screen)
		Bot.log.debug "#{__method__}"
		if VOTE_PAUSED then
			screen=self.find_by_name("home/vote_paused",self.get_locale(user))
			return self.get_screen(screen,user,msg)
		end
		token_2={
			:iss=> CC_APP_ID_FB,
			:sub=> Digest::SHA256.hexdigest(user.id.to_s+'@facebook.com'),
			:email=> user.id.to_s+'@facebook.com',
			:lastName=> user.last_name,
			:firstName=> user.first_name,
			:authorizedVotes=> [FB_VOTE_ID_2],
			:exp=>(Time.new.getutc+VOTING_TIME_ALLOWED).to_i
		}
		vote_token_2=JWT.encode token_2, CC_SECRET_FB, 'HS256'
		vote_url_2=screen[:attachment]["payload"]["elements"][0]["buttons"][0]["url"].split('?')[0]
		patch={
			:attachment=>{
				"payload"=>{
					"elements"=>[
						{
							"buttons"=>[{"url"=>vote_url_2+"?token=#{vote_token_2}&test=2"}],
							"default_action"=>{
								"url"=>vote_url_2+"?token=#{vote_token_2}&test=2",
								"fallback_url"=>vote_url_2+"?token=#{vote_token_2}&test=2"
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
		if (!msg.ref.nil?) then
			@users.update_profile(user.sig,'{"referral":"'+msg.ref+'"}');
		end
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
