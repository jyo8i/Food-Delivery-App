package com.tap.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
	
	HashMap<Integer,CartItem> items;
	
	public Cart() {
		items = new HashMap<Integer, CartItem>();
	}

	public void addCartItem(CartItem item) {
		
		int itemid = item.getItemiId();
		
		if(items.containsKey(itemid)) {
			CartItem existingCartItem = items.get(itemid);
			existingCartItem.setQuantity(existingCartItem.getQuantity() + item.getQuantity());
		} else {
			items.put(itemid, item);
		}

	}
	
	public void updateItem(int itemId, int quantity) {
		if (items.containsKey(itemId)) {
			if (quantity <= 0) {
				items.remove(itemId);
			} else {
				items.get(itemId).setQuantity(quantity);
			}
		}
	}
	
	
	public void removeItem(int menuId) {
		items.remove(menuId);
	}
	
	
	public Map<Integer, CartItem> getItem() {
		return items;
	}
	
	
	public double getTotalPrice() {
		return items.values().stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum();
	}
	
	
	public void clear() {
		items.clear();
	}
	
}
