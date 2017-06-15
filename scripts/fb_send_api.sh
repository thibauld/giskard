curl -X POST -H "Content-Type: application/json" -d '{
"object":"api",
"uid":"$1",
"cmd":"api/vote_completed"
}' "https://laprimaire.ngrok.io/monprefix/fbmessenger"
