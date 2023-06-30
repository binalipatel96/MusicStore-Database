-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `order_data`
--

DROP TABLE IF EXISTS `order_data`;
/*!50001 DROP VIEW IF EXISTS `order_data`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `order_data` AS SELECT 
 1 AS `order_item_id`,
 1 AS `price_item`,
 1 AS `order_id`,
 1 AS `album_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `max_min_product_view`
--

DROP TABLE IF EXISTS `max_min_product_view`;
/*!50001 DROP VIEW IF EXISTS `max_min_product_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `max_min_product_view` AS SELECT 
 1 AS `album_name`,
 1 AS `sum1`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sum_of_order_qty_view`
--

DROP TABLE IF EXISTS `sum_of_order_qty_view`;
/*!50001 DROP VIEW IF EXISTS `sum_of_order_qty_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sum_of_order_qty_view` AS SELECT 
 1 AS `album_name`,
 1 AS `sum1`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `order_data`
--

/*!50001 DROP VIEW IF EXISTS `order_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_data` AS select `order_items`.`order_item_id` AS `order_item_id`,`order_items`.`price_item` AS `price_item`,`order_items`.`order_id` AS `order_id`,`order_items`.`album_id` AS `album_id` from `order_items` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `max_min_product_view`
--

/*!50001 DROP VIEW IF EXISTS `max_min_product_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `max_min_product_view` AS select `sum_of_order_qty_view`.`album_name` AS `album_name`,`sum_of_order_qty_view`.`sum1` AS `sum1` from `sum_of_order_qty_view` where (`sum_of_order_qty_view`.`sum1` = (select max(`sum_of_order_qty_view`.`sum1`) AS `MaxProductFROMsum_of_order_qty_view`)) union select `sum_of_order_qty_view`.`album_name` AS `album_name`,`sum_of_order_qty_view`.`sum1` AS `sum1` from `sum_of_order_qty_view` where (`sum_of_order_qty_view`.`sum1` = (select min(`sum_of_order_qty_view`.`sum1`) AS `MinProductFROMsum_of_order_qty_view`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sum_of_order_qty_view`
--

/*!50001 DROP VIEW IF EXISTS `sum_of_order_qty_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sum_of_order_qty_view` AS select `a`.`album_name` AS `album_name`,sum(`o`.`order_qty`) AS `sum1` from (`order_items` `o` join `albums` `a` on((`o`.`album_id` = `a`.`album_id`))) where `o`.`order_id` in (select `orders`.`order_id` from `orders` where ((`orders`.`order_date` <= now()) and (`orders`.`order_date` > (now() - interval 1 week)))) group by `a`.`album_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetTotalOfPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalOfPayment`()
Begin
    DECLARE sum_payment_total DECIMAL(9,2);
    SELECT SUM(payment_total) INTO sum_payment_total 
    FROM orders 
    WHERE customer_id=1;    
    SELECT CONCAT('$', sum_payment_total) AS 'Total of payment';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-23 10:19:32
