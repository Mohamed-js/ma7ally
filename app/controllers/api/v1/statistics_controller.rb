class Api::V1::StatisticsController < ApplicationController
    before_action :set_trader

    # Give general numbers for the statistics.
    def index
        # SOME NEEDED VARS TO HELP LATER
        trader_orders = @trader.orders
        trader_cart_items = Cart.where(trader_id: @trader.id)
        this_month = Date.today.beginning_of_month

        # Orders' total price count
        total_revenue = trader_orders.sum("total") # The result ------ Success with good results

        # # Orders' total price count this month
        this_month_revenue = trader_orders.where('created_at > ?', (this_month)).sum("total") # The result ------ Success with good results

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        # # Orders count
        total_num_orders = trader_orders.count # The result ------ Success with good results
        total_num_order_items = @trader.order_items.count # The result ------ Success with good results

        # # Orders count this month
        this_month_num_orders = trader_orders.where('created_at > ?', (this_month)).count # The result  ------ Success with good results
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

        # #### TOP ITEMS UNITS SOLD IN ORDERS  ### EX)): ordered in 20 order 2 each order => higher units === COUNTS THE ITEMS ORDERED times ever
        top_products_in_orders_total_units = OrderItem.where(trader_id: @trader.id).group(:item_id).order('sum_quantity desc').limit(10).sum('quantity')  # The result ------ Success with good results

        # Sort them according to the count in carts ## JUST OCCERENCE REGARDLESS OF ITS TOTAL QUANTITY ==> NEEDED BUT NOT SOLD
        top_products_in_carts_with_count = Cart.where(trader_id: @trader.id).group(:item_id).order('count_all desc').limit(10).count  # The result ------ Success with good results

        # Orders' total revenue for a specific category
        category_total_revenue = @trader.order_items.left_joins(:item).where("items.category_id = #{params[:category_id]}").sum('total')

        # Orders' total revenue for all categories as pairs [category_name: total_revenue]
        category_revenue_pairs = @trader.order_items.joins('INNER JOIN items ON order_items.item_id = items.id LEFT JOIN categories ON items.category_id = categories.id').select('order_items.total, categories.name').group('categories.name').sum('total').to_a


        # Get traders order items and group by item_id the count of the value
        top_products_in_orders_value = @trader.order_items.joins(:item).select('total, name').group('name').order('sum_total desc').limit(10).sum('total')

        # Top ordered products in a category 
        top_products_in_orders_total_units_for_category = @trader.order_items.joins(:item).where("items.category_id = #{params[:category_id]}").select('name, quantity').group(:name).order('sum_quantity desc').limit(10).sum('quantity')

        render
    end
    

end