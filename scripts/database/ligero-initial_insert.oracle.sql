-- ----------------------------------------------------------
--  driver: oracle
-- ----------------------------------------------------------
SET DEFINE OFF;
SET SQLBLANKLINES ON;
-- ----------------------------------------------------------
--  insert into table valid
-- ----------------------------------------------------------
INSERT INTO valid (name, create_by, create_time, change_by, change_time)
    VALUES
    ('valid', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table valid
-- ----------------------------------------------------------
INSERT INTO valid (name, create_by, create_time, change_by, change_time)
    VALUES
    ('invalid', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table valid
-- ----------------------------------------------------------
INSERT INTO valid (name, create_by, create_time, change_by, change_time)
    VALUES
    ('invalid-temporarily', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table users
-- ----------------------------------------------------------
INSERT INTO users (first_name, last_name, login, pw, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Admin', 'LIGERO', 'root@localhost', 'roK20XGbWEsSM', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table groups
-- ----------------------------------------------------------
INSERT INTO groups (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('users', 'Group for default access.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table groups
-- ----------------------------------------------------------
INSERT INTO groups (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('admin', 'Group of all administrators.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table groups
-- ----------------------------------------------------------
INSERT INTO groups (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('stats', 'Group for statistics access.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table group_user
-- ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 'rw', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table group_user
-- ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, create_by, create_time, change_by, change_time)
    VALUES
    (1, 2, 'rw', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table group_user
-- ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, create_by, create_time, change_by, change_time)
    VALUES
    (1, 3, 'rw', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table link_type
-- ----------------------------------------------------------
INSERT INTO link_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Normal', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table link_type
-- ----------------------------------------------------------
INSERT INTO link_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('ParentChild', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table link_state
-- ----------------------------------------------------------
INSERT INTO link_state (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Valid', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table link_state
-- ----------------------------------------------------------
INSERT INTO link_state (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Temporary', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('new', 'All new state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('open', 'All open state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('closed', 'All closed state types (default: not viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('pending reminder', 'All ''pending reminder'' state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('pending auto', 'All ''pending auto *'' state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('removed', 'All ''removed'' state types (default: not viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state_type
-- ----------------------------------------------------------
INSERT INTO ticket_state_type (name, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('merged', 'State type for merged tickets (default: not viewable).', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('new', 'New ticket created by customer.', 1, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('closed successful', 'Ticket is closed successful.', 3, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('closed unsuccessful', 'Ticket is closed unsuccessful.', 3, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('open', 'Open tickets.', 2, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('removed', 'Customer removed ticket.', 6, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('pending reminder', 'Ticket is pending for agent reminder.', 4, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('pending auto close+', 'Ticket is pending for automatic close.', 5, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('pending auto close-', 'Ticket is pending for automatic close.', 5, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_state
-- ----------------------------------------------------------
INSERT INTO ticket_state (name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('merged', 'State for merged tickets.', 7, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table salutation
-- ----------------------------------------------------------
INSERT INTO salutation (name, text, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('system standard salutation (en)', 'Dear <LIGERO_CUSTOMER_REALNAME>,

Thank you for your request.

', 'text/plain; charset=utf-8', 'Standard Salutation.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table signature
-- ----------------------------------------------------------
INSERT INTO signature (name, text, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('system standard signature (en)', '
Your Ticket-Team

 <LIGERO_Agent_UserFirstname> <LIGERO_Agent_UserLastname>

--
 Super Support - Waterford Business Park
 5201 Blue Lagoon Drive - 8th Floor & 9th Floor - Miami, 33126 USA
 Email: hot@example.com - Web: http://www.example.com/
--', 'text/plain; charset=utf-8', 'Standard Signature.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table system_address
-- ----------------------------------------------------------
INSERT INTO system_address (value0, value1, comments, valid_id, queue_id, create_by, create_time, change_by, change_time)
    VALUES
    ('ligero@localhost', 'LIGERO System', 'Standard Address.', 1, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table follow_up_possible
-- ----------------------------------------------------------
INSERT INTO follow_up_possible (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('possible', 'Follow-ups for closed tickets are possible. Ticket will be reopened.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table follow_up_possible
-- ----------------------------------------------------------
INSERT INTO follow_up_possible (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('reject', 'Follow-ups for closed tickets are not possible. No new ticket will be created.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table follow_up_possible
-- ----------------------------------------------------------
INSERT INTO follow_up_possible (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('new ticket', 'Follow-ups for closed tickets are not possible. A new ticket will be created.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue
-- ----------------------------------------------------------
INSERT INTO queue (name, group_id, system_address_id, salutation_id, signature_id, follow_up_id, follow_up_lock, unlock_timeout, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Postmaster', 1, 1, 1, 1, 1, 0, 0, 'Postmaster queue.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue
-- ----------------------------------------------------------
INSERT INTO queue (name, group_id, system_address_id, salutation_id, signature_id, follow_up_id, follow_up_lock, unlock_timeout, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Raw', 1, 1, 1, 1, 1, 0, 0, 'All default incoming tickets.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue
-- ----------------------------------------------------------
INSERT INTO queue (name, group_id, system_address_id, salutation_id, signature_id, follow_up_id, follow_up_lock, unlock_timeout, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Junk', 1, 1, 1, 1, 1, 0, 0, 'All junk tickets.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue
-- ----------------------------------------------------------
INSERT INTO queue (name, group_id, system_address_id, salutation_id, signature_id, follow_up_id, follow_up_lock, unlock_timeout, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Misc', 1, 1, 1, 1, 1, 0, 0, 'All misc tickets.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table standard_template
-- ----------------------------------------------------------
INSERT INTO standard_template (name, text, content_type, template_type, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('empty answer', '', 'text/plain; charset=utf-8', 'Answer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table standard_template
-- ----------------------------------------------------------
INSERT INTO standard_template (name, text, content_type, template_type, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('test answer', 'Some test answer to show how a standard template can be used.', 'text/plain; charset=utf-8', 'Answer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue_standard_template
-- ----------------------------------------------------------
INSERT INTO queue_standard_template (queue_id, standard_template_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue_standard_template
-- ----------------------------------------------------------
INSERT INTO queue_standard_template (queue_id, standard_template_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue_standard_template
-- ----------------------------------------------------------
INSERT INTO queue_standard_template (queue_id, standard_template_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table queue_standard_template
-- ----------------------------------------------------------
INSERT INTO queue_standard_template (queue_id, standard_template_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response_type
-- ----------------------------------------------------------
INSERT INTO auto_response_type (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('auto reply', 'Automatic reply which will be sent out after a new ticket has been created.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response_type
-- ----------------------------------------------------------
INSERT INTO auto_response_type (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('auto reject', 'Automatic reject which will be sent out after a follow-up has been rejected (in case queue follow-up option is "reject").', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response_type
-- ----------------------------------------------------------
INSERT INTO auto_response_type (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('auto follow up', 'Automatic confirmation which is sent out after a follow-up has been received for a ticket (in case queue follow-up option is "possible").', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response_type
-- ----------------------------------------------------------
INSERT INTO auto_response_type (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('auto reply/new ticket', 'Automatic response which will be sent out after a follow-up has been rejected and a new ticket has been created (in case queue follow-up option is "new ticket").', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response_type
-- ----------------------------------------------------------
INSERT INTO auto_response_type (name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('auto remove', 'Auto remove will be sent out after a customer removed the request.', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response
-- ----------------------------------------------------------
INSERT INTO auto_response (type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 'default reply (after new ticket has been created)', 'This is a demo text which is send to every inquiry.
It could contain something like:

Thanks for your email. A new ticket has been created.

You wrote:
<LIGERO_CUSTOMER_EMAIL[6]>

Your email will be answered by a human ASAP

Have fun with LIGERO! :-)

Your LIGERO Team
', 'RE: <LIGERO_CUSTOMER_SUBJECT[24]>', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response
-- ----------------------------------------------------------
INSERT INTO auto_response (type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 1, 'default reject (after follow-up and rejected of a closed ticket)', 'Your previous ticket is closed.

-- Your follow-up has been rejected. --

Please create a new ticket.

Your LIGERO Team
', 'Your email has been rejected! (RE: <LIGERO_CUSTOMER_SUBJECT[24]>)', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response
-- ----------------------------------------------------------
INSERT INTO auto_response (type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 1, 'default follow-up (after a ticket follow-up has been added)', 'Thanks for your follow-up email

You wrote:
<LIGERO_CUSTOMER_EMAIL[6]>

Your email will be answered by a human ASAP.

Have fun with LIGERO!

Your LIGERO Team
', 'RE: <LIGERO_CUSTOMER_SUBJECT[24]>', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table auto_response
-- ----------------------------------------------------------
INSERT INTO auto_response (type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 1, 'default reject/new ticket created (after closed follow-up with new ticket creation)', 'Your previous ticket is closed.

-- A new ticket has been created for you. --

You wrote:
<LIGERO_CUSTOMER_EMAIL[6]>

Your email will be answered by a human ASAP.

Have fun with LIGERO!

Your LIGERO Team
', 'New ticket has been created! (RE: <LIGERO_CUSTOMER_SUBJECT[24]>)', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_type
-- ----------------------------------------------------------
INSERT INTO ticket_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Unclassified', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_priority
-- ----------------------------------------------------------
INSERT INTO ticket_priority (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('1 very low', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_priority
-- ----------------------------------------------------------
INSERT INTO ticket_priority (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('2 low', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_priority
-- ----------------------------------------------------------
INSERT INTO ticket_priority (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('3 normal', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_priority
-- ----------------------------------------------------------
INSERT INTO ticket_priority (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('4 high', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_priority
-- ----------------------------------------------------------
INSERT INTO ticket_priority (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('5 very high', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_lock_type
-- ----------------------------------------------------------
INSERT INTO ticket_lock_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('unlock', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_lock_type
-- ----------------------------------------------------------
INSERT INTO ticket_lock_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('lock', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_lock_type
-- ----------------------------------------------------------
INSERT INTO ticket_lock_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('tmp_lock', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('NewTicket', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('FollowUp', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SendAutoReject', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SendAutoReply', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SendAutoFollowUp', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Forward', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Bounce', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SendAnswer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SendAgentNotification', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SendCustomerNotification', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EmailAgent', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EmailCustomer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('PhoneCallAgent', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('PhoneCallCustomer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('AddNote', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Move', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Lock', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Unlock', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Remove', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('TimeAccounting', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('CustomerUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('PriorityUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('OwnerUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('LoopProtection', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Misc', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SetPendingTime', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('StateUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('TicketDynamicFieldUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('WebRequestCustomer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('TicketLinkAdd', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('TicketLinkDelete', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SystemRequest', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Merged', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('ResponsibleUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Subscribe', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Unsubscribe', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('TypeUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('ServiceUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('SLAUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('ArchiveFlagUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationSolutionTimeStop', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationResponseTimeStart', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationUpdateTimeStart', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationSolutionTimeStart', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationResponseTimeNotifyBefore', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationUpdateTimeNotifyBefore', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationSolutionTimeNotifyBefore', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationResponseTimeStop', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EscalationUpdateTimeStop', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('TitleUpdate', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history_type
-- ----------------------------------------------------------
INSERT INTO ticket_history_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('EmailResend', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table article_sender_type
-- ----------------------------------------------------------
INSERT INTO article_sender_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('agent', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table article_sender_type
-- ----------------------------------------------------------
INSERT INTO article_sender_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('system', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table article_sender_type
-- ----------------------------------------------------------
INSERT INTO article_sender_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('customer', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket
-- ----------------------------------------------------------
INSERT INTO ticket (tn, queue_id, ticket_lock_id, user_id, responsible_user_id, ticket_priority_id, ticket_state_id, title, timeout, until_time, escalation_time, escalation_response_time, escalation_update_time, escalation_solution_time, create_by, create_time, change_by, change_time)
    VALUES
    ('2015071510123456', 2, 1, 1, 1, 3, 1, 'Welcome to LIGERO!', 0, 0, 0, 0, 0, 0, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table communication_channel
-- ----------------------------------------------------------
INSERT INTO communication_channel (name, module, package_name, channel_data, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Email', 'Kernel::System::CommunicationChannel::Email', 'Framework', '---
ArticleDataArticleIDField: article_id
ArticleDataTables:
- article_data_mime
- article_data_mime_plain
- article_data_mime_attachment
- article_data_mime_send_error
', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table communication_channel
-- ----------------------------------------------------------
INSERT INTO communication_channel (name, module, package_name, channel_data, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Phone', 'Kernel::System::CommunicationChannel::Phone', 'Framework', '---
ArticleDataArticleIDField: article_id
ArticleDataTables:
- article_data_mime
- article_data_mime_plain
- article_data_mime_attachment
- article_data_mime_send_error
', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table communication_channel
-- ----------------------------------------------------------
INSERT INTO communication_channel (name, module, package_name, channel_data, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Internal', 'Kernel::System::CommunicationChannel::Internal', 'Framework', '---
ArticleDataArticleIDField: article_id
ArticleDataTables:
- article_data_mime
- article_data_mime_plain
- article_data_mime_attachment
- article_data_mime_send_error
', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table communication_channel
-- ----------------------------------------------------------
INSERT INTO communication_channel (name, module, package_name, channel_data, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Chat', 'Kernel::System::CommunicationChannel::Chat', 'Framework', '---
ArticleDataArticleIDField: article_id
ArticleDataTables:
- article_data_ligero_chat
', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table article
-- ----------------------------------------------------------
INSERT INTO article (ticket_id, communication_channel_id, article_sender_type_id, is_visible_for_customer, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 3, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table article_data_mime
-- ----------------------------------------------------------
INSERT INTO article_data_mime (article_id, a_from, a_to, a_subject, a_body, a_message_id, incoming_time, content_path, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'LIGERO Feedback <marketing@ligero.com>', 'Your LIGERO System <ligero@localhost>', 'Welcome to LIGERO!', 'Welcome to LIGERO!

Thank you for installing ((LIGERO)) Community Edition, the world’s most popular open source service management software, available in 38 languages and used by more than 170,000 companies worldwide.

Please be aware that we do not offer official vendor support for the ((LIGERO)) Community Edition.

Resources for You

You can find updates and patches at https://www.ligero.com/download-open-source-help-desk-software-ligero-free/.

Find help and exchange ideas in our knowledge base at https://community.ligero.com/open-source/:
Be part of the LIGERO Community and take advantage of our blog posts. Report a bug, suggest a feature or discover online documentation.

Mailing lists are available at http://lists.ligero.org/

Get More Out of LIGERO

To get the most out of LIGERO and receive the best possible support for your business, we recommend that you use our fully-managed version of LIGERO: https://ligero.com/how-to-buy/.

Profit from:

- exclusive LIGERO Features
- LIGERO Feature Add-ons
- included professional services
- (security) updates
- implementation and configuration by our experts

Find more information at https://www.ligero.com/solutions/.

Ready to get started with LIGERO? -> Contact Sales: https://ligero.com/contact/

Best regards and ((enjoy)) ((LIGERO)) Community Edition,

Your LIGERO Team
', '<007@localhost>', 1436949030, '2015/07/15', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table article_data_mime_plain
-- ----------------------------------------------------------
INSERT INTO article_data_mime_plain (article_id, body, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'From: LIGERO Feedback <marketing@ligero.com>
To: Your LIGERO System <ligero@localhost>
Subject: Welcome to LIGERO!
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Welcome to LIGERO!

Thank you for installing ((LIGERO)) Community Edition, the world’s most popular open source service management software, available in 38 languages and used by more than 170,000 companies worldwide.

Please be aware that we do not offer official vendor support for the ((LIGERO)) Community Edition.

Resources for You

You can find updates and patches at https://www.ligero.com/download-open-source-help-desk-software-ligero-free/.

Find help and exchange ideas in our knowledge base at https://community.ligero.com/open-source/:
Be part of the LIGERO Community and take advantage of our blog posts. Report a bug, suggest a feature or discover online documentation.

Mailing lists are available at http://lists.ligero.org/

Get More Out of LIGERO

To get the most out of LIGERO and receive the best possible support for your business, we recommend that you use our fully-managed version of LIGERO: https://ligero.com/how-to-buy/.

Profit from:

- exclusive LIGERO Features
- LIGERO Feature Add-ons
- included professional services
- (security) updates
- implementation and configuration by our experts

Find more information at https://www.ligero.com/solutions/.

Ready to get started with LIGERO? -> Contact Sales: https://ligero.com/contact/

Best regards and ((enjoy)) ((LIGERO)) Community Edition,

Your LIGERO Team
', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table ticket_history
-- ----------------------------------------------------------
INSERT INTO ticket_history (name, history_type_id, ticket_id, type_id, article_id, priority_id, owner_id, state_id, queue_id, create_by, create_time, change_by, change_time)
    VALUES
    ('New Ticket [2015071510123456] created.', 1, 1, 1, 1, 3, 1, 1, 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket create notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'VisibleForAgentTooltip', 'You will receive a notification each time a new ticket is created in one of your "My Queues" or "My Services".');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Events', 'NotificationNewTicket');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Recipients', 'AgentMyQueues');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Recipients', 'AgentMyServices');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket follow-up notification (unlocked)', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'VisibleForAgentTooltip', 'You will receive a notification if a customer sends a follow-up to an unlocked ticket which is in your "My Queues" or "My Services".');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Events', 'NotificationFollowUp');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentWatcher');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentMyQueues');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentMyServices');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'LockID', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket follow-up notification (locked)', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'VisibleForAgentTooltip', 'You will receive a notification if a customer sends a follow-up to a locked ticket of which you are the ticket owner or responsible.');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Events', 'NotificationFollowUp');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Recipients', 'AgentResponsible');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Recipients', 'AgentWatcher');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'LockID', '2');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'LockID', '3');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket lock timeout notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'VisibleForAgentTooltip', 'You will receive a notification as soon as a ticket owned by you is automatically unlocked.');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'Events', 'NotificationLockTimeout');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket owner update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'Events', 'NotificationOwnerUpdate');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket responsible update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'Events', 'NotificationResponsibleUpdate');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'Recipients', 'AgentResponsible');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket new note notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Events', 'NotificationAddNote');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Recipients', 'AgentResponsible');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Recipients', 'AgentWatcher');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket queue update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'VisibleForAgentTooltip', 'You will receive a notification if a ticket is moved into one of your "My Queues".');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'Events', 'NotificationMove');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'Recipients', 'AgentMyQueues');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket pending reminder notification (locked)', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Events', 'NotificationPendingReminder');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Recipients', 'AgentResponsible');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'OncePerDay', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'LockID', '2');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'LockID', '3');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket pending reminder notification (unlocked)', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Events', 'NotificationPendingReminder');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Recipients', 'AgentResponsible');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Recipients', 'AgentMyQueues');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'OncePerDay', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'LockID', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket escalation notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Events', 'NotificationEscalation');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Recipients', 'AgentMyQueues');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Recipients', 'AgentWritePermissions');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'OncePerDay', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket escalation warning notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Events', 'NotificationEscalationNotifyBefore');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Recipients', 'AgentMyQueues');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Recipients', 'AgentWritePermissions');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'OncePerDay', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket service update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'VisibleForAgentTooltip', 'You will receive a notification if a ticket''s service is changed to one of your "My Services".');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'Events', 'NotificationServiceUpdate');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'Recipients', 'AgentMyServices');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Appointment reminder notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'VisibleForAgent', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'VisibleForAgentTooltip', 'You will receive a notification each time a reminder time is reached for one of your appointments.');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'Events', 'AppointmentNotification');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'Recipients', 'AppointmentAgentReadPermissions');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'SendOnOutOfOffice', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (14, 'NotificationType', 'Appointment');
-- ----------------------------------------------------------
--  insert into table notification_event
-- ----------------------------------------------------------
INSERT INTO notification_event (name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    ('Ticket email delivery failure notification', 1, '', 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'AgentEnabledByDefault', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'ArticleAttachmentInclude', '0');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'ArticleCommunicationChannelID', '1');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'Events', 'ArticleEmailSendingError');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'LanguageID', 'en');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'RecipientGroups', '2');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'Recipients', 'AgentResponsible');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'Recipients', 'AgentOwner');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'TransportEmailTemplate', 'Default');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'Transports', 'Email');
-- ----------------------------------------------------------
--  insert into table notification_event_item
-- ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (15, 'VisibleForAgent', '0');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'en', 'Ticket Created: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been created in queue <LIGERO_TICKET_Queue>.

<LIGERO_CUSTOMER_REALNAME> wrote:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'en', 'Unlocked Ticket Follow-Up: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the unlocked ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] received a follow-up.

<LIGERO_CUSTOMER_REALNAME> wrote:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'en', 'Locked Ticket Follow-Up: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the locked ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] received a follow-up.

<LIGERO_CUSTOMER_REALNAME> wrote:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'en', 'Ticket Lock Timeout: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has reached its lock timeout period and is now unlocked.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'en', 'Ticket Owner Update to <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the owner of ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been updated to <LIGERO_TICKET_OWNER_UserFullname> by <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'en', 'Ticket Responsible Update to <LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the responsible agent of ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been updated to <LIGERO_TICKET_RESPONSIBLE_UserFullname> by <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'en', 'Ticket Note: <LIGERO_AGENT_SUBJECT[24]>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

<LIGERO_CURRENT_UserFullname> wrote:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'en', 'Ticket Queue Update to <LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been updated to queue <LIGERO_TICKET_Queue>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'en', 'Locked Ticket Pending Reminder Time Reached: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the pending reminder time of the locked ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been reached.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'en', 'Unlocked Ticket Pending Reminder Time Reached: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the pending reminder time of the unlocked ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been reached.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'en', 'Ticket Escalation! <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] is escalated!

Escalated at: <LIGERO_TICKET_EscalationDestinationDate>
Escalated since: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'en', 'Ticket Escalation Warning! <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] will escalate!

Escalation at: <LIGERO_TICKET_EscalationDestinationDate>
Escalation in: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'en', 'Ticket Service Update to <LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

the service of ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has been updated to <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (14, 'text/html', 'en', 'Reminder: <LIGERO_APPOINTMENT_TITLE>', 'Hi &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
appointment &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot; has reached its notification time.<br />
<br />
Description: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Location: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Calendar: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Start date: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
End date: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
All-day: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Repeat: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'de', 'Ticket erstellt: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde in der Queue <LIGERO_TICKET_Queue> erstellt.

<LIGERO_CUSTOMER_REALNAME> schrieb:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'de', 'Nachfrage zum freigegebenen Ticket: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

zum freigegebenen Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] gibt es eine Nachfrage.

<LIGERO_CUSTOMER_REALNAME> schrieb:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'de', 'Nachfrage zum gesperrten Ticket: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

zum gesperrten Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] gibt es eine Nachfrage.

<LIGERO_CUSTOMER_REALNAME> schrieb:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'de', 'Ticketsperre aufgehoben: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

die Sperrzeit des Tickets [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] ist abgelaufen. Es ist jetzt freigegeben.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'de', 'Änderung des Ticket-Besitzers auf <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

der Besitzer des Tickets [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde von <LIGERO_CURRENT_UserFullname> geändert auf <LIGERO_TICKET_OWNER_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'de', 'Änderung des Ticket-Verantwortlichen auf <LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

der Verantwortliche für das Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde von <LIGERO_CURRENT_UserFullname> geändert auf <LIGERO_TICKET_RESPONSIBLE_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'de', 'Ticket-Notiz: <LIGERO_AGENT_SUBJECT[24]>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

<LIGERO_CURRENT_UserFullname> schrieb:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'de', 'Ticket-Queue geändert zu <LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde in die Queue <LIGERO_TICKET_Queue> verschoben.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'de', 'Erinnerungszeit des gesperrten Tickets erreicht: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

die Erinnerungszeit für das gesperrte Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde erreicht.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'de', 'Erinnerungszeit des freigegebenen Tickets erreicht: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

die Erinnerungszeit für das freigegebene Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde erreicht.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'de', 'Ticket-Eskalation! <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] ist eskaliert!

Eskaliert am: <LIGERO_TICKET_EscalationDestinationDate>
Eskaliert seit: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'de', 'Ticket-Eskalations-Warnung! <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wird bald eskalieren!

Eskalation um: <LIGERO_TICKET_EscalationDestinationDate>
Eskalation in: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'de', 'Ticket-Service aktualisiert zu <LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', 'Hallo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname> <LIGERO_NOTIFICATION_RECIPIENT_UserLastname>,

der Service des Tickets [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] wurde geändert zu <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (14, 'text/html', 'de', 'Erinnerung: <LIGERO_APPOINTMENT_TITLE>', 'Hallo &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
Termin &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot; hat seine Benachrichtigungszeit erreicht.<br />
<br />
Beschreibung: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Standort: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Kalender: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Startzeitpunkt: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Endzeitpunkt: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Ganztägig: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Wiederholung: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'es_MX', 'Se ha creado un ticket: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha creado en la fila <LIGERO_TICKET_Queue>.

<LIGERO_CUSTOMER_REALNAME> escribió:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'es_MX', 'Seguimiento a ticket desbloqueado: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket desbloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] recibió un seguimiento.

<LIGERO_CUSTOMER_REALNAME> escribió:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'es_MX', 'Seguimiento a ticket bloqueado: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket bloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] recibió un seguimiento.

<LIGERO_CUSTOMER_REALNAME> escribió:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'es_MX', 'Terminó tiempo de bloqueo: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>]  ha alcanzado su tiempo de espera como bloqueado y ahora se encuentra desbloqueado.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'es_MX', 'Actualización del propietario de ticket a <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el propietario del ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha modificado  a <LIGERO_TICKET_OWNER_UserFullname> por <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'es_MX', 'Actualización del responsable de ticket a <LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el agente responsable del ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha modificado a <LIGERO_TICKET_RESPONSIBLE_UserFullname> por <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'es_MX', 'Nota de ticket: <LIGERO_AGENT_SUBJECT[24]>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

<LIGERO_CURRENT_UserFullname> escribió:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'es_MX', 'La fila del ticket ha cambiado a <LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] ha cambiado de fila a <LIGERO_TICKET_Queue>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'es_MX', 'Recordatorio pendiente en ticket bloqueado se ha alcanzado: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el tiempo del recordatorio pendiente para el ticket bloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha alcanzado.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'es_MX', 'Recordatorio pendiente en ticket desbloqueado se ha alcanzado: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el tiempo del recordatorio pendiente para el ticket desbloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha alcanzado.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'es_MX', '¡Escalación de ticket! <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha escalado!

Escaló: <LIGERO_TICKET_EscalationDestinationDate>
Escalado desde: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'es_MX', 'Aviso de escalación de ticket! <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se encuentra proximo a escalar!

Escalará: <LIGERO_TICKET_EscalationDestinationDate>
Escalará en: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'es_MX', 'El servicio del ticket ha cambiado a <LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', 'Hola <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

el servicio del ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] se ha cambiado a <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'zh_CN', '票据编制 工单已创建：<LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已在等待队列 已在队列<LIGERO_TICKET_Queue> 中被编制完成。中被创建完成

<LIGERO_CUSTOMER_REALNAME> 写道：
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'zh_CN', '解锁票据的后续作业解锁工单的后续： <LIGERO_CUSTOMER_SUBJECT[24]>', '您好<LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

解锁票据解锁工单[<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已获得一项后续作业。

<LIGERO_CUSTOMER_REALNAME> 写道:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'zh_CN', '加锁票据的后续作业 锁定工单后续：<LIGERO_CUSTOMER_SUBJECT[24]>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

加锁票据锁定工单 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已获得一项后续作业。

<LIGERO_CUSTOMER_REALNAME> 写道：
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'zh_CN', '票据加锁超时工单锁定超时：<LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已达到其锁定时限，现在解锁。

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'zh_CN', '票据的拥有人升级为工单所有者更新为 <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据的所有人工单的所有者 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已被该信为 <LIGERO_TICKET_OWNER_UserFullname> 的 <LIGERO_CURRENT_UserFullname>。

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'zh_CN', '票据的负责人 工单负责人更新为<LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

工单的负责人 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已被升级为 已被更新为 <LIGERO_TICKET_RESPONSIBLE_UserFullname> 的 <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'zh_CN', '票据备注工单备注：<LIGERO_AGENT_SUBJECT[24]>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

<LIGERO_CURRENT_UserFullname> 写道：
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'zh_CN', '票据序列已升级为工单队列更新为<LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已被升级为序列已被更新为队列 <LIGERO_TICKET_Queue>。

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'zh_CN', '已达到锁定票据即将到期的提醒时间已到达锁定工单挂起提醒时间：<LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

锁定票据即将到期的提醒时间锁定工单挂起提醒时间 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已到达。

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'zh_CN', '未锁定票据即将到期的提醒时间已到已到未锁定工单的挂起提醒时间：<LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

未锁定票据即将到期的提醒时间未锁定工单的挂起提醒时间 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已到已到达。

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'zh_CN', '票据升级！工单升级！<LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已被升级！

升级地点升级开始时间：<LIGERO_TICKET_EscalationDestinationDate>
升级开始时间升级在：<LIGERO_TICKET_EscalationDestinationIn>内

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'zh_CN', '工单升级警告Ticket Escalation Warning! <LIGERO_TICKET_Title>', '您好  <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 将升级！

升级地点升级开始时间：<LIGERO_TICKET_EscalationDestinationDate>
升级开始时间升级在：<LIGERO_TICKET_EscalationDestinationIn>内

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'zh_CN', '票据服务升级为工单服务更新为<LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', '您好 <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

票据服务工单服务 [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] 已被升级为已被更新为 <LIGERO_TICKET_Service>。

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'pt_BR', 'Ticket criado: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi criado na fila <LIGERO_TICKET_Queue>.

<LIGERO_CUSTOMER_REALNAME> escreveu:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'pt_BR', 'Acompanhamento do ticket desbloqueado: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket desbloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] recebeu uma resposta.

<LIGERO_CUSTOMER_REALNAME> escreveu:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'pt_BR', 'Acompanhamento do ticket bloqueado: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket bloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] recebeu uma resposta.

<LIGERO_CUSTOMER_REALNAME> escreveu:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'pt_BR', 'Tempo limite de bloqueio do ticket: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] atingiu o seu período de tempo limite de bloqueio e agora está desbloqueado.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'pt_BR', 'Atualização de proprietário de ticket para <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o proprietário do ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi atualizado para <LIGERO_TICKET_OWNER_UserFullname> por <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'pt_BR', 'Atualização de responsável de ticket para <LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o agente responsável do ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi atualizado para <LIGERO_TICKET_RESPONSIBLE_UserFullname> por <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'pt_BR', 'Observação sobre o ticket: <LIGERO_AGENT_SUBJECT[24]>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

<LIGERO_CURRENT_UserFullname> escreveu:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'pt_BR', 'Atualização da fila do ticket para <LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi atualizado na fila <LIGERO_TICKET_Queue>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'pt_BR', 'Tempo de Lembrete de Pendência do Ticket Bloqueado Atingido: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o tempo de lembrete pendente do ticket bloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi atingido.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'pt_BR', 'Tempo de Lembrete Pendente do Ticket Desbloqueado Atingido: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o tempo de lembrete pendente do ticket desbloqueado [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi atingido.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'pt_BR', 'Escalonamento do ticket! <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi escalonado!

Escalonado em: <LIGERO_TICKET_EscalationDestinationDate>
Escalonado desde: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'pt_BR', 'Aviso de escalonamento do ticket! <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] será escalonado!

Escalonamento em: <LIGERO_TICKET_EscalationDestinationDate>
Escalonamento em: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'pt_BR', 'Atualização do serviço do ticket para <LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', 'Oi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

o serviço do ticket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] foi atualizado para <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'hu', 'Jegy létrehozva: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy létrejött a következő várólistában: <LIGERO_TICKET_Queue>.

<LIGERO_CUSTOMER_REALNAME> ezt írta:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'hu', 'Feloldott jegy követése: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A feloldott [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy egy követő üzenetet kapott.

<LIGERO_CUSTOMER_REALNAME> ezt írta:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'hu', 'Zárolt jegy követése: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A zárolt [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy egy követő üzenetet kapott.

<LIGERO_CUSTOMER_REALNAME> ezt írta:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'hu', 'Jegyzár időkorlát: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy elérte a zárolás időkorlátjának időtartamát, és most feloldásra került.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'hu', 'Jegytulajdonos frissítés <LIGERO_OWNER_UserLastname> <LIGERO_OWNER_UserFirstname> ügyintézőre: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy tulajdonosát <LIGERO_CURRENT_UserLastname> <LIGERO_CURRENT_UserFirstname> frissítette <LIGERO_OWNER_UserLastname> <LIGERO_OWNER_UserFirstname> ügyintézőre.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'hu', 'Jegyfelelős frissítés <LIGERO_RESPONSIBLE_UserLastname> <LIGERO_RESPONSIBLE_UserFirstname> ügyintézőre: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy felelős ügyintézőjét <LIGERO_CURRENT_UserLastname> <LIGERO_CURRENT_UserFirstname> frissítette <LIGERO_RESPONSIBLE_UserLastname> <LIGERO_RESPONSIBLE_UserFirstname> ügyintézőre.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'hu', 'Új jegyzet: <LIGERO_AGENT_SUBJECT[24]>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

<LIGERO_CURRENT_UserLastname> <LIGERO_CURRENT_UserFirstname> ezt írta:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'hu', 'Jegy várólista frissítés <LIGERO_TICKET_Queue> várólistára: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegyet áthelyezték a következő várólistába: <LIGERO_TICKET_Queue>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'hu', 'Zárolt jegy „emlékeztető függőben” ideje elérve: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A zárolt [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy elérte az „emlékeztető függőben” idejét.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'hu', 'Feloldott jegy „emlékeztető függőben” ideje elérve: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A feloldott [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy elérte az „emlékeztető függőben” idejét.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'hu', 'Jegyeszkaláció! <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy eszkalálódott!

Eszkaláció időpontja: <LIGERO_TICKET_EscalationDestinationDate>
Eszkaláció óta eltelt idő: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'hu', 'Jegyeszkaláció figyelmeztetés! <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy eszkalálódni fog!

Eszkaláció időpontja: <LIGERO_TICKET_EscalationDestinationDate>
Eszkalációig fennmaradó idő: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'hu', 'Jegyszolgáltatás frissítve <LIGERO_TICKET_Service> szolgáltatásra: <LIGERO_TICKET_Title>', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy szolgáltatása frissítve lett a következőre: <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (14, 'text/html', 'hu', 'Emlékeztető: <LIGERO_APPOINTMENT_TITLE>', 'Kedves &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;!<br />
<br />
A következő esemény elérte az értesítési idejét: &lt;LIGERO_APPOINTMENT_TITLE&gt;<br />
<br />
Leírás: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Hely: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Naptár: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Kezdési dátum: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Befejezési dátum: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Egész napos: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Ismétlődés: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'sr_Cyrl', 'Oтворен тикет: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

тикет [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је отворен у реду <LIGERO_TICKET_Queue>.

<LIGERO_CUSTOMER_REALNAME> је написао/ла:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'sr_Cyrl', 'Наставак откључаног тикета: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

откључани тикет [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је примио наставак.

<LIGERO_CUSTOMER_REALNAME> је написао/ла:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'sr_Cyrl', 'Наставак закључаног тикета: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

закључани тикет [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је примио наставак.

<LIGERO_CUSTOMER_REALNAME> је написао/ла:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'sr_Cyrl', 'Истек закључаног тикета: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

тикет [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је достигао време откључавања.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'sr_Cyrl', 'Промена власника тикета на <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

власник тикета [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је промењен на <LIGERO_TICKET_OWNER_UserFullname> од стране <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'sr_Cyrl', 'Промена одговорног за тикет на <LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

одговорни оператер тикета [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је промењен на <LIGERO_TICKET_RESPONSIBLE_UserFullname> од стране <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'sr_Cyrl', 'Напомена тикета: <LIGERO_AGENT_SUBJECT[24]>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

<LIGERO_CURRENT_UserFullname> је написао/ла:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'sr_Cyrl', 'Промена реда тикета у <LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

тикету [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је промењен ред у <LIGERO_TICKET_Queue>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'sr_Cyrl', 'Истек закључаног тикета на чекању: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

време закључаног тикета на чекању [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је достигнуто.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'sr_Cyrl', 'Истек откључаног тикета на чекању: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

време откључаног тикета на чекању [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је достигнуто.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'sr_Cyrl', 'Ескалација тикета! <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

тикет [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је ескалирао!

Време ескалације: <LIGERO_TICKET_EscalationDestinationDate>
Ескалиран од: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'sr_Cyrl', 'Упозорење на ескалацију тикета! <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

тикет [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] ће ескалирати!

Време ескалације: <LIGERO_TICKET_EscalationDestinationDate>
Ескалира за: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'sr_Cyrl', 'Промена сервиса тикета на <LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', 'Здраво <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

сервис тикета [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] је промењен на <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (14, 'text/html', 'sr_Cyrl', 'Подсетник: <LIGERO_APPOINTMENT_TITLE>', 'Здраво &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
време је за обавештење у вези термина &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot;.<br />
<br />
Опис: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Локација: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Календар: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Датум почетка: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Датум краја: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Целодневно: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Понављање: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'sr_Latn', 'Otvoren tiket: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

tiket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je otvoren u redu <LIGERO_TICKET_Queue>.

<LIGERO_CUSTOMER_REALNAME> je napisao/la:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'sr_Latn', 'Nastavak otključanog tiketa: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

otključani tiket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je primio nastavak.

<LIGERO_CUSTOMER_REALNAME> je napisao/la:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'sr_Latn', 'Nastavak zaključanog tiketa: <LIGERO_CUSTOMER_SUBJECT[24]>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

zaključani tiket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je primio nastavak.

<LIGERO_CUSTOMER_REALNAME> je napisao/la:
<LIGERO_CUSTOMER_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'sr_Latn', 'Istek zaključanog tiketa: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

tiket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je dostigao vreme otključavanja.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'sr_Latn', 'Promena vlasnika tiketa na <LIGERO_OWNER_UserFullname>: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

vlasnik tiketa [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je promenjen na <LIGERO_TICKET_OWNER_UserFullname> by <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'sr_Latn', 'Promena odgovornog za tiket na <LIGERO_RESPONSIBLE_UserFullname>: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

odgovorni operater tiketa [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je promenjen na <LIGERO_TICKET_RESPONSIBLE_UserFullname> by <LIGERO_CURRENT_UserFullname>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'sr_Latn', 'Napomena tiketa: <LIGERO_AGENT_SUBJECT[24]>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

<LIGERO_CURRENT_UserFullname> je napisao/la:
<LIGERO_AGENT_BODY[30]>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'sr_Latn', 'Promena reda tiketa u <LIGERO_TICKET_Queue>: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

tiketu [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je promenjen red u <LIGERO_TICKET_Queue>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'sr_Latn', 'Istek zaključanog tiketa na čekanju: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

vreme zaključanog tiketa na čekanju [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je dostignuto.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'sr_Latn', 'Istek otključanog tiketa na čekanju: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

vreme otključanog tiketa na čekanju [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je dostignuto.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'sr_Latn', 'Eskalacija tiketa! <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

tiket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je eskalirao!

Vreme eskalacije: <LIGERO_TICKET_EscalationDestinationDate>
Eskaliran od: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'sr_Latn', 'Upozorenje na eskalaciju tiketa! <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

tiket [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] će eskalirati!

Vreme eskalacije: <LIGERO_TICKET_EscalationDestinationDate>
Eskalira za: <LIGERO_TICKET_EscalationDestinationIn>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>


-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'sr_Latn', 'Promena servisa tiketa na <LIGERO_TICKET_Service>: <LIGERO_TICKET_Title>', 'Zdravo <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

servis tiketa [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] je promenjen na <LIGERO_TICKET_Service>.

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (14, 'text/html', 'sr_Latn', 'Podsetnik: <LIGERO_APPOINTMENT_TITLE>', 'Zdravo &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
vreme je za obaveštenje u vezi termina &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot;.<br />
<br />
Opis: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Lokacije: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Kalendar: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Datum početka: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Datum kraja: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Celodnevno: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Ponavljanje: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (15, 'text/plain', 'en', 'Email Delivery Failure', 'Hi <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>,

Please note, that the delivery of an email article of [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] has failed. Please check the email address of your recipient for mistakes and try again. You can manually resend the article from the ticket if required.

Error Message:
<LIGERO_AGENT_TransmissionStatusMessage>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>;ArticleID=<LIGERO_AGENT_ArticleID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table notification_event_message
-- ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (15, 'text/plain', 'hu', 'E-mail kézbesítési hiba', 'Kedves <LIGERO_NOTIFICATION_RECIPIENT_UserFirstname>!

Felhívjuk a figyelmét, hogy a(z) [<LIGERO_CONFIG_Ticket::Hook><LIGERO_CONFIG_Ticket::HookDivider><LIGERO_TICKET_TicketNumber>] jegy e-mail bejegyzésének kézbesítése nem sikerült. Ellenőrizze, hogy nincs-e a címzett e-mail címében hiba, és próbálja meg újra. Kézileg is újraküldheti a bejegyzést a jegyből, ha szükséges.

Hibaüzenet:
<LIGERO_AGENT_TransmissionStatusMessage>

<LIGERO_CONFIG_HttpType>://<LIGERO_CONFIG_FQDN>/<LIGERO_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<LIGERO_TICKET_TicketID>;ArticleID=<LIGERO_AGENT_ArticleID>

-- <LIGERO_CONFIG_NotificationSenderName>');
-- ----------------------------------------------------------
--  insert into table dynamic_field
-- ----------------------------------------------------------
INSERT INTO dynamic_field (internal_field, name, label, field_order, field_type, object_type, config, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'ProcessManagementProcessID', 'Process', 1, 'ProcessID', 'Ticket', '---
DefaultValue: ''''
', 1, 1, current_timestamp, 1, current_timestamp);
-- ----------------------------------------------------------
--  insert into table dynamic_field
-- ----------------------------------------------------------
INSERT INTO dynamic_field (internal_field, name, label, field_order, field_type, object_type, config, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'ProcessManagementActivityID', 'Activity', 1, 'ActivityID', 'Ticket', '---
DefaultValue: ''''
', 1, 1, current_timestamp, 1, current_timestamp);
SET DEFINE OFF;
SET SQLBLANKLINES ON;
