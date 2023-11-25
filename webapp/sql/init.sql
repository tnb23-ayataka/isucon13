TRUNCATE TABLE themes;
TRUNCATE TABLE icons;
TRUNCATE TABLE reservation_slots;
TRUNCATE TABLE livestream_viewers_history;
TRUNCATE TABLE livecomment_reports;
TRUNCATE TABLE ng_words;
TRUNCATE TABLE reactions;
TRUNCATE TABLE tags;
TRUNCATE TABLE livestream_tags;
TRUNCATE TABLE livecomments;
TRUNCATE TABLE livestreams;
TRUNCATE TABLE users;


ALTER TABLE `themes` auto_increment = 1;
ALTER TABLE `icons` auto_increment = 1;
ALTER TABLE `reservation_slots` auto_increment = 1;
ALTER TABLE `livestream_tags` auto_increment = 1;
ALTER TABLE `livestream_viewers_history` auto_increment = 1;
ALTER TABLE `livecomment_reports` auto_increment = 1;
ALTER TABLE `ng_words` auto_increment = 1;
ALTER TABLE `reactions` auto_increment = 1;
ALTER TABLE `tags` auto_increment = 1;
ALTER TABLE `livecomments` auto_increment = 1;
ALTER TABLE `livestreams` auto_increment = 1;
ALTER TABLE `users` auto_increment = 1;
ALTER TABLE `livecomments` DROP INDEX `livestream_id_idx`;
ALTER TABLE `livecomments` ADD INDEX  `livestream_id_idx` (`livestream_id`, `created_at` DESC);
ALTER TABLE `reactions` DROP INDEX `livestream_id_idx`;
ALTER TABLE `reactions` ADD INDEX `livestream_id_idx` (`livestream_id`, `created_at`);

DROP INDEX `livestream_tags_livestream_id_idx` ON `livestream_tags`;
DROP INDEX `livestream_tags_tag_id_idx` ON `livestream_tags`;
ALTER TABLE `livestream_tags` ADD INDEX `livestream_tags_livestream_id_idx` (`livestream_id`);
ALTER TABLE `livestream_tags` ADD INDEX `livestream_tags_tag_id_idx` (`tag_id`);

DROP INDEX `user_id_idx` ON `livestreams`;
ALTER TABLE `livestreams` ADD INDEX `user_id_idx` (`user_id`);

DROP INDEX `user_id_idx` ON `icons`;
ALTER TABLE `icons` ADD INDEX `user_id_idx` (`user_id`);
