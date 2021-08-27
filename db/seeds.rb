# users = User.create([{ username: 'hamosa', email: 'atefhamosa@gmail.com', password: '222333'}])

# traders = Trader.create([{ tradername: 'Beauty', storename:'BeautyStore', email: 'atefhamosa@gmail.com', password: '222333'}])
# ---------------------------------------------------------

TraderCategory.create(trader_id: 1, category_id: 1)

Item.create(name: "Foundicare", description: "a good item for skin", price: 20.00, size: "200", unit: "ml", quantity: 1, category_id: 1, trader_id:1)

Order.create(trader_id: 1, user_id: 1, item_id: 1, quantity: 1)

Parent.create(name: "fashion")

Category.create(name: 'women clothes', parent_id: 1, image_data: "https://images.bewakoof.com/t320/women-s-solid-tie-hem-casual-shirt-shirt-376349-1626337711.jpg")

Category.create(name: 'makeup', parent_id: 1, image_data: "https://m.media-amazon.com/images/I/51O1IDYXubL.jpg")

Category.create(name: 'bags', parent_id: 1, image_data: "https://m.media-amazon.com/images/I/71JV4Agy93L._AC_UY1000_.jpg")

Category.create(name: 'shoes', parent_id: 1, image_data: "https://mk0chicshoesaei29hdb.kinstacdn.com/wp-content/uploads/product_images/women/footwears/pump_shoes/Tamaris/WOR22421N20AWBLKP-1.jpg")

Category.create(name: 'accessories', parent_id: 1, image_data: "https://www.loewe.com/dw/image/v2/BBPC_PRD/on/demandware.static/-/Library-Sites-LOW_SharedLibrary/default/dwfdae78ec/01%20DISTRIBUTORS%20FW21/PLP_FW21Women_Distri_Accessories_Belts_3000x2250.jpg?sw=768&sfrm=jpg")