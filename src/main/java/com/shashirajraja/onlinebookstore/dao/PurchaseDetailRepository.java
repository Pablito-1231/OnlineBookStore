package com.shashirajraja.onlinebookstore.dao;

import java.util.Date;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shashirajraja.onlinebookstore.entity.PurchaseDetail;
import com.shashirajraja.onlinebookstore.entity.PurchaseDetailId;
import com.shashirajraja.onlinebookstore.entity.PurchaseHistory;

@Repository
public interface PurchaseDetailRepository extends JpaRepository<PurchaseDetail, PurchaseDetailId> {

	
	@Query("from PurchaseDetail where purchaseHistory = ?1")
	Set<PurchaseDetail> findAllByHistory(PurchaseHistory purchaseHistory);

	@Query("select coalesce(sum(pd.price * pd.quantity), 0) from PurchaseDetail pd")
	Double sumIngresosTotales();

	@Query("select coalesce(sum(pd.price * pd.quantity), 0) from PurchaseDetail pd where pd.purchaseHistory.date between :start and :end")
	Double sumIngresosEntre(@Param("start") Date start, @Param("end") Date end);

}
