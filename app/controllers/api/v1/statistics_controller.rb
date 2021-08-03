class Api::V1::StatisticsController < ApplicationController
    before_action :set_trader

    # Give general numbers for the statistics.
    def index
        # Some needed vars
        this_month = Date.today.beginning_of_month

        # Orders' total price count
        total_revenue = Order.where(trader_id: @trader.id).sum("total")

        # Orders' total price count this month
        this_month_revenue = Order.where(trader_id: @trader.id).where('created_at > ?', (this_month)).sum("total")

        # Orders' total price count for a specific category
        trader_item_ids_in_category = @trader.items.where(category_id: params[:category_id]).select(:id)
        category_total_revenue = Order.where("Cast(item_id AS int) IN (?)", trader_item_ids_in_category).sum("total")

        # Orders' total price count for each category
        categories_vs_revenue = []
        @trader.categories.each do|category|
            c_trader_item_ids_in_category = @trader.items.where(category_id: category.id).select(:id)
            c_category_total_revenue = Order.where("Cast(item_id AS int) IN (?)", c_trader_item_ids_in_category).sum("total")
            categories_vs_revenue.push(Hash[category.name, c_category_total_revenue])
        end
        categories_vs_revenue  # The result

        # ----------------------------------------------------------------------------
        # ----------------------------------------------------------------------------

        # Orders count
        total_num_orders = @trader.orders.count
        # Orders count this month
        this_month_num_orders = @trader.orders.where('created_at > ?', (this_month)).count

        # ----------------------------------------------------------------------------
        # ----------------------------------------------------------------------------

        # Unique orders count in user_id
        customer_total_active_number = 

        # Unique carts count - active members
        customer_total_inactive_number = 

        # ----------------------------------------------------------------------------
        # ----------------------------------------------------------------------------

        # Get traders orders and group by user_id and count for them and return the number of the top 10 in counts. 
        top_products_in_orders_count = 

        # Get traders orders and group by user_id the count of the value
        top_products_in_orders_value = 

        # Sort them according to traffic -- Still needs Model modifications
        top_products_in_traffic = 

        # Sort them according to the count in carts
        top_products_in_carts = 

        # Top ordered products in a category
        # NEEDED
        # Top ordered products in the top categories
        # NEEDED

        @statistics = 
    end
    

end