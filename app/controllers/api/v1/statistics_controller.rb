class Api::V1::StatisticsController < ApplicationController
    before_action :set_trader

    # Give general numbers for the statistics.
    def index
        # SOME NEEDED VARS TO HELP LATER
        trader_orders = @trader.orders
        trader_order_items = @trader.order_items
        trader_cart_items = Cart.where(trader_id: @trader.id)
        this_month = Date.today.beginning_of_month

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        total_profits = trader_orders.sum("total")
        month_profits = trader_orders.where('created_at > ?', (this_month)).sum("total")

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        total_orders = trader_orders.count
        total_orders_items = trader_order_items.count

        month_orders = trader_orders.where('created_at > ?', (this_month)).count
        month_orders_items = trader_order_items.where('created_at > ?', (this_month)).count

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        # # Unique orders count in user_id
        active_users = trader_orders.count('DISTINCT user_id') # The result

        # # (Unique carts  - active members) .count = non active carts
        active_users_ids = Order.where(trader_id: @trader.id).group(:user_id).sum('total').keys.map{|key| key.to_i}
        inactive_users_ids = trader_cart_items.group(:user_id).count.keys
        inactive_users = inactive_users_ids.length # The result 

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        store_users_count = active_users + inactive_users
        store_items_count = @trader.items.count

        # # ----------------------------------------------------------------------------
        # # ----------------------------------------------------------------------------

        most_popular_products = trader_order_items.joins(:item).select(:total, :name, :image_data).group(:name, :image_data, :price).order('sum_quantity desc').limit(10).sum(:quantity).to_a
        most_profitable_products = trader_order_items.joins(:item).select(:total, :name, :image_data).group(:name, :image_data, :price).order('sum_total desc').limit(10).sum(:total).to_a

        category_revenue_pairs = trader_order_items.joins('INNER JOIN items ON order_items.item_id = items.id LEFT JOIN categories ON items.category_id = categories.id').select('order_items.total, categories.name').group('categories.name').sum('total').to_a # The result

        render json: { 
            store: {
                active_users: active_users,
                inactive_users: inactive_users,
                users: store_users_count,
                items: store_items_count,
                total_profits: total_profits,
                month_profits: month_profits,
                total_orders: total_orders,
                total_orders_items: total_orders_items,
                month_orders: month_orders,
                month_orders_items: month_orders_items,
                most_profitable_products: most_profitable_products,
                most_popular_products: most_popular_products,
                category_profit_pairs: category_revenue_pairs,
            },
        }
    end

    def show
        trader_order_items = @trader.order_items

        # Total profits of a category
        category_total_revenue = trader_order_items.left_joins(:item).where("items.category_id = #{params[:category_id]}").sum('total') # The result
        # Most popular products of a category
        category_most_popular_products = trader_order_items.joins(:item).where("items.category_id = #{params[:category_id]}").select('name, quantity').group(:name).order('sum_quantity desc').limit(10).sum('quantity') # The result

        render json: {
            category_total_revenue: category_total_revenue,
            category_most_popular_products: category_most_popular_products,
        }
    end
end