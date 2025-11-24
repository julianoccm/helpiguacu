package br.com.helpiguacu.backend.application.donation

import br.com.helpiguacu.backend.domain.exception.DonorNotFoundException
import br.com.helpiguacu.backend.domain.model.donation.StatusDonation
import br.com.helpiguacu.backend.infrastructure.persistence.donation.Donation
import br.com.helpiguacu.backend.infrastructure.persistence.donation.DonationRepository
import br.com.helpiguacu.backend.infrastructure.persistence.donationitem.DonationItem
import br.com.helpiguacu.backend.infrastructure.persistence.user.User
import br.com.helpiguacu.backend.infrastructure.persistence.user.UserRepository
import br.com.helpiguacu.backend.resource.donation.DonationRepresentation
import io.mockk.*
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.time.LocalDateTime
import java.util.*

class DonationServiceImplTest {

    private val donationRepository = mockk<DonationRepository>()
    private val userRepository = mockk<UserRepository>()
    private lateinit var service: DonationServiceImpl

    private lateinit var donor: User
    private lateinit var donationEntity: Donation
    private lateinit var donationRepresentation: DonationRepresentation

    @BeforeEach
    fun setup() {
        service = DonationServiceImpl(donationRepository, userRepository)

        donor = User(
            id = 1L,
            name = "John",
            cpf = "99999999999",
            email = "john@test.com",
            password = "pass",
            cep = "00000",
            addresNumber = "100",
            addresComplement = "A",
        )

        donationEntity = Donation(
            id = 10L,
            donor = donor,
            description = "Food",
            status = StatusDonation.PENDENTE_COLETA,
            title = "Titutlo",
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now(),
            items = mutableListOf()
        )

        val item = DonationItem(
            id = 100L,
            name = "Rice",
            quantity = 5,
            observation = "No observations",
            donation = donationEntity
        )

        donationEntity.items.add(item)

        donationRepresentation = DonationRepresentation(
            id = null,
            donorId = 1L,
            description = "Food",
            status = "PENDENTE_COLETA",
            title = "Titutlo",
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now(),
            items = mutableListOf()
        )
    }

    @Test
    fun `createDonation should save and return representation`() {
        every { userRepository.findById(1L) } returns Optional.of(donor)
        every { donationRepository.save(any()) } returns donationEntity

        val result = service.createDonation(donationRepresentation)

        assertEquals(10L, result.id)
        assertEquals("Food", result.description)
        assertEquals("PENDENTE_COLETA", result.status)

        verify { userRepository.findById(1L) }
        verify { donationRepository.save(any()) }
    }

    @Test
    fun `createDonation should throw when donor not found`() {
        every { userRepository.findById(1L) } returns Optional.empty()

        val ex = assertThrows(DonorNotFoundException::class.java) {
            service.createDonation(donationRepresentation)
        }

        assertTrue(ex.message!!.contains("Donor with id 1 not found"))
    }

    @Test
    fun `getDonationById should return donation`() {
        every { donationRepository.findById(10L) } returns Optional.of(donationEntity)

        val result = service.getDonationById(10L)

        assertEquals("Food", result.description)
        verify { donationRepository.findById(10L) }
    }

    @Test
    fun `getDonationById should throw when not found`() {
        every { donationRepository.findById(10L) } returns Optional.empty()

        val ex = assertThrows(DonorNotFoundException::class.java) {
            service.getDonationById(10L)
        }

        assertTrue(ex.message!!.contains("Donation with id 10 not found"))
    }

    @Test
    fun `updateDonationStatus should update status and return representation`() {
        every { donationRepository.findById(10L) } returns Optional.of(donationEntity)
        every { donationRepository.save(any()) } returns donationEntity.apply {
            status = StatusDonation.FINALIZADA
        }

        val result = service.updateDonationStatus(10L, "FINALIZADA")

        assertEquals("FINALIZADA", result.status)
        verify { donationRepository.findById(10L) }
        verify { donationRepository.save(any()) }
    }

    @Test
    fun `updateDonationStatus should throw when donation not found`() {
        every { donationRepository.findById(10L) } returns Optional.empty()

        val ex = assertThrows(DonorNotFoundException::class.java) {
            service.updateDonationStatus(10L, "FINALIZADA")
        }

        assertTrue(ex.message!!.contains("Donation with id 10 not found"))
    }

    @Test
    fun `listDonationsByDonor should return list`() {
        every { donationRepository.findByDonorId(1L) } returns listOf(donationEntity)

        val result = service.listDonationsByDonor(1L)

        assertEquals(1, result.size)
        assertEquals("Food", result[0].description)

        verify { donationRepository.findByDonorId(1L) }
    }

    @Test
    fun `listAllDonations should return list`() {
        every { donationRepository.findAll() } returns listOf(donationEntity)

        val result = service.listAllDonations()

        assertEquals(1, result.size)
        assertEquals("Food", result[0].description)

        verify { donationRepository.findAll() }
    }

    @Test
    fun `deleteDonation should call repository`() {
        every { donationRepository.deleteById(10L) } just Runs

        service.deleteDonation(10L)

        verify { donationRepository.deleteById(10L) }
    }
}