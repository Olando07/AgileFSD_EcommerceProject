# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end if Rails.env.development?

# Clear existing data
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
User.destroy_all
Province.destroy_all

puts "Seeding provinces with tax rates..."

provinces_data = [
  { name: "Alberta", abbreviation: "AB", gst: 0.05, pst: 0, hst: 0 },
  { name: "British Columbia", abbreviation: "BC", gst: 0.05, pst: 0.07, hst: 0 },
  { name: "Manitoba", abbreviation: "MB", gst: 0.05, pst: 0.07, hst: 0 },
  { name: "New Brunswick", abbreviation: "NB", gst: 0, pst: 0, hst: 0.15 },
  { name: "Newfoundland and Labrador", abbreviation: "NL", gst: 0, pst: 0, hst: 0.15 },
  { name: "Northwest Territories",abbreviation: "NT", gst: 0.05, pst: 0, hst: 0 },
  { name: "Nova Scotia", abbreviation: "NS", gst: 0, pst: 0, hst: 0.15 },
  { name: "Nunavut", abbreviation: "NU", gst: 0.05, pst: 0, hst: 0 },
  { name: "Ontario", abbreviation: "ON", gst: 0, pst: 0, hst: 0.13 },
  { name: "Prince Edward Island", abbreviation: "PE", gst: 0, pst: 0, hst: 0.15 },
  { name: "Quebec", abbreviation: "QC", gst: 0.05, pst: 0.09975, hst: 0 },
  { name: "Saskatchewan", abbreviation: "SK", gst: 0.05, pst: 0.06, hst: 0 },
  { name: "Yukon", abbreviation: "YT", gst: 0.05, pst: 0, hst: 0 }
]

provinces_data.each { |data| Province.create!(data) }
puts "Created #{Province.count} provinces"

puts "Creating admin user..."
User.find_or_create_by(email: "admin@aw.com") do |user|
  user.name = "Admin"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.street_address = "123 Admin St"
  user.telephone = "204-555-0100"
  user.province = Province.first
  user.is_admin = true
end
puts "Admin user created: admin@aw.com / password123"

puts "Seeding 100 A&W products..."

# BURGERS - 25 products
burgers = [
  { name: "Teen Burger", description: "Bacon, cheese, lettuce, tomato, and Teen Sauce", price: 8.99, category: "Burgers" },
  { name: "Mozza Burger", description: "Mozzarella cheese, bacon, lettuce, tomato", price: 7.99, category: "Burgers" },
  { name: "Buddy Burger", description: "Two beef patties, cheese, pickles, onions", price: 6.99, category: "Burgers" },
  { name: "Mama Burger", description: "Beef patty, cheese, lettuce, tomato, pickles", price: 5.99, category: "Burgers" },
  { name: "Papa Burger", description: "Double beef patty, cheese, lettuce, tomato", price: 7.49, category: "Burgers" },
  { name: "Grandpa Burger", description: "Triple beef patty, cheese, bacon", price: 9.99, category: "Burgers" },
  { name: "Chubby Chicken Burger", description: "Crispy chicken, lettuce, mayo", price: 7.99, category: "Burgers" },
  { name: "Spicy Habanero Burger", description: "Beef patty, habanero cheese, jalapeños", price: 8.49, category: "Burgers" },
  { name: "Whistle Dog", description: "All-beef hot dog with toppings", price: 4.99, category: "Burgers" },
  { name: "Coney Dog", description: "Hot dog with chili and cheese", price: 5.49, category: "Burgers" },
  { name: "Beyond Meat Burger", description: "Plant-based patty, lettuce, tomato", price: 9.49, category: "Burgers" },
  { name: "Bacon & Egger", description: "Bacon, egg, cheese on English muffin", price: 6.49, category: "Burgers" },
  { name: "Sausage & Egger", description: "Sausage, egg, cheese on English muffin", price: 6.49, category: "Burgers" },
  { name: "Double Teen Burger", description: "Double beef, double bacon, cheese", price: 11.99, category: "Burgers" },
  { name: "Mushroom Mozza Burger", description: "Mozzarella, sautéed mushrooms", price: 8.49, category: "Burgers" },
  { name: "BBQ Bacon Burger", description: "BBQ sauce, bacon, onion rings", price: 8.99, category: "Burgers" },
  { name: "Classic Cheeseburger", description: "Beef patty, cheese, pickles", price: 5.49, category: "Burgers" },
  { name: "Lettuce Wrap Burger", description: "Burger wrapped in lettuce", price: 7.99, category: "Burgers" },
  { name: "Spicy Chicken Burger", description: "Spicy crispy chicken, mayo", price: 7.99, category: "Burgers" },
  { name: "Grilled Chicken Burger", description: "Grilled chicken, lettuce, tomato", price: 7.49, category: "Burgers" },
  { name: "Fish Burger", description: "Crispy fish fillet, tartar sauce", price: 6.99, category: "Burgers" },
  { name: "Veggie Burger", description: "Veggie patty, lettuce, tomato", price: 6.99, category: "Burgers" },
  { name: "Jalapeño Burger", description: "Beef, pepper jack cheese, jalapeños", price: 7.99, category: "Burgers" },
  { name: "Mushroom Swiss Burger", description: "Swiss cheese, mushrooms", price: 8.49, category: "Burgers" },
  { name: "Hawaiian Burger", description: "Teriyaki, pineapple, bacon", price: 8.99, category: "Burgers" }
]

# SIDES - 25 products
sides = [
  { name: "Fries", description: "Seasoned french fries", price: 3.99, category: "Sides" },
  { name: "Poutine", description: "Fries, gravy, cheese curds", price: 6.99, category: "Sides" },
  { name: "Chubby Chicken Tenders", description: "3 crispy chicken tenders", price: 7.99, category: "Sides" },
  { name: "Onion Rings", description: "Crispy golden onion rings", price: 4.99, category: "Sides" },
  { name: "Sweet Potato Fries", description: "Crispy sweet potato fries", price: 4.49, category: "Sides" },
  { name: "Cheese Curds", description: "Breaded cheese curds", price: 5.99, category: "Sides" },
  { name: "Mozza Sticks", description: "Mozzarella cheese sticks", price: 5.49, category: "Sides" },
  { name: "Chicken Nuggets", description: "6 piece chicken nuggets", price: 5.99, category: "Sides" },
  { name: "Loaded Fries", description: "Fries with cheese and bacon", price: 5.99, category: "Sides" },
  { name: "Cajun Fries", description: "Spicy cajun seasoned fries", price: 4.49, category: "Sides" },
  { name: "Gravy", description: "Side of gravy", price: 1.99, category: "Sides" },
  { name: "Coleslaw", description: "Creamy coleslaw", price: 2.99, category: "Sides" },
  { name: "Garden Salad", description: "Fresh garden salad", price: 4.99, category: "Sides" },
  { name: "Caesar Salad", description: "Caesar salad with dressing", price: 5.49, category: "Sides" },
  { name: "Chicken Caesar Salad", description: "Caesar with grilled chicken", price: 8.99, category: "Sides" },
  { name: "Chili", description: "Beef chili with beans", price: 4.99, category: "Sides" },
  { name: "Chili Cheese Fries", description: "Fries topped with chili and cheese", price: 6.49, category: "Sides" },
  { name: "Apple Slices", description: "Fresh apple slices", price: 2.49, category: "Sides" },
  { name: "Hash Browns", description: "Crispy hash browns", price: 2.99, category: "Sides" },
  { name: "Bacon Strips", description: "3 strips of bacon", price: 3.49, category: "Sides" },
  { name: "Sausage Patties", description: "2 sausage patties", price: 3.49, category: "Sides" },
  { name: "Popcorn Chicken", description: "Bite-sized popcorn chicken", price: 6.49, category: "Sides" },
  { name: "Mac & Cheese Bites", description: "Breaded mac and cheese", price: 5.99, category: "Sides" },
  { name: "Jalapeño Poppers", description: "Cream cheese stuffed jalapeños", price: 5.49, category: "Sides" },
  { name: "Waffle Fries", description: "Crispy waffle cut fries", price: 4.49, category: "Sides" }
]

# DRINKS - 25 products
drinks = [
  { name: "A&W Root Beer (Small)", description: "Classic A&W Root Beer", price: 2.49, category: "Drinks" },
  { name: "A&W Root Beer (Medium)", description: "Classic A&W Root Beer", price: 2.99, category: "Drinks" },
  { name: "A&W Root Beer (Large)", description: "Classic A&W Root Beer", price: 3.49, category: "Drinks" },
  { name: "Root Beer Float", description: "Root beer with vanilla soft serve", price: 4.99, category: "Drinks" },
  { name: "Coke (Small)", description: "Coca-Cola", price: 2.49, category: "Drinks" },
  { name: "Coke (Medium)", description: "Coca-Cola", price: 2.99, category: "Drinks" },
  { name: "Coke (Large)", description: "Coca-Cola", price: 3.49, category: "Drinks" },
  { name: "Diet Coke (Medium)", description: "Diet Coca-Cola", price: 2.99, category: "Drinks" },
  { name: "Sprite (Medium)", description: "Sprite", price: 2.99, category: "Drinks" },
  { name: "Iced Tea (Medium)", description: "Freshly brewed iced tea", price: 2.99, category: "Drinks" },
  { name: "Lemonade (Medium)", description: "Fresh lemonade", price: 2.99, category: "Drinks" },
  { name: "Orange Juice (Small)", description: "Fresh orange juice", price: 2.99, category: "Drinks" },
  { name: "Apple Juice (Small)", description: "Apple juice", price: 2.49, category: "Drinks" },
  { name: "Milk (Small)", description: "Cold milk", price: 2.49, category: "Drinks" },
  { name: "Chocolate Milk (Small)", description: "Chocolate milk", price: 2.99, category: "Drinks" },
  { name: "Coffee (Small)", description: "Hot brewed coffee", price: 1.99, category: "Drinks" },
  { name: "Coffee (Medium)", description: "Hot brewed coffee", price: 2.49, category: "Drinks" },
  { name: "Coffee (Large)", description: "Hot brewed coffee", price: 2.99, category: "Drinks" },
  { name: "Iced Coffee", description: "Cold iced coffee", price: 3.49, category: "Drinks" },
  { name: "Hot Chocolate", description: "Rich hot chocolate", price: 2.99, category: "Drinks" },
  { name: "Bottled Water", description: "Bottled water", price: 1.99, category: "Drinks" },
  { name: "Sparkling Water", description: "Sparkling water", price: 2.49, category: "Drinks" },
  { name: "Strawberry Milkshake", description: "Thick strawberry shake", price: 4.99, category: "Drinks" },
  { name: "Chocolate Milkshake", description: "Thick chocolate shake", price: 4.99, category: "Drinks" },
  { name: "Vanilla Milkshake", description: "Thick vanilla shake", price: 4.99, category: "Drinks" }
]

# COMBOS - 25 products
combos = [
  { name: "Teen Burger Combo", description: "Teen Burger, fries, drink", price: 12.99, category: "Combos" },
  { name: "Mozza Burger Combo", description: "Mozza Burger, fries, drink", price: 11.99, category: "Combos" },
  { name: "Buddy Burger Combo", description: "Buddy Burger, fries, drink", price: 10.99, category: "Combos" },
  { name: "Mama Burger Combo", description: "Mama Burger, fries, drink", price: 9.99, category: "Combos" },
  { name: "Papa Burger Combo", description: "Papa Burger, fries, drink", price: 11.49, category: "Combos" },
  { name: "Chubby Chicken Combo", description: "Chicken burger, fries, drink", price: 11.99, category: "Combos" },
  { name: "Chicken Tender Combo", description: "3 tenders, fries, drink", price: 11.99, category: "Combos" },
  { name: "Double Teen Combo", description: "Double Teen, fries, drink", price: 15.99, category: "Combos" },
  { name: "Beyond Meat Combo", description: "Beyond burger, fries, drink", price: 13.49, category: "Combos" },
  { name: "Bacon & Egger Combo", description: "Bacon Egger, hash browns, coffee", price: 8.99, category: "Combos" },
  { name: "Sausage & Egger Combo", description: "Sausage Egger, hash browns, coffee", price: 8.99, category: "Combos" },
  { name: "Breakfast Burrito Combo", description: "Breakfast burrito, hash browns, coffee", price: 9.49, category: "Combos" },
  { name: "Fish Burger Combo", description: "Fish burger, fries, drink", price: 10.99, category: "Combos" },
  { name: "Spicy Chicken Combo", description: "Spicy chicken, fries, drink", price: 11.99, category: "Combos" },
  { name: "Grilled Chicken Combo", description: "Grilled chicken, fries, drink", price: 11.49, category: "Combos" },
  { name: "Kids Teen Burger Combo", description: "Small burger, fries, juice", price: 7.99, category: "Combos" },
  { name: "Kids Chicken Nugget Combo", description: "6 nuggets, fries, juice", price: 7.99, category: "Combos" },
  { name: "Kids Chubby Chicken Combo", description: "Small chicken, fries, juice", price: 7.99, category: "Combos" },
  { name: "Family Bundle", description: "4 burgers, 4 fries, 4 drinks", price: 39.99, category: "Combos" },
  { name: "Date Night Bundle", description: "2 Teen combos, 2 milkshakes", price: 29.99, category: "Combos" },
  { name: "BBQ Bacon Combo", description: "BBQ Bacon burger, onion rings, drink", price: 12.99, category: "Combos" },
  { name: "Poutine Combo", description: "Burger of choice, poutine, drink", price: 14.99, category: "Combos" },
  { name: "Salad Combo", description: "Chicken Caesar salad, drink", price: 11.99, category: "Combos" },
  { name: "Breakfast Platter", description: "Eggs, bacon, sausage, hash browns, toast", price: 10.99, category: "Combos" },
  { name: "Ultimate Feast", description: "Grandpa burger, loaded fries, root beer float", price: 17.99, category: "Combos" }
]

all_products = burgers + sides + drinks + combos
all_products.each { |product| Product.create!(product) }

puts "Created #{Product.count} products across 4 categories"
puts "Burgers: #{Product.where(category: 'Burgers').count}"
puts "Sides: #{Product.where(category: 'Sides').count}"
puts "Drinks: #{Product.where(category: 'Drinks').count}"
puts "Combos: #{Product.where(category: 'Combos').count}"

Page.find_or_create_by(slug: 'about') do |page|
  page.title = 'About Us'
  page.content = <<~CONTENT
    Welcome to A&W Canada! We've been serving Canadians for over 106 years.

    Our Mission:
    A&W Canada's mission is to make A&W the #1 burger choice and the fastest-growing, most successful burger business in Canada.

    Our Story:
    A&W is a proud Canadian franchise committed to quality and sustainability. We were the first Canadian fast-food chain to use beef raised without hormones or steroids (since 2012) and the first restaurant chain in North America to commit to eliminating plastic straws.

    What Makes Us Different:
    - Hormone and antibiotic-free beef
    - Natural root beer made fresh daily
    - Compostable and recyclable packaging
    - Support for Canadians with Multiple Sclerosis through "Burgers to Beat MS" (over $20 million raised)
    - Locally sourced ingredients including tomatoes grown in energy-efficient greenhouses
    - Fair-trade organic coffee

    Our Commitment:
    From introducing recyclable and compostable packaging to fundraising to support Canadians living with Multiple Sclerosis, we strive to make a positive impact in our community. We hope that an option from our varying menu will entice you to become a regular customer and support us in our mission.
  CONTENT
end

Page.find_or_create_by(slug: 'contact') do |page|
  page.title = 'Contact Us'
  page.content = <<~CONTENT
    Get in Touch

    We'd love to hear from you! Whether you have questions, feedback, or just want to say hello, feel free to reach out.

    Contact Information:
    Email: contact@aw-canada.com
    Phone: (555) 123-4567

    Address:
    A&W Canada
    123 Main Street
    Winnipeg, MB R3C 1A5

    Hours of Operation:
    Monday - Thursday: 10:00 AM - 10:00 PM
    Friday - Saturday: 10:00 AM - 11:00 PM
    Sunday: 11:00 AM - 9:00 PM

    Follow Us:
    Facebook: @AWCanada
    Instagram: @awcanada
    Twitter: @AWCanada

    For franchise inquiries, please email: franchise@aw-canada.com
  CONTENT
end

puts "Pages created successfully!"
