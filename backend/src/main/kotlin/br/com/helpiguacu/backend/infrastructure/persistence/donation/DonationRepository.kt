package br.com.helpiguacu.backend.infrastructure.persistence.donation

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface DonationRepository: JpaRepository<Donation, Long> {
    fun findByDonorId(donorId: Long): List<Donation>
}