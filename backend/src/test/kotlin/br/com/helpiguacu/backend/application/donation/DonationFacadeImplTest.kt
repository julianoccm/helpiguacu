package br.com.helpiguacu.backend.application.donation

import br.com.helpiguacu.backend.domain.model.donation.DonationService
import br.com.helpiguacu.backend.resource.donation.DonationRepresentation
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertSame
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith


@ExtendWith(MockKExtension::class)
class DonationFacadeImplTest {

    @MockK
    lateinit var donationService: DonationService

    @Test
    fun `createDonation delegates to service and returns saved representation`() {
        val facade = DonationFacadeImpl(donationService)
        val request = mockk<DonationRepresentation>()
        val expected = mockk<DonationRepresentation>()

        every { donationService.createDonation(request) } returns expected

        val actual = facade.createDonation(request)

        assertSame(expected, actual)
        verify { donationService.createDonation(request) }
    }

    @Test
    fun `getDonationById delegates to service and returns representation`() {
        val facade = DonationFacadeImpl(donationService)
        val id = 123L
        val expected = mockk<DonationRepresentation>()

        every { donationService.getDonationById(id) } returns expected

        val actual = facade.getDonationById(id)

        assertSame(expected, actual)
        verify { donationService.getDonationById(id) }
    }

    @Test
    fun `updateDonationStatus delegates to service and returns updated representation`() {
        val facade = DonationFacadeImpl(donationService)
        val id = 10L
        val status = "COMPLETED"
        val expected = mockk<DonationRepresentation>()

        every { donationService.updateDonationStatus(id, status) } returns expected

        val actual = facade.updateDonationStatus(id, status)

        assertSame(expected, actual)
        verify { donationService.updateDonationStatus(id, status) }
    }

    @Test
    fun `listDonationsByDonor delegates to service and returns list`() {
        val facade = DonationFacadeImpl(donationService)
        val donorId = 5L
        val expected = listOf(mockk<DonationRepresentation>())

        every { donationService.listDonationsByDonor(donorId) } returns expected

        val actual = facade.listDonationsByDonor(donorId)

        assertSame(expected, actual)
        verify { donationService.listDonationsByDonor(donorId) }
    }

    @Test
    fun `listAllDonations delegates to service and returns list`() {
        val facade = DonationFacadeImpl(donationService)
        val expected = listOf(mockk<DonationRepresentation>())

        every { donationService.listAllDonations() } returns expected

        val actual = facade.listAllDonations()

        assertSame(expected, actual)
        verify { donationService.listAllDonations() }
    }

    @Test
    fun `deleteDonation delegates to service`() {
        val facade = DonationFacadeImpl(donationService)
        val id = 7L

        every { donationService.deleteDonation(id) } returns Unit

        facade.deleteDonation(id)

        verify { donationService.deleteDonation(id) }
    }
}