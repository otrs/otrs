# ----------------------------------------------------------
#  driver: mysql
# ----------------------------------------------------------
CREATE INDEX link_relation_list_source ON link_relation (source_object_id, source_key, state_id);
CREATE INDEX link_relation_list_target ON link_relation (target_object_id, target_key, state_id);

# migrate user preferences, see https://github.com/OTRS/otrs/pull/335
UPDATE user_preferences SET preferences_key = 'UserSendFollowUpNotificationOwner' WHERE preferences_key = 'UserSendNewTicketNotification';

INSERT INTO user_preferences (user_id, preferences_key, preferences_value)
   SELECT user_id, 'UserSendFollowUpNotificationUnlocked', preferences_value
   FROM user_preferences WHERE preferences_key = 'UserSendFollowUpNotificationOwner';
