curl -X POST -H "Content-Type: application/json" -d '{
"setting_type" : "call_to_actions",
"thread_state" : "existing_thread",
"call_to_actions":[
{
	"type":"postback",
	"title":"Help",
	"payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_HELP"
},
{
	"type":"postback",
	"title":"Start a New Order",
	"payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_START_ORDER"
}
]
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=$1"
