package br.com.helpiguacu.backend.domain.model.donation

import br.com.helpiguacu.backend.resource.donation.DonationRepresentation

interface DonationFacade {
    fun createDonation(donation: DonationRepresentation): DonationRepresentation
    fun getDonationById(id: Long): DonationRepresentation
    fun updateDonationStatus(id: Long, status: String): DonationRepresentation
    fun listDonationsByDonor(donorId: Long): List<DonationRepresentation>
    fun listAllDonations(): List<DonationRepresentation>
    fun deleteDonation(id: Long)
}