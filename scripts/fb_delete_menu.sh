curl -X DELETE -H "Content-Type: application/json" -d '{
"setting_type":"call_to_actions",
"thread_state":"existing_thread"
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=$1"
