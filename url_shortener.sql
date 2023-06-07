-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 07 2023 г., 14:55
-- Версия сервера: 10.4.27-MariaDB
-- Версия PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `url_shortener`
--

-- --------------------------------------------------------

--
-- Структура таблицы `urls`
--

CREATE TABLE `urls` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `short_url` varchar(255) NOT NULL,
  `clicks` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `urls`
--

INSERT INTO `urls` (`id`, `user_id`, `url`, `short_url`, `clicks`) VALUES
(48, NULL, 'https://learngitbranching.js.org/?locale=ru_RU', '2xllh0', 0),
(49, NULL, 'https://learngitbranching.js.org/?locale=ru_RU', 'ok9vYG', 0),
(50, NULL, 'https://learngitbranching.js.org/?locale=ru_RU', 'aX4lKc', 0),
(51, NULL, 'https://learngitbranching.js.org/?locale=ru_RU', 'A2Nclv', 0),
(52, NULL, 'https://learngitbranching.js.org/?locale=ru_RU', 'fv1E2e', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `login`, `password`) VALUES
(1, 'Alex', 'travor', '$2y$10$t9M0L2f.5gIgBtPxOcSlveIfXNTnOC5jYVB8bzAA4e4FBHdqxBng2'),
(2, 'anna', 'san', '$2y$10$uHTBEoEo3VI08TVW.XX5G.mG7tUXAULP/c28/jxe1v2iA2ULr/Kx6'),
(3, 'anna', 'sam', '$2y$10$yLirfgvb8we.cJv1rgrEJeY5ou3MxnSWiy6YeUu0tS.bee4PKdW0.'),
(4, 'seri', 'magda', '$2y$10$3eN1hvkPvf3E.Vm9h/Rgs.IDLpEbVy4jOs0i4YcScP8SIv5dLZ77q'),
(5, 'grigirii', 'dam', '$2y$10$uKWYrQiy2OV8XaQwoCn18uk2.4EHe3iAM4ChM5s74Gy6LAsQe1sMC'),
(6, 'gri', 'gri', '$2y$10$btZAg.VGDwQprVrJy0Md/..bKU3.w2swcu64bH2IPBJQjOvwz4Rk6'),
(7, 'alex1', 'travor1', '$2y$10$iaZvP4.gn5v6thPtEo3Bje..RgnY1t0x3rCaeNDT9qawNeXDNBVfy'),
(8, 'sam', 'samy', '$2y$10$89aCaVlyA7IbT4KFwp8Sp.9TLBhKlYdaAtga1gvoIALRKriBUJrhO');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `urls`
--
ALTER TABLE `urls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `urls`
--
ALTER TABLE `urls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `urls`
--
ALTER TABLE `urls`
  ADD CONSTRAINT `urls_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
