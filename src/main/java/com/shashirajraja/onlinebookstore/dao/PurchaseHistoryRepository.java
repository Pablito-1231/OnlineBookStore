package com.shashirajraja.onlinebookstore.dao;

import java.util.Date;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shashirajraja.onlinebookstore.entity.Customer;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;

@Repository
public interface PurchaseHistoryRepository extends JpaRepository<PurchaseHistory, String> {

	@Query("from PurchaseHistory where customer = ?1")
	Set<PurchaseHistory> findAllByCustomer(Customer customer);

	@Query("select count(ph) from PurchaseHistory ph where ph.date between :start and :end")
	Long countComprasEntre(@Param("start") Date start, @Param("end") Date end);

}
