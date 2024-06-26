--gathered data from multiple table
use BikeStores;

select 
	ord.order_id , 	
	ord.order_date , 
    CONCAT(cus.first_name,' ',cus.last_name) as  Customers,  
	cus.city,
	cus.state,
	pro.product_name,
	brands.brand_name,
	cate.category_name,
	stores.store_name,
	CONCAT(staffs.first_name,' ',staffs.last_name) AS staffName ,
    SUM(order_items.quantity) As total_units,
	Sum(order_items.quantity *order_items.list_price) As Revenue
	

from orders ord

Join customers cus On ord.customer_id = cus.customer_id
join order_items On order_items.order_id = ord.order_id
join products pro on pro.product_id = order_items.product_id
join brands  on pro.brand_id = brands.brand_id
join categories as cate  on pro.category_id = cate.category_id
join stores   on stores.store_id = ord.store_id
join staffs   on staffs.staff_id = ord.staff_id
Group By

    ord.order_id , 
    CONCAT(cus.first_name,' ',cus.last_name) ,
	CONCAT(staffs.first_name,' ',staffs.last_name) ,
	cus.city,
	cus.state,
  	pro.product_name,
	brands.brand_name,
	cate.category_name,
	stores.store_name,	
	ord.order_date 
