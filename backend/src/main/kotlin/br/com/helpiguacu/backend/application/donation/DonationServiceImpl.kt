package br.com.helpiguacu.backend.application.donation

import br.com.helpiguacu.backend.domain.exception.DonorNotFoundException
import br.com.helpiguacu.backend.domain.model.donation.DonationService
import br.com.helpiguacu.backend.domain.model.donation.StatusDonation
import br.com.helpiguacu.backend.infrastructure.persistence.donation.DonationRepository
import br.com.helpiguacu.backend.infrastructure.persistence.user.UserRepository
import br.com.helpiguacu.backend.resource.donation.DonationRepresentation
import br.com.helpiguacu.backend.resource.donation.toDomain
import br.com.helpiguacu.backend.resource.donation.toRepresentation
import org.springframework.stereotype.Service

@Service
class DonationServiceImpl(
    private val donationRepository: DonationRepository,
    private val userRepository: UserRepository
): DonationService {
    override fun createDonation(donation: DonationRepresentation): DonationRepresentation {
        val donor = userRepository.findById(donation.donorId).orElseThrow {
            DonorNotFoundException("Donor with id ${donation.donorId} not found.")
        }

        val entity = donation.toDomain(donor)
        val savedDonation = donationRepository.save(entity)

        return savedDonation.toRepresentation()
    }

    override fun getDonationById(id: Long): DonationRepresentation {
        val donation = donationRepository.findById(id)
            .orElseThrow { DonorNotFoundException("Donation with id ${id} not found.") }

        return donation.toRepresentation()
    }

    override fun updateDonationStatus(
        id: Long,
        status: String
    ): DonationRepresentation {
        val donation = donationRepository.findById(id)
            .orElseThrow { DonorNotFoundException("Donation with id ${id} not found.") }

        donation.status = StatusDonation.valueOf(status)
        val saved = donationRepository.save(donation)

        return saved.toRepresentation()
    }

    override fun listDonationsByDonor(donorId: Long): List<DonationRepresentation> {
        return donationRepository.findByDonorId(donorId)
            .map { it.toRepresentation() }
    }

    override fun listAllDonations(): List<DonationRepresentation> {
        return donationRepository.findAll()
            .map { it.toRepresentation() }
    }
}