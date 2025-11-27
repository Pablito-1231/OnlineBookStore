package com.shashirajraja.onlinebookstore.service;

import java.util.Date;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import jakarta.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shashirajraja.onlinebookstore.dao.BookUserRepository;
import com.shashirajraja.onlinebookstore.dao.CustomerRepository;
import com.shashirajraja.onlinebookstore.dao.PurchaseDetailRepository;
import com.shashirajraja.onlinebookstore.dao.PurchaseHistoryRepository;
import com.shashirajraja.onlinebookstore.entity.Book;
import com.shashirajraja.onlinebookstore.entity.BookUser;
import com.shashirajraja.onlinebookstore.entity.BookUserId;
import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.PurchaseDetail;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;
import com.shashirajraja.onlinebookstore.entity.ShoppingCart;
import com.shashirajraja.onlinebookstore.utility.IDUtil;

@Service
public class PaymentServiceImpl implements PaymentService {

	private static final Logger log = LoggerFactory.getLogger(PaymentServiceImpl.class);

	@Autowired
	CustomerRepository customerRepos;
	
	@Autowired
	PurchaseHistoryRepository purchaseHistoryRepos;
	
	@Autowired
	PurchaseDetailRepository purchaseDetailRepos;
	
	@Autowired
	BookUserRepository bookUserRepos;
	
	@Override
	@Transactional
	public String createTransaction(Customer customer) {
		// Ensure we operate on a managed Customer entity to avoid lazy-proxy 'no session' errors.
		Customer managedCustomer = customerRepos.findById(customer.getUsername()).orElse(customer);
		// get the customer cart items from the managed entity
		Set<ShoppingCart> items = managedCustomer.getShoppingCart();
		
		//create a transaction purchase history
		PurchaseHistory purchaseHistory = new PurchaseHistory(IDUtil.generatePurchaseHistoryId(),new Date());
		purchaseHistory.setCustomer(customer);
		
		Set<PurchaseDetail> purchaseDetails = null;
		Set<Book> books = new HashSet<Book>();
		for(ShoppingCart item : items) {
			double price = item.getBook().getPrice();
			int available = item.getBook().getQuantity();
			int toBuy = item.getQuantity();
		if(available < toBuy)
			return "El libro llamado: "+item.getBook().getName() + " ¡está agotado!";
			available = available - toBuy;
			PurchaseDetail purchaseDetail = new PurchaseDetail(purchaseHistory,item.getBook(),price,toBuy);
			if(purchaseDetails == null)
				purchaseDetails = new HashSet<PurchaseDetail>();
			purchaseDetails.add(purchaseDetail);
			item.getBook().setQuantity(available);
			books.add(item.getBook());
		}
		
		//now add the purchase details to purchase history
		purchaseHistory.setPurchaseDetails(purchaseDetails);
		
		//save the purchase History
		try {
			// Primero guardar el purchaseHistory directamente
			purchaseHistoryRepos.save(purchaseHistory);
			
			// Luego limpiar el carrito y actualizar el customer
			managedCustomer.getShoppingCart().clear();
			customerRepos.save(managedCustomer);
			
			//add the books to the customers service
			for(Book item: books) {
				BookUserId theId = new BookUserId(item, managedCustomer);
				Optional<BookUser> theOpt = bookUserRepos.findById(theId);
				if(theOpt.isEmpty()) {
					int y = bookUserRepos.addBookToUser(theId.getBook().getId(), theId.getCustomer().getUsername());
					if(y <=0) 
						throw new RuntimeException("¡No se pudo establecer la relación entre libro y usuario!");
				}
			}
		}
		catch(Exception ex) {
			log.error("Error al procesar transacción para el cliente '{}': {}", customer.getUsername(), ex);
			throw new RuntimeException("Error al procesar el pago: " + ex.getMessage(), ex);
		}
		return purchaseHistory.getId();
	}

	@Override
	@Transactional
	public Set<PurchaseHistory> getPurchaseHistories(Customer customer) {
		Set<PurchaseHistory> histories = new HashSet<PurchaseHistory>();
		histories.addAll(purchaseHistoryRepos.findAllByCustomer(customer));
		customer.setPurchaseHistories(histories);
		return histories;
	}

	@Override
	@Transactional
	public Set<PurchaseDetail> getPurchaseDetails(PurchaseHistory purchaseHistory) {
		Set<PurchaseDetail> details = new HashSet<PurchaseDetail>();
		details.addAll(purchaseDetailRepos.findAllByHistory(purchaseHistory));
		return details;
	}

	@Override
	@Transactional
	public PurchaseHistory getPurchaseHistory(Customer customer, String transId) {
		if (customer == null || transId == null || transId.trim().isEmpty()) {
			return null;
		}
		
		PurchaseHistory purchaseHistory = null;
		Optional<PurchaseHistory> history = purchaseHistoryRepos.findById(transId);
		if(history.isPresent()) {
			purchaseHistory = history.get();
			if(!purchaseHistory.getCustomer().getUsername().equals(customer.getUsername())) {
				purchaseHistory = null;
			} else {
				// Cargar explícitamente los detalles dentro de la transacción
				Set<PurchaseDetail> details = new HashSet<>();
				details.addAll(purchaseDetailRepos.findAllByHistory(purchaseHistory));
				purchaseHistory.setPurchaseDetails(details);
			}
		}
		return purchaseHistory;
	}

}
