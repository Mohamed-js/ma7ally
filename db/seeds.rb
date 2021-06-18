# users = User.create([{ username: 'hamosa', email: 'atefhamosa@gmail.com', password: '222333'}])

# traders = Trader.create([{ tradername: 'Beauty', storename:'BeautyStore', email: 'atefhamosa@gmail.com', password: '222333'}])
# ---------------------------------------------------------


Category.create(name: 'foundation')

TraderCategory.create(trader_id: 1, category_id: 1)

Item.create(name: "Foundicare", description: "a good item for skin", price: 20.00, size: "200", unit: "ml", quantity: 1, category_id: 1, trader_id:1)

Order.create(trader_id: 1, user_id: 1, item_id: 1, quantity: 1)

