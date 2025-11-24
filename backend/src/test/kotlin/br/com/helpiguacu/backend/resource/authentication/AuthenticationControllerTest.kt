package br.com.helpiguacu.backend.resource.authentication


import br.com.helpiguacu.backend.domain.exception.AuthenticationException
import br.com.helpiguacu.backend.domain.model.authentication.AuthenticationFacade
import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.http.HttpStatus

class AuthenticationControllerTest {

    private val authenticationFacade = mockk<AuthenticationFacade>()
    private lateinit var controller: AuthenticationController

    private lateinit var loginRequest: AuthenticationRequestRepresentation
    private lateinit var userRequest: UserRepresentation
    private lateinit var loginResponse: AuthenticationResponseRepresentation
    private lateinit var userResponse: UserRepresentation

    @BeforeEach
    fun setup() {
        controller = AuthenticationController(authenticationFacade)

        loginRequest = AuthenticationRequestRepresentation(
            username = "john@test.com",
            password = "123"
        )

        userRequest = UserRepresentation(
            id = 1L,
            name = "John",
            cpf = "00000000000",
            email = "john@test.com",
            password = "123",
            cep = "80000-000",
            addresNumber = "10",
            addresComplement = "Apto 1"
        )

        loginResponse = AuthenticationResponseRepresentation(
            token = "abc123",
            user = userRequest
        )

        userResponse = userRequest.copy(id = 1L)
    }

    @Test
    fun `login should return 200 OK when authentication succeeds`() {
        every { authenticationFacade.login("john@test.com", "123") } returns loginResponse

        val result = controller.login(loginRequest)

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals("abc123", result.body!!.token)
        assertEquals("john@test.com", result.body!!.user.email)
    }

    @Test
    fun `login should return 400 BAD REQUEST when authentication fails`() {
        every { authenticationFacade.login("john@test.com", "123") } throws AuthenticationException("invalid")

        val result = controller.login(loginRequest)

        assertEquals(HttpStatus.BAD_REQUEST, result.statusCode)
        assertEquals(null, result.body)
    }

    @Test
    fun `register should return 200 OK when registration succeeds`() {
        every { authenticationFacade.register(userRequest) } returns userResponse

        val result = controller.register(userRequest)

        assertEquals(HttpStatus.OK, result.statusCode)
        assertEquals(1L, result.body!!.id)
        assertEquals("John", result.body!!.name)
    }

    @Test
    fun `register should return 400 BAD REQUEST when registration fails`() {
        every { authenticationFacade.register(userRequest) } throws AuthenticationException("error")

        val result = controller.register(userRequest)

        assertEquals(HttpStatus.BAD_REQUEST, result.statusCode)
        assertEquals(null, result.body)
    }
}