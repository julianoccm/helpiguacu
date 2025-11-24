package br.com.helpiguacu.backend.infrastructure.persistence.donation

import br.com.helpiguacu.backend.domain.model.donation.StatusDonation
import br.com.helpiguacu.backend.infrastructure.persistence.donationitem.DonationItem
import br.com.helpiguacu.backend.infrastructure.persistence.user.User
import jakarta.persistence.CascadeType
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.FetchType
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.OneToMany
import jakarta.persistence.Table
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedDate
import java.time.LocalDateTime

@Entity
@Table(name = "donations")
class Donation(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(nullable = false)
    val id: Long? = null,

    @Column(nullable = false)
    val title: String,

    @Column(nullable = false)
    val description: String,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    val donor: User,

    @Enumerated(EnumType.STRING)
    var status: StatusDonation = StatusDonation.PENDENTE_COLETA,

    @CreatedDate
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @LastModifiedDate
    var updatedAt: LocalDateTime = LocalDateTime.now(),

    @OneToMany(
        mappedBy = "donation",
        cascade = [CascadeType.ALL],
        orphanRemoval = true
    )
    val items: MutableList<DonationItem> = mutableListOf()
)