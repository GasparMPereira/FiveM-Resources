INSERT INTO `jobs` (`name`, `label`) VALUES
('gardener', 'Tuinier');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('gardener', 0, 'interim', 'Werknemer', 400, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('contrat', 'Werkbon tuinier', 100, 0, 1);
