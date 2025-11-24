package br.com.helpiguacu.backend.application.authentication

import br.com.helpiguacu.backend.domain.exception.AuthenticationException
import br.com.helpiguacu.backend.infrastructure.persistence.user.User
import br.com.helpiguacu.backend.infrastructure.persistence.user.UserRepository
import br.com.helpiguacu.backend.infrastructure.security.JwtUtils
import br.com.helpiguacu.backend.resource.authentication.UserRepresentation
import io.mockk.every
import io.mockk.mockk
import io.mockk.slot
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime
import kotlin.test.Test
import kotlin.test.assertEquals

class AuthenticationServiceImplTest {

    private val userRepository = mockk<UserRepository>()
    private val jwtUtils = mockk<JwtUtils>()
    private val passwordEncoder = mockk<PasswordEncoder>()

    private lateinit var service: AuthenticationServiceImpl
    private lateinit var userEntity: User

    @BeforeEach
    fun setup() {
        service = AuthenticationServiceImpl(userRepository, jwtUtils, passwordEncoder)

        userEntity  = User(
            id = 1L,
            name = "Name",
            cpf = "12345678900",
            email = "test@test.com",
            password = "123",
            cep = "85851000",
            addresNumber = "100",
            addresComplement = "house",
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now(),
        )
    }

    @Test
    fun `login should return token and user when valid`() {
        every { userRepository.findByEmail("test@test.com") } returns userEntity
        every { passwordEncoder.matches(any(), any()) } returns true
        every { jwtUtils.generateToken("test@test.com") } returns "jwt-token-value"

        val result = service.login("test@test.com", "123")

        assertEquals("jwt-token-value", result.token)
        assertEquals("test@test.com", result.user.email)

        verify { userRepository.findByEmail("test@test.com") }
        verify { passwordEncoder.matches(any(), any()) }
        verify { jwtUtils.generateToken("test@test.com") }
    }

    @Test
    fun `login should throw when user not found`() {
        every { userRepository.findByEmail("abc@test.com") } returns null

        val ex = assertThrows(AuthenticationException::class.java) {
            service.login("abc@test.com", "123")
        }

        assertEquals("User not found!", ex.message)
    }

    @Test
    fun `login should throw when password invalid`() {
        every { userRepository.findByEmail("test@test.com") } returns userEntity
        every { passwordEncoder.matches(any(), any()) } returns false

        val ex = assertThrows(AuthenticationException::class.java) {
            service.login("test@test.com", "wrong")
        }

        assertEquals("Invalid password!", ex.message)
    }

    @Test
    fun `getAuthentication should return UsernamePasswordAuthenticationToken`() {
        every { userRepository.findByEmail("test@test.com") } returns userEntity

        val auth = service.getAuthentication("test@test.com")

        assertTrue(auth is UsernamePasswordAuthenticationToken)

        verify { userRepository.findByEmail("test@test.com") }
    }

    @Test
    fun `getAuthentication should throw when user not found`() {
        every { userRepository.findByEmail("missing@test.com") } returns null

        val ex = assertThrows(AuthenticationException::class.java) {
            service.getAuthentication("missing@test.com")
        }

        assertEquals("User not found!", ex.message)
    }

    @Test
    fun `register should encode password and save user`() {
        val representation = UserRepresentation(
            id = 1L,
            name = "Name",
            cpf = "12345678900",
            email = "test@test.com",
            password = "123",
            cep = "85851000",
            addresNumber = "100",
            addresComplement = "house"
        )
        val entityToSave = slot<User>()

        every { passwordEncoder.encode("123") } returns "encoded123"

        every { userRepository.save(capture(entityToSave)) } answers {
            entityToSave.captured.copy(id = 99L)
        }

        val result = service.register(representation)

        assertEquals(99L, result.id)
        assertEquals("test@test.com", result.email)
        assertEquals("Name", result.name)

        verify { passwordEncoder.encode("123") }
        verify { userRepository.save(any()) }
    }
}
