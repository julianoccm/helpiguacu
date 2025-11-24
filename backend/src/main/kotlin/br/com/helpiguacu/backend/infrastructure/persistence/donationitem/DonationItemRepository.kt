package br.com.helpiguacu.backend.infrastructure.persistence.donationitem

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface DonationItemRepository: JpaRepository<DonationItem, Long>