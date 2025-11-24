package br.com.helpiguacu.backend.resource.donation

import br.com.helpiguacu.backend.infrastructure.persistence.donation.Donation
import br.com.helpiguacu.backend.infrastructure.persistence.donationitem.DonationItem

fun DonationItem.toRepresentation(): DonationItemRepresentation =
    DonationItemRepresentation(
        name = this.name,
        quantity = this.quantity,
        observation = this.observation
    )

fun DonationItemRepresentation.toDomain(donation: Donation): DonationItem =
    DonationItem(
        name = this.name,
        quantity = this.quantity,
        observation = this.observation,
        donation = donation
    )