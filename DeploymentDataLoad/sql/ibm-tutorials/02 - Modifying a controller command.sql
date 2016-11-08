UPDATE CMDREG
SET CLASSNAME = 'com.ibm.commerce.sample.commands.MyOrderItemAddCmdImpl'
-- Original classname
--SET CLASSNAME = 'com.ibm.commerce.orderitems.commands.OrderItemAddCmdImpl'
WHERE INTERFACENAME = 'com.ibm.commerce.orderitems.commands.OrderItemAddCmd'
AND STOREENT_ID = 0;