package br.com.helpiguacu.backend.infrastructure.persistence.donationitem

import br.com.helpiguacu.backend.infrastructure.persistence.donation.Donation
import jakarta.persistence.*

@Entity
@Table(name = "donation_items")
data class DonationItem(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(nullable = false)
    val name: String,

    @Column(nullable = false)
    val quantity: Int,

    val observation: String? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "donation_id", nullable = false)
    val donation: Donation
)