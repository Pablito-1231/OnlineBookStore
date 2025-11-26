package com.shashirajraja.onlinebookstore.service;

import java.util.HashSet;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.dao.ShoppingCartRepository;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

	@Autowired
	private CustomerRepository theCustomerRepository;
	
	@Autowired
	private ShoppingCartRepository theCartRepository;

	@Override
	@Transactional
	public Set<ShoppingCart> getAllItems(Customer customer) {
		Set<ShoppingCart> items = new HashSet<ShoppingCart>();
		items.addAll(theCartRepository.getItemsByCustomer(customer));
		return items;
	
	}

	@Override
	@Transactional
	public String removeItem(Customer customer, Book book) {
		try {
			int res = theCartRepository.removeByIds(customer.getUsername(), book.getId());
			if(res > 0 ) {
				customer.getShoppingCart().remove(new ShoppingCart(customer,book,1));
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return "Libro: \""+book.getName()+"\" eliminado del carrito!";
	}

	
	@Override
	@Transactional
	public String decreaseItem(Customer customer, Book book, int count) {
		try {
			if (count <= 0) return "Nada para decrementar";
			ShoppingCart existing = theCartRepository.findByIds(customer.getUsername(), book.getId());
			if (existing == null) {
				return "El ítem no existe en el carrito";
			}
			int newCount = existing.getQuantity() - count;
			if (newCount <= 0) {
				int res = theCartRepository.removeByIds(customer.getUsername(), book.getId());
				if (res > 0) {
					customer.getShoppingCart().remove(existing);
					return "Ítem eliminado del carrito";
				}
			} else {
				int res = theCartRepository.updateByIds(customer.getUsername(), book.getId(), newCount);
				if (res > 0) {
					existing.setQuantity(newCount);
					return "Cantidad actualizada a " + newCount + " para '" + book.getName() + "'";
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return "Error al decrementar: " + ex.getMessage();
		}
		return "No se pudo decrementar";
	}
	
	@Override
	@Transactional
	public String addItem(Customer customer, Book book) {
		try {
			ShoppingCart existing = theCartRepository.findByIds(customer.getUsername(), book.getId());
			int stock = book.getQuantity();
			if (existing == null) {
				if (stock <= 0) {
					return "No hay stock disponible para '" + book.getName() + "'";
				}
				int res = theCartRepository.addByIds(customer.getUsername(),book.getId(),1);
				if(res > 0) {
					customer.addShoppingCart(new ShoppingCart(customer,book,1));
				}
			} else {
				int newCount = existing.getQuantity() + 1;
				if (newCount > stock) {
					return "Cantidad supera stock disponible (" + stock + ") para '" + book.getName() + "'";
				}
				int res = theCartRepository.updateByIds(customer.getUsername(), book.getId(), newCount);
				if (res > 0) {
					existing.setQuantity(newCount);
				}
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
			return "Error al agregar al carrito: " + ex.getMessage();
		}
		return "Libro: \""+book.getName()+"\" agregado al carrito";
	}

	@Override
	@Transactional
	public String increaseItem(Customer customer, Book book, int count) {
		try {
			if (count <= 0) return "Nada para incrementar";
			ShoppingCart existing = theCartRepository.findByIds(customer.getUsername(), book.getId());
			if (existing == null) {
				return addItem(customer, book);
			}
			int stock = book.getQuantity();
			int newCount = existing.getQuantity() + count;
			if (newCount > stock) {
				return "Cantidad supera stock disponible (" + stock + ") para '" + book.getName() + "'";
			}
			int res = theCartRepository.updateByIds(customer.getUsername(), book.getId(), newCount);
			if (res > 0) {
				existing.setQuantity(newCount);
				return "Cantidad actualizada a " + newCount + " para '" + book.getName() + "'";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return "Error al incrementar: " + ex.getMessage();
		}
		return "No se pudo incrementar";
	}

	@Override
	@Transactional
	public Set<ShoppingCart> getByUsername(Customer customer) {
		Set<ShoppingCart> items = new HashSet<ShoppingCart>();
		items.addAll(theCartRepository.getItemsByCustomer(customer));
		customer.setShoppingCart(items);
		return customer.getShoppingCart();
	}

}
