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
					:vote_completed=><<-END,
Bravo ! Vous avez voté pour tous les candidats. Souhaitez-vous valider votre vote ou bien modifier certains de vos choix ?
END
					:validate_yes_answer=>"Je valide mes choix",
					:validate_yes=><<-END,
Merci beaucoup pour votre participation !
END
					:validate_no_answer=>"Modifier mes choix",
					:validate_no=><<-END,
Pas de souci, on a tout notre temps :)
END
					:official_candidates_to_del=><<-END,
You have %{nb_left} candidates left to judge:
END
					:tres_bien_answer=>"Very good",
					:bien_answer=>"Good",
					:assez_bien_answer=>"Rather good",
					:passable_answer=>"Mediocre",
					:insuffisant_answer=>"Insufficient",
					:a_rejeter_answer=>"Rejected",
					:understood=>"Ok understood\n",
					:francois_fillon_answer=>"F. Fillon",
					:francois_fillon=>"How would you rate François Fillon ?",
					:nicolas_dupont_aignan_answer=>"N. Dupont-Aignan",
					:nicolas_dupont_aignan=>"How would you rate Nicolas Dupont-Aignan ?",
					:nathalie_arthaud_answer=>"N. Arthaud",
					:nathalie_arthaud=><<END,
image:https://s3.eu-central-1.amazonaws.com/laprimaire/candidats/nathalie-arthaud.jpg
Pour présider la France, ayant pris tous les éléments en compte, je juge en conscience que Nathalie Arthaud serait:
END
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
					:jm_yes_answer=>"Oui je connais déjà",
					:jm_yes=><<-END,
Parfait, nous pouvons donc dès à présent procéder au vote !
END
					:jm_no_answer=>"Non, dites m'en plus",
					:jm_no=><<-END,
Avec plaisir !
Le jugement majoritaire c'est [blabla...]
END
					:vote_completed=><<-END,
Bravo ! Vous avez voté pour tous les candidats. Souhaitez-vous valider votre vote ou bien modifier certains de vos choix ?
END
					:validate_yes_answer=>"Je valide",
					:validate_yes=><<-END,
Merci beaucoup pour votre participation !
END
					:validate_no_answer=>"Je modifie",
					:validate_no=><<-END,
Pas de souci, on a tout notre temps :)
END

					:official_candidates_to_del=><<-END,
Il vous reste encore %{nb_left} candidat(e)s à évaluer :
END
					:tres_bien_answer=>"Très bien",
					:bien_answer=>"Bien",
					:assez_bien_answer=>"Assez bien",
					:passable_answer=>"Passable",
					:insuffisant_answer=>"Insuffisant",
					:a_rejeter_answer=>"A rejeter",
					:understood=>"Ok bien noté\n",
					:francois_fillon_answer=>"F. Fillon",
					:francois_fillon=><<END,
image:https://s3.eu-central-1.amazonaws.com/laprimaire/candidats/francois-fillon.jpg
Pour présider la France, ayant pris tous les éléments en compte, je juge en conscience que François Fillon serait:
END
					:nicolas_dupont_aignan_answer=>"N. Dupont-Aignan",
					:nicolas_dupont_aignan=><<END,
image:https://s3.eu-central-1.amazonaws.com/laprimaire/candidats/nicolas-dupont-aignan.jpg
Pour présider la France, ayant pris tous les éléments en compte, je juge en conscience que Nicolas Dupont-Aignan serait:
END
					:nathalie_arthaud_answer=>"N. Arthaud",
					:nathalie_arthaud=><<END,
image:https://s3.eu-central-1.amazonaws.com/laprimaire/candidats/nathalie-arthaud.jpg
Pour présider la France, ayant pris tous les éléments en compte, je juge en conscience que Nathalie Arthaud serait:
END

				}
			}
		}
		screens={
			:home=>{
				:welcome=>{
					:answer=>"home/welcome_answer",
					:callback=>"home/welcome_cb",
					:kbd=>[
						{"text"=>"home/jm_no"},
						{"text"=>"home/jm_yes"}
					]
				},
				:jm_yes=>{
					:answer=>"home/jm_yes_answer",
					:jump_to=>"home/official_candidates"
					#:jump_to=>"home/validate_yes"
				},
				:jm_no=>{
					:answer=>"home/jm_no_answer",
					:jump_to=>"home/official_candidates"
				},
				:vote_completed=>{
					:kbd=>[
						{"text"=>"home/validate_yes"},
						{"text"=>"home/validate_no"}
					]
				},
				:validate_yes=>{
					:answer=>"home/validate_yes_answer",
					:attachment=>{
						"type":"template",
						"payload"=>{
							"template_type"=>"generic",
							"elements"=>[
								{
									"title"=>"Faites voter vos amis",
									"image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/merci.png",
									"subtitle"=>"Merci d'avoir participé ! Partagez à vos amis !",
									"buttons"=>[
										{
											"type"=>"element_share",
											"share_contents"=>{
												"attachment"=>{
													"type"=>"template",
													"payload"=>{
														"template_type"=>"generic",
														"elements" => [
															"title"=>"Votez au Jugement Majoritaire pour la Présidentielle",
															"subtitle"=>"Une expérimentation scientifique menée par le CNRS, Dauphine et Polytechnique",
															"image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/images/merci.png",
															"buttons"=>[
																{
																	"type"=>"web_url",
																	"url"=>"https://m.me/JugementMajoritairePresidentielle2017",
																	"title"=>"Participer"
																}
															]
														]
													}
												}
											}
										}
									]      
								},
								{
									"title"=>"Utilisez le Jugement Majoritaire pour les législatives",
									"image_url"=>"https://s3.eu-central-1.amazonaws.com/laprimaire/logos/logo_laprimaire_200x75.jpg",
									"subtitle"=>"Choisissez vos candidats pour les législatives !",
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"Voter aux législatives",
											"url"=>"https://laprimaire.org"
										}              
									]      
								}
							]
						}
					}
				},
				:validate_no=>{
					:answer=>"home/validate_no_answer",
					:jump_to=>"home/official_candidates"
				},
				:understood=>{
					:jump_to=>"home/official_candidates"
				},
				:official_candidates=>{
					:attachment=>{
						"type":"template",
						"payload"=>{
							"template_type"=>"generic",
							"elements"=>[
								{
									"title"=>"Votez au Jugement Majoritaire",
									"image_url"=>"https://s3.eu-west-2.amazonaws.com/www.jugementmajoritaire2017.com/images/JM2017-foule900.jpg",
									"subtitle"=>"Cliquez sur le bouton 'Je vote' pour évaluer pour les 11 candidat(e)s officiel(le)s",
									"buttons"=>[
										{
											"type"=>"web_url",
											"title"=>"Je vote !",
											"url"=>"https://laprimaire.org/citoyen/vote/facebook_voting",
											"webview_height_ratio"=>"tall",
											"webview_share_button"=>"hide",
											"messenger_extensions"=>true,
											"fallback_url"=>"https://laprimaire.org/citoyen/vote/facebook_voting"
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

	def home_welcome_cb(msg,user,screen)
		Bot.log.info "#{__method__}"
		user.set('rates',{})
		return self.get_screen(screen,user,msg)
	end

	def home_display_candidates_cb(msg,user,screen)
		Bot.log.info "#{__method__}"
		rates=user.get('rates').nil? ? {} : user.get('rates')
		nb_left=3-rates.length
		if (nb_left==0) then
			screen=self.find_by_name("home/vote_completed",self.get_locale(user))
			return self.get_screen(screen,user,msg)
		end
		screen[:text]=screen[:text] % { nb_left: nb_left}
		screen[:kbd].each_with_index do |c,i|
			rates.each do |k,v|
				if (c["payload"].split('/')[1]==k) then
					mention=v.split('/')[1]
					screen[:kbd][i]["image_url"]=IMG_PATH+"#{mention}.png"
				end
			end
		end
		return self.get_screen(screen,user,msg)
	end

	def home_rate_candidate_cb(msg,user,screen)
		Bot.log.info "#{__method__}"
		user.set('rated_candidate',screen[:id].split('/')[1])
		return self.get_screen(screen,user,msg)
	end

	def home_save_rating_cb(msg,user,screen)
		Bot.log.info "#{__method__}"
		candidate=user.get('rated_candidate')
		rates=user.get('rates').nil? ? {} : user.get('rates')
		user.set('rates',rates.merge({candidate=>screen[:id]}))
		user.unset('rated_candidate')
		Bot.log.debug user.get('rates')
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
