curl -X POST -H "Content-Type: application/json" -d '{
  "whitelisted_domains":[
      "https://laprimaire.org",
      "https://legislatives.laprimaire.org",
      "https://localhost",
      "https://bot.jugementmajoritaire2017.com"
        ]
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=$1" 
