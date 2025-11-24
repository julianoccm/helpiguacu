package br.com.helpiguacu.backend.resource.donation

import br.com.helpiguacu.backend.domain.model.donation.DonationFacade
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/donations/v1")
@Tag(name = "Donations Controller", description = "Donations APIs")
class DonationController (
    private val donationFacade: DonationFacade
) {
    @PostMapping
    fun createDonation(@RequestBody donation: DonationRepresentation): ResponseEntity<DonationRepresentation> {
        val createdDonation = donationFacade.createDonation(donation)
        return ResponseEntity.ok(createdDonation)
    }

    @GetMapping("/{id}")
    fun getDonationById(@PathVariable id: Long): ResponseEntity<DonationRepresentation> {
        val donation = donationFacade.getDonationById(id)
        return ResponseEntity.ok(donation)
    }

    @GetMapping
    fun listAllDonations(): ResponseEntity<List<DonationRepresentation>> {
        val donations = donationFacade.listAllDonations()
        return ResponseEntity.ok(donations)
    }

    @GetMapping("/donor/{donorId}")
    fun listDonationsByDonor(@PathVariable donorId: Long): ResponseEntity<List<DonationRepresentation>> {
        val donations = donationFacade.listDonationsByDonor(donorId)
        return ResponseEntity.ok(donations)
    }

    @PutMapping("/{id}/status/{status}")
    fun updateDonationStatus(@PathVariable id: Long, @PathVariable status: String): ResponseEntity<DonationRepresentation> {
        val updatedDonation = donationFacade.updateDonationStatus(id, status)
        return ResponseEntity.ok(updatedDonation)
    }
}