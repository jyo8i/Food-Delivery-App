<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Foodie Fly</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" type="image/x-icon" href="images/favicon.ico">
    <link rel="stylesheet" href="cart.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">
                <a href="home"><img src="images/foodieFlyU.jpg" alt="Logo"></a>
            </div>
            <div class="nav-items">
                <div class="nav-links">
                    <a href="#"><i class="fas fa-search"></i> Search</a>
                    <a href="#"><i class="fas fa-percent"></i> Offers</a>
                    <div class="dropdown">
                        <a href="#"><i class="fas fa-user"></i> Account</a>
                        <div class="dropdown-content">
                            <a href="profile.jsp">Profile</a>
                            <a href="#">Orders</a>
                            <a href="#">Favorites</a>
                            <a href="#">Settings</a>
                            <a href="signin.jsp">Log out</a>
                        </div>
                    </div>
                    <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                </div>
            </div>
        </nav>
    </header>

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItem().isEmpty()) {
    %>
    <div class="empty-cart-container">
        <img src="https://static.lenskart.com/media/owndays/mobile/img/owndays/empty-cart.webp" alt="Empty Cart" class="empty-cart-image">
        <h2 class="empty-cart-message">Your cart is empty</h2>
        <p class="empty-cart-subtitle">Add some delicious items from the menu!</p>
        <a href="home" class="browse-restaurants-btn">
            <i class="fas fa-utensils"></i> Browse Restaurants
        </a>
    </div>
    <%
        } else {
            Integer restaurantId = (Integer) session.getAttribute("restaurantId");
            Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    %>
    <div class="cart-page-container">
        <div class="cart-container">
            <div class="restaurant-details">
                <div class="restaurant-image">
                    <img src="<%= restaurant != null && restaurant.getImageUrl() != null ? restaurant.getImageUrl() : "images/default-restaurant.jpg" %>"
                         alt="<%= restaurant != null ? restaurant.getName() : "Restaurant" %>">
                </div>
                <div class="restaurant-info">
                    <div class="restaurant-name"><%= restaurant != null ? restaurant.getName() : "Unknown Restaurant" %></div>
                    <div class="restaurant-meta">
                        <span><i class="fas fa-map-marker-alt"></i> <%= restaurant != null ? restaurant.getAddress() : "Address not available" %></span>
                        <div class="delivery-time">
                            <i class="fas fa-clock"></i>
                            <span>
                                <%= restaurant != null ? restaurant.getDeliveryTime() : "N/A" %> -  
                                <%= restaurant != null ? (restaurant.getDeliveryTime() + 5) : "N/A" %> mins
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="cart-header">
                <h1>Your Cart</h1>
            </div>

            <%
                if (!cart.getItem().isEmpty()) {
                    for (CartItem item : cart.getItem().values()) {
            %>
            <div class="cart-items">
                <div class="cart-item">
                    <div class="item-info">
                        <div class="item-name"><%= item.getName() %></div>
                        <div class="item-price">₹<%= item.getPrice() %></div>
                    </div>
                    <div class="quantity-controls">
                        <% if (item.getQuantity() > 0) { %>
                        <form action="CartServlet" method="post" style="display: inline">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
                            <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                            <input type="hidden" name="action" value="update">
                            <button class="quantity-btn">-</button>
                        </form>
                        <% } else { %>
                        <form action="CartServlet" method="post" style="display: inline">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="hidden" name="action" value="remove">
                            <button class="quantity-btn">-</button>
                        </form>
                        <% } %>
                        <span class="quantity" id="quantity-<%= item.getItemId() %>"><%= item.getQuantity() %></span>
                        <form action="CartServlet" method="post" style="display: inline">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
                            <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                            <input type="hidden" name="action" value="update">
                            <button class="quantity-btn">+</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>

            <div class="cart-summary">
                <div class="total">
                    <span>Total Amount</span>
                    <span id="total-amount">₹<%= cart.getTotalPrice() %></span>
                </div>
            </div>

            <div class="order-notice">
                <h3>Before You Order</h3>
                <ul class="notice-list">
                    <li><i class="fas fa-check-circle"></i><span>Please verify your delivery address and contact details</span></li>
                    <li><i class="fas fa-clock"></i><span>Orders cannot be canceled once the restaurant begins preparing your food</span></li>
                    <li><i class="fas fa-info-circle"></i><span>Customization requests cannot be modified after order confirmation</span></li>
                    <li><i class="fas fa-rupee-sign"></i><span>This order, if cancelled, is non-refundable.</span></li>
                </ul>
            </div>

            <div class="cart-buttons">
                <button class="btn add-more-btn" onclick="window.location.href='menuServlet?restaurantId=<%= restaurantId %>'">
                    ➕ Add More Items
                </button>
                <form action="CartServlet" method="post" style="display: inline;">
                    <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                    <button type="submit" name="action" value="Clear Cart" class="btn clear-cart-btn">
                        Clear Cart
                    </button>
                </form>
            </div>
        </div>

        <div class="delivery-payment-container">
            <form class="checkout-form" action="checkout" method="post">
                <div class="delivery-address">
                    <h2 class="section-title">Delivery Address</h2>
                    <div class="form-group">
                        <input type="text" name="fullName" placeholder="Full Name" required>
                        <input type="tel" name="phoneNumber" placeholder="Phone Number" required>
                    </div>
                    <div class="form-group">
                        <input type="text" name="houseNo" placeholder="House/Flat No." required>
                        <textarea name="address" placeholder="Street Address, Landmark" required></textarea>
                    </div>
                    <div class="form-group">
                        <input type="text" name="city" placeholder="City" required>
                        <input type="text" name="pincode" placeholder="Pincode" required>
                    </div>
                </div>

                <div class="payment-method">
                    <h2 class="section-title">Payment Method</h2>
                    <div class="payment-options">
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="cod" checked>
                            <i class="fas fa-money-bill-wave"></i>
                            <div class="payment-label">
                                <h3>Cash on Delivery</h3>
                                <p>Pay when your order arrives</p>
                            </div>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="card">
                            <i class="fas fa-credit-card"></i>
                            <div class="payment-label">
                                <h3>Credit/Debit Card</h3>
                                <p>Pay securely with your card</p>
                            </div>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="Digital wallet">
                            <i class="fas fa-wallet"></i>
                            <div class="payment-label">
                                <h3>Digital Wallet</h3>
                                <p>Google Pay, PhonePe, Paytm</p>
                            </div>
                        </label>
                    </div>
                </div>
                <input type="submit" value="Place Order" class="submit-order-btn">
            </form>
        </div>
    </div>
    <%
        }
    %>
</body>
</html>
