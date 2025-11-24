package br.com.helpiguacu.backend.application.donation

import br.com.helpiguacu.backend.domain.model.donation.DonationFacade
import br.com.helpiguacu.backend.domain.model.donation.DonationService
import br.com.helpiguacu.backend.resource.donation.DonationRepresentation
import org.springframework.stereotype.Service

@Service
class DonationFacadeImpl(
    private val donationService: DonationService,
): DonationFacade {

    override fun createDonation(donation: DonationRepresentation): DonationRepresentation {
        return donationService.createDonation(donation)
    }

    override fun getDonationById(id: Long): DonationRepresentation {
        return donationService.getDonationById(id)
    }

    override fun updateDonationStatus(
        id: Long,
        status: String
    ): DonationRepresentation {
        return donationService.updateDonationStatus(id, status)
    }

    override fun listDonationsByDonor(donorId: Long): List<DonationRepresentation> {
        return donationService.listDonationsByDonor(donorId)
    }

    override fun listAllDonations(): List<DonationRepresentation> {
        return donationService.listAllDonations()
    }

    override fun deleteDonation(id: Long) {
        donationService.deleteDonation(id)
    }
}