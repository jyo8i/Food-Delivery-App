package com.tap.model;

public class CartItem {

	private int itemiId;
	private int restaurantId;
	private String name;
	private int price;
	private int quantity;
	
	public CartItem() {
		// TODO Auto-generated constructor stub
	}

	public CartItem(int itemiId, int restaurantId, String name, int price, int quantity) {
		this.itemiId = itemiId;
		this.restaurantId = restaurantId;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
	}

	public int getItemiId() {
		return itemiId;
	}

	public void setItemiId(int itemiId) {
		this.itemiId = itemiId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "CartItem [itemiId=" + itemiId + ", restaurantId=" + restaurantId + ", name=" + name + ", price=" + price
				+ ", quantity=" + quantity + "]";
	}
	
	

}
	