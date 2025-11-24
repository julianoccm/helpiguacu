package br.com.helpiguacu.backend.resource.donation

import br.com.helpiguacu.backend.domain.model.donation.StatusDonation
import br.com.helpiguacu.backend.infrastructure.persistence.donation.Donation
import br.com.helpiguacu.backend.infrastructure.persistence.user.User

fun Donation.toRepresentation(): DonationRepresentation {
    return DonationRepresentation(
        id = this.id,
        title = this.title,
        description = this.description,
        donorId = this.donor.id,
        status = this.status.name,
        createdAt = this.createdAt,
        updatedAt = this.updatedAt,
        items = this.items.map { it.toRepresentation() }
    )
}

fun DonationRepresentation.toDomain(donor: User): Donation {
    val donation = Donation(
        id = this.id,
        title = this.title,
        description = this.description,
        donor = donor,
        status = StatusDonation.valueOf(this.status),
        items = mutableListOf()
    )

    val items = this.items.map { it.toDomain(donation) }
    donation.items.addAll(items)

    return donation
}