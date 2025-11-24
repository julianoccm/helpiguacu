package br.com.helpiguacu.backend.resource.donation

import br.com.helpiguacu.backend.domain.model.donation.DonationFacade
import io.mockk.every
import io.mockk.justRun
import io.mockk.mockk
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.http.HttpStatus
import java.time.LocalDateTime

class DonationControllerTest {

    private val donationFacade = mockk<DonationFacade>()
    private lateinit var controller: DonationController

    private lateinit var donation: DonationRepresentation
    private lateinit var donationList: List<DonationRepresentation>

    @BeforeEach
    fun setup() {
        controller = DonationController(donationFacade)

        donation = DonationRepresentation(
            id = 1L,
            title = "Titulo",
            description = "Descricao",
            donorId = 10L,
            status = "PENDENTE_COLETA",
            createdAt = LocalDateTime.of(2025, 1, 10, 12, 0),
            updatedAt = LocalDateTime.of(2025, 1, 10, 12, 0),
            items = listOf(
                DonationItemRepresentation(
                    name = "Item 1",
                    quantity = 2,
                    observation = "Obs"
                )
            )
        )

        donationList = listOf(donation)
    }

    @Test
    fun `createDonation should return 200 OK`() {
        every { donationFacade.createDonation(donation) } returns donation

        val result = controller.createDonation(donation)

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals(1L, result.body!!.id)
        assertEquals("Titulo", result.body!!.title)
        assertEquals("Item 1", result.body!!.items[0].name)
    }

    @Test
    fun `getDonationById should return 200 OK`() {
        every { donationFacade.getDonationById(1L) } returns donation

        val result = controller.getDonationById(1L)

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals(1L, result.body!!.id)
        assertEquals("Descricao", result.body!!.description)
    }

    @Test
    fun `listAllDonations should return 200 OK`() {
        every { donationFacade.listAllDonations() } returns donationList

        val result = controller.listAllDonations()

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals(1, result.body!!.size)
        assertEquals(10L, result.body!![0].donorId)
    }

    @Test
    fun `listDonationsByDonor should return 200 OK`() {
        every { donationFacade.listDonationsByDonor(10L) } returns donationList

        val result = controller.listDonationsByDonor(10L)

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals("PENDENTE_COLETA", result.body!![0].status)
    }

    @Test
    fun `updateDonationStatus should return 200 OK`() {
        val updatedDonation = donation.copy(status = "COLETADA")
        every { donationFacade.updateDonationStatus(1L, "COLETADA") } returns updatedDonation

        val result = controller.updateDonationStatus(1L, "COLETADA")

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals("COLETADA", result.body!!.status)
    }

    @Test
    fun `deleteDonation should return 204 NO CONTENT`() {
        justRun { donationFacade.deleteDonation(1L) }

        val result = controller.deleteDonation(1L)

        assertEquals(HttpStatus.NO_CONTENT, result.statusCode)
    }
}