class Api::V1::StatisticsController < ApplicationController
    before_action :set_trader

    # Give general numbers for the statistics.
    def index
        # SOME NEEDED VARS TO HELP LATER
        trader_orders = Order.where(trader_id: @trader.id)
        trader_cart_items = Cart.where(trader_id: @trader.id)
        this_month = Date.today.beginning_of_month

        # Orders' total price count
        total_revenue = trader_orders.sum("total") # The result ------ Success with good results

        # # Orders' total price count this month
        this_month_revenue = trader_orders.where('created_at > ?', (this_month)).sum("total") # The result ------ Success with good results

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        # # Orders count
        total_num_orders = @trader.orders.count # The result ------ Success with good results
        total_num_order_items = @trader.order_items.count # The result ------ Success with good results

        # # Orders count this month
        this_month_num_orders = @trader.orders.where('created_at > ?', (this_month)).count # The result  ------ Success with good results
        this_month_num_order_items = @trader.order_items.where('created_at > ?', (this_month)).count # The result  ------ Success with good results

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        # # Unique orders count in user_id
        customer_total_active_number = trader_orders.count('DISTINCT user_id') # The result ------ Success with good results


        # # (Unique carts  - active members) .count = non active carts
        active_members_ids = trader_orders.group(:user_id).count.keys.map{|key| key.to_i}
        inactive_member_ids = trader_cart_items.group(:user_id).count.keys  - active_members_ids
        customer_total_inactive_number = inactive_member_ids.length # The result ------ Success with good results

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        # # Get traders orders and group by user_id and count for them and return the number of the top 10 in counts. 
        # # Returns a hash of item: ordered_times pair 
        # #### TOP ITEMS OCCURED IN ORDERS   ### EX)): ordered in 30 order 1 each order => higher occurence === COUNTS THE ORDERS which had the item
        top_products_in_orders_occurence = OrderItem.where(trader_id: @trader.id).group(:item_id).order('count_all desc').limit(10).count  # The result ------ Success with good results

        # #### TOP ITEMS UNITS SOLD IN ORDERS  ### EX)): ordered in 20 order 2 each order => higher units === COUNTS THE ITEMS ORDERED times ever
        top_products_in_orders_total_units = OrderItem.where(trader_id: @trader.id).group(:item_id).order('sum_quantity desc').limit(10).sum('quantity')  # The result ------ Success with good results

        # # Sort them according to the count in carts ## JUST OCCERENCE REGARDLESS OF ITS TOTAL QUANTITY ==> NEEDED BUT NOT SOLD
        top_products_in_carts_with_count = Cart.where(trader_id: @trader.id).group(:item_id).order('count_all desc').limit(10).count  # The result ------ Success with good results


        # -------------------------------------------------------------------------
        # --------------------- The notwork section -------------------------------

        # # Orders' total revenue for a specific category
        # trader_item_ids_in_this_category = @trader.items.where(category_id: params[:category_id]).select(:id)
        # category_total_revenue = OrderItem.where("Cast(item_id AS int) IN (?)", trader_item_ids_in_this_category).sum("order_items.quantity * order_items.item.price") # Not working yet -- We need to find a solution to the 'order_items.item.price' part, otherwise we will have to mae a total column in the OrderItem model to be able to use it directly. 

        # # Orders' total revenue for all categories as pairs [category_name: total_revenue]
        # categories_vs_revenue = []
        # @trader.categories.each do|category|
        #     c_trader_item_ids_in_category = @trader.items.where(category_id: category.id).select(:id)
        #     c_category_total_revenue = Order.where("Cast(item_id AS int) IN (?)", c_trader_item_ids_in_category).sum("total")
        #     categories_vs_revenue.push(Hash[category.name, c_category_total_revenue])
        # end
        # categories_vs_revenue  # The result -- SUCKS!


        # # Get traders order items and group by item_id the count of the value %%%%%%%%%%%%%%%
        # # top_products_in_orders_value = OrderItem.where(trader_id: 32).group(:item_id).order('sum_quantity desc').limit(10).sum('quantity * (((item.price)))')  # The result

        # # Sort them according to traffic -- Still needs Model modifications %%%%%%%%%%%%%%%%%
        # # top_products_in_traffic = 

        # Top ordered products in a category %%%%%%%%%%%%%%%%%%%
        # top_products_in_orders_total_units_for_category = OrderItem.where(trader_id: 32, item.category_id => 7).group(:item_id).order('sum_quantity desc').limit(10).sum('quantity')

        # Top ordered products in the top categories%%%%%%%%%%%%
        # NEEDED A7aaaaaa

        render json: customer_total_inactive_number
    end
    

end