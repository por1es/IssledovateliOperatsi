CREATE TABLE `Группа показателей контроля` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`Name` VARCHAR(255) NOT NULL,
	`Description ` TEXT(65535) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `Показатели контроля` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name ` VARCHAR(255) NOT NULL,
	`group_id` INTEGER NOT NULL,
	`description ` TEXT(65535) NOT NULL,
	`remediation_period ` INTEGER NOT NULL,
	`penalty_amount ` DECIMAL NOT NULL,
	`penalty_percent ` DECIMAL NOT NULL,
	`violation_sign` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `Объекты контроля` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`responsible_id` INTEGER,
	`description` TEXT(65535),
	`name` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `Контакт (Сотрудник)` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`Name` VARCHAR(255) NOT NULL,
	`Phone` INTEGER NOT NULL,
	`Email` VARCHAR(255),
	`Photo` VARCHAR(255),
	PRIMARY KEY(`id`)
);


CREATE TABLE `Нарушения` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`check_id` INTEGER NOT NULL,
	`checklist_item_id` INTEGER NOT NULL,
	`description` TEXT(65535),
	`responsible_id` INTEGER NOT NULL,
	`photo` VARCHAR(255) NOT NULL,
	`due_date` DATE NOT NULL,
	`fact_date` DATE,
	`penalty_amount` DECIMAL NOT NULL,
	`object` INTEGER,
	PRIMARY KEY(`id`)
);


CREATE TABLE `Пункты чек-листа` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`checklist_id` INTEGER NOT NULL,
	`control_indicator` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `Чек-листы` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(255) NOT NULL,
	`description` TEXT(65535),
	`created_date` DATETIME NOT NULL,
	`List_checklist` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE `Проверки` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`control_object` INTEGER NOT NULL,
	`responsible_id` INTEGER NOT NULL,
	`inspector_id` INTEGER NOT NULL,
	`date` DATE NOT NULL,
	`checklist_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


ALTER TABLE `Группа показателей контроля`
ADD FOREIGN KEY(`id`) REFERENCES `Показатели контроля`(`group_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Показатели контроля`
ADD FOREIGN KEY(`id`) REFERENCES `Пункты чек-листа`(`control_indicator`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Чек-листы`
ADD FOREIGN KEY(`List_checklist`) REFERENCES `Пункты чек-листа`(`checklist_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Нарушения`
ADD FOREIGN KEY(`check_id`) REFERENCES `Проверки`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Проверки`
ADD FOREIGN KEY(`control_object`) REFERENCES `Объекты контроля`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Проверки`
ADD FOREIGN KEY(`inspector_id`) REFERENCES `Контакт (Сотрудник)`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Объекты контроля`
ADD FOREIGN KEY(`responsible_id`) REFERENCES `Контакт (Сотрудник)`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Нарушения`
ADD FOREIGN KEY(`responsible_id`) REFERENCES `Контакт (Сотрудник)`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Проверки`
ADD FOREIGN KEY(`responsible_id`) REFERENCES `Контакт (Сотрудник)`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Нарушения`
ADD FOREIGN KEY(`checklist_item_id`) REFERENCES `Показатели контроля`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Нарушения`
ADD FOREIGN KEY(`object`) REFERENCES `Объекты контроля`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;